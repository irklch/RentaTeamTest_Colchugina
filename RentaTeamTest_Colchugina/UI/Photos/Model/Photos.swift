//
//  Photos.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import Foundation
import RealmSwift

final class PhotosUrls: Decodable {
    var id = ""
    var alt_description: String?
    var urls = PhotosSizes()
}

final class PhotosSizes: Decodable {
    var small = ""
}

final class Photos: Object {
    @objc dynamic var id = ""
    @objc dynamic var photoDescription = ""
    @objc dynamic var url = ""
    @objc dynamic var dateOfDownloading = ""

    override static func primaryKey() -> String? {
            return "id"
        }

    convenience init(id: String, photoDescription: String, url: String, dateOfDownloading: String) {
        self.init()

        self.id = id
        self.photoDescription = photoDescription
        self.url = url
        self.dateOfDownloading = dateOfDownloading
    }

}
