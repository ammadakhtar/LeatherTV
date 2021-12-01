//
//  CardTransitionManager.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import UIKit

enum CardViewMode {
    case full
    case card
}

enum CardTransitionType {
    case presentation
    case dismissal

    var cardMode: CardViewMode { return self == .presentation ? .card : .full }
    var next: CardTransitionType { return self == .presentation ? .dismissal : .presentation }
}

final class CardTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    // MARK: - Variables
    
    let transitionDuration: Double = 1.0
    var transition: CardTransitionType = .presentation
    let shrinkDuration: Double = 0.2
    var innerShowView: ShowView?
    var presentngFrame: CGRect?

    // MARK: Helper Methods

    private func createShowViewCopy(showView: ShowView) -> ShowView {
        let copyShowView = ShowView()
        copyShowView.track = showView.track
        copyShowView.configure()
        return copyShowView
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })

        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        guard let showView = (transition == .presentation) ? (fromViewController as! DiscoveryViewController).selectedCellShowView() : (toViewController as! DiscoveryViewController).selectedCellShowView() else { return }
        let showViewCopy = createShowViewCopy(showView: showView)
        containerView.addSubview(showViewCopy)
        showView.isHidden = true

        let absoluteCardViewFrame = showView.convert(showView.frame, to: nil)
        showViewCopy.frame = absoluteCardViewFrame
        self.presentngFrame = absoluteCardViewFrame
        showViewCopy.layoutIfNeeded()

        showViewCopy.frame = transition == .presentation ? showViewCopy.frame : containerView.frame
        innerShowView = showViewCopy

        if transition == .presentation {
            let detailViewController = toViewController as! DetailViewController
            containerView.addSubview(detailViewController.view)
            detailViewController.viewsAreHidden = true

            moveAndConvertToCardView(showView: showViewCopy, containerView: containerView, yOriginToMoveTo: showViewCopy.frame.origin.y) {
                detailViewController.viewsAreHidden = false
                showViewCopy.removeFromSuperview()
                showView.isHidden = false
                detailViewController.createSnapshotOfView()
                transitionContext.completeTransition(true)
            }

        } else {
            // Dismissal
            let detailViewController = fromViewController as! DetailViewController
            detailViewController.viewsAreHidden = true

            showViewCopy.frame = CGRect(x: 0, y: 0, width: (detailViewController.showView.frame.size.width), height: (detailViewController.showView.frame.size.height))

            moveAndConvertToCardView(showView: showViewCopy, containerView: containerView, yOriginToMoveTo: absoluteCardViewFrame.origin.y) {
                showView.isHidden = false
                transitionContext.completeTransition(true)
            }
        }
    }

    func makeExpandContractAnimator(for showView: ShowView, in containerView: UIView, yOrigin: CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 4))
        let animator = UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)

        animator.addAnimations {
            showView.transform = .identity
            showView.frame.origin.y = yOrigin
            containerView.layoutIfNeeded()

            let newFullFrame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: containerView.frame.height)
            self.innerShowView?.frame = self.transition == .presentation ? newFullFrame : self.presentngFrame!
        }

        return animator
    }

    func moveAndConvertToCardView(showView: ShowView, containerView: UIView, yOriginToMoveTo: CGFloat, completion: @escaping () -> ()) {

        let expandContractAnimator = makeExpandContractAnimator(for: showView, in: containerView, yOrigin: yOriginToMoveTo)

        expandContractAnimator.addCompletion { _ in
            completion()
        }
        
        showView.layoutIfNeeded()
        showView.updateLayout(for: self.transition.next.cardMode)
        expandContractAnimator.startAnimation()
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .presentation
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .dismissal
        return self
    }
}
