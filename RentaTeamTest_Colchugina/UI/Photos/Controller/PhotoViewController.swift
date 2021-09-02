//
//  PhotoViewController.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import UIKit
import RealmSwift

final class PhotoViewController: UIViewController {

    //MARK:- Private properties

    private var photoCollectionView: UICollectionView?
    private var photosLists = [Photos]()

    //MARK:- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotoList()
        setView()
    }

    //MARK:- Private methods
    
    private func getPhotoList() {
        if NetworkMonitor.shared.isConnected {
            let network = NetworkLayer()
            network.fetchPosts { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let photos):
                    RealmLoader.savePhotos(jsonItems: photos)
                    DispatchQueue.main.async {
                        self.readRealm()
                        self.photoCollectionView?.reloadData()
                    }
                }
            }
        }
        else {
            readRealm()
            photoCollectionView?.reloadData()
        }
    }

    private func readRealm() {
        let photosRealmLists: Results<Photos>?
        do {
            let realm = try Realm()
            if realm.isEmpty {
                let photo = Photos(id: "", photoDescription: "", url: "", dateOfDownloading: "")
                photosLists.append(photo)
            } else {
                let photosData = realm.objects(Photos.self)
                photosRealmLists = photosData
                guard let items = photosRealmLists else {return}
                items.forEach { item in
                    photosLists.append(item)
                }
            }
        } catch {
            print(error)
        }
    }

}

//MARK:- UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK:- Life cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollectionView?.frame = view.bounds
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosLists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reusableID, for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        cell.configur(id: photosLists[indexPath.row].id,
                      description: photosLists[indexPath.row].photoDescription)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OpenPhotoViewController(photoList: photosLists, indexPathRow: indexPath.row)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }


    //MARK:- Private methods

    private func setView() {



        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width/3)-4,
                                 height:  (view.frame.height/3)-4)

        photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.photoCollectionView?.dataSource = self
        self.photoCollectionView?.delegate = self
        photoCollectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reusableID)
        photoCollectionView?.backgroundColor = .white
        view.addSubview(photoCollectionView ?? UICollectionView())
    }

}

//MARK:- UICollectionViewDelegate

//extension PhotoViewController: UICollectionViewDelegate {}
