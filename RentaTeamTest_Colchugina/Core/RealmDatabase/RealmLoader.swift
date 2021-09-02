//
//  PhotoRealmDatabase.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import Foundation
import RealmSwift

final class RealmLoader {

    //MARK:- Public methods
    
    static func savePhotos(jsonItems: [PhotosUrls]) {
        var photosList = [Photos]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        jsonItems.forEach { jsonItem in
            let date = Date()
            let photo = Photos(
                id: jsonItem.id,
                photoDescription: jsonItem.alt_description ?? "No description",
                url: jsonItem.urls.small,
                dateOfDownloading: dateFormatter.string(from: date)
            )
            DocumentDirectory.saveImage(urlString: photo.url, imageId: photo.id)
            photosList.append(photo)
        }

        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photosList, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

}
