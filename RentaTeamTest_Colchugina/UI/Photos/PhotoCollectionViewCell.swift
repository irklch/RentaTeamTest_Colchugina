//
//  PhotoCollectionViewCell.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Public properties
    
    static let reusableID = "PhotoCollectionViewCell"
    
    //MARK:- Private properties
    
    private let photoImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    //MARK:- Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public methods
    
    func configur(id: String, description: String) {
        if id != "" {
            photoImageView.image = DocumentDirectory.loadImage(id: id)
            descriptionLabel.text =  description
        } else {
            photoImageView.image = UIImage.loadPlaceholder()
            descriptionLabel.text =  "No photo"
        }
    }
    
    //MARK:- Private methods
    
    private func setViews() {
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
        photoImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 15)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 2
    }
    
}
