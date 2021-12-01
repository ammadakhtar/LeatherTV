//
//  ShowView.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 30/11/2021.
//

import UIKit

final class ShowView: UIView {
    
    // MARK: - Variables
    
    private lazy var trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholderDark")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var progressBar: CircularProgressView = {
        let progressBar = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        progressBar.isHidden = true
        progressBar.isOpaque = true
        progressBar.progressColor = .purple
        return progressBar
    }()
    
    var track: Track?
    
    // MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Functions
    
    private func setupConstraint() {
        self.backgroundColor = .black
        
        [trackImageView, nameLabel, progressBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [nameLabel, trackImageView, progressBar].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            trackImageView.topAnchor.constraint(equalTo: self.topAnchor),
            trackImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            trackImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            trackImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            trackImageView.heightAnchor.constraint(equalToConstant: 184),
            trackImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressBar.widthAnchor.constraint(equalToConstant: 150),
            progressBar.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        self.bringSubviewToFront(nameLabel)
    }
    
    func configure() {
        nameLabel.text = self.track?.title
        ImageDownloader.getImage(urlString: self.track?.backgroundContent.sourcePath ?? "") {[weak self] image in
            self?.trackImageView.image = image
        }
    }
    
    func updateLayout(for viewMode: CardViewMode) {
        
        if viewMode == .card {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            progressBar.isHidden = true
        } else {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
            progressBar.isHidden = false
            progressBar.setProgressWithAnimation(duration: 0.7, value: 1.0)
        }
    }
}
