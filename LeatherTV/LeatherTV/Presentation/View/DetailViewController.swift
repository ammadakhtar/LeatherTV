//
//  DetailViewController.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 30/11/2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var showView: ShowView = {
        let showView = ShowView()
        return showView
    }()
    
    private lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.setImage(UIImage(named: "lightOnDark")!, for: UIControl.State.normal)
        return button
    }()
    
    var viewsAreHidden: Bool = false {
        didSet {
            closeButton.isHidden = viewsAreHidden
            showView.isHidden = viewsAreHidden
            view.backgroundColor = .clear
        }
    }
    
    private var track: Track?
    
    // MARK: - Init
    
    init(track: Track) {
        self.track = track
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        setupUI()
        
        showView.track = track
        showView.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: -
    
    func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeGesture.delegate = self
        swipeGesture.direction = .down
        scrollView.addGestureRecognizer(swipeGesture)

        view.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        showView.updateLayout(for: .full)
        scrollView.addSubview(showView)
        showView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            showView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            showView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            showView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0)
        ])
    }
    
    func createSnapshotOfView() {
        let snapshotImage = view.createSnapshot()
        snapshotView.image = snapshotImage
        scrollView.addSubview(snapshotView)
        
        let topPadding = UIWindow.topPadding
        snapshotView.frame = CGRect(x: 0, y: -topPadding, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            close()
        }
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
