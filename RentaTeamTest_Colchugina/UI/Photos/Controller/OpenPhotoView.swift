//
//  OpenPhotoViewController.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 31.08.2021.
//

import UIKit

final class OpenPhotoViewController: UIViewController, UIGestureRecognizerDelegate {

    //MARK:- Private properties

    private var indexPath = 0
    private var photoList = [Photos]()
    private let photoImageView = UIImageView()
    private let dateLabel = UILabel()
    private let swipeRight = UISwipeGestureRecognizer()
    private let swipeUpDown = UISwipeGestureRecognizer()
    
    //MARK:- Life cycle

    init(photoList: [Photos], indexPathRow: Int) {
        super.init(nibName: nil, bundle: nil)
        self.indexPath = indexPathRow
        self.photoList = photoList
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        openImage(photoId: photoList[indexPath].id)
    }

    //MARK:- Private methods

    private func setView () {
        view.backgroundColor = .black
        view.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            photoImageView.heightAnchor.constraint(equalToConstant: 500)
        ])

        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill


        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        dateLabel.font = UIFont(name: dateLabel.font.fontName, size: 15)
        dateLabel.textColor = .white

        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }

    private func openImage(photoId id: String) {
        photoImageView.image = DocumentDirectory.loadImage(id: id)
        dateLabel.text = "Download date:  \(photoList[indexPath].dateOfDownloading)"
    }

    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }

    @objc
    private func didSwipe(_ sender: UISwipeGestureRecognizer) {

        switch sender.direction {
        case .up:
            self.dismiss(animated: true, completion: nil)
        case .down:
            self.dismiss(animated: true, completion: nil)
        case .left:
            if indexPath != photoList.count - 1 {
                self.indexPath += 1
                self.openImage(photoId: self.photoList[self.indexPath].id)
            } else {
                self.stopSwiping(translationX: CGFloat(-30))
            }
        case .right:
            if indexPath != 0 {
                self.indexPath -= 1
                self.openImage(photoId: self.photoList[self.indexPath].id)
            }
            else {
                self.stopSwiping(translationX: CGFloat(30))
            }
        default:
            break
        }
    }

    private func stopSwiping (translationX: CGFloat) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.9,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: ({ self.photoImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                       }), completion: { _ in self.photoImageView.transform = .identity})
    }

}
