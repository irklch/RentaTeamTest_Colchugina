//
//  Network.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import Foundation

//MARK: - NetworkLayerProtocol

protocol NetworkLayerProtocol: AnyObject {
    func fetchPosts(complition: @escaping(Result<[PhotosUrls], Error>) -> Void)
}

// MARK: - NetworkLayer

final class NetworkLayer: NetworkLayerProtocol {

    // MARK: - Public methods

    func fetchPosts(complition: @escaping(Result<[PhotosUrls], Error>) -> Void) {
        downloadJson(url: URLs.getPhotos, completion: complition)
    }

    // MARK: - Private methods

    private func downloadJson<T: Decodable>(url: String, completion: @escaping(Result<[T], Error>) -> Void) {

        guard let url = URL(string: url) else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { data, response, eror in
            if let error = eror {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let json = try JSONDecoder().decode([T].self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
