//
//  DocumentDirectory.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import UIKit

final class DocumentDirectory {

    //MARK:- Public methods
    
    static func saveImage(urlString: String, imageId: String) {
        guard let url = URL(string: urlString) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        guard let dataImage = UIImage(data: data)?.pngData() else {return}
        guard let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
        let photoFileUrl = documentsDirectoryURL.appendingPathComponent(imageId, isDirectory: false)
        FileManager.default.createFile(atPath: photoFileUrl.relativePath, contents: dataImage, attributes: nil)
        do {
            try dataImage.write(to: photoFileUrl)
        } catch let error {
            print(error)
        }
    }
    
    static func loadImage(id: String) -> UIImage? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let imageFileUrl = documentsDirectoryURL.appendingPathComponent(id, isDirectory: false)
        FileManager.default.fileExists(atPath: imageFileUrl.absoluteString)
        guard let imageData = FileManager.default.contents(atPath: imageFileUrl.relativePath) else {return nil}
        return UIImage(data: imageData)
    }

}
