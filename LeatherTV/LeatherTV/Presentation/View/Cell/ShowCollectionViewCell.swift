//
//  ShowCollectionViewCell.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import UIKit

final class ShowCollectionViewCell: UICollectionViewCell {

    lazy var showView: ShowView = {
        let containerView = ShowView()
        containerView.clipsToBounds = true
        return containerView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showView.track = nil
        showView.configure()
    }

    private func setupUI() {
        contentView.addSubview(showView)
        showView.frame = contentView.frame
    }

    func configure(track: Track) {
        showView.track = track
        showView.configure()
    }
}
