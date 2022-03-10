//
//  UserNetworkProvider.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 10/03/22.
//

import Foundation

protocol DetailUserNetworkProvider {
    func fetchDetailUser(username: String, completion: @escaping ((Result<DetailUserModel, BaseError>) -> Void))
}

struct DetailUserUseCase: DetailUserNetworkProvider {
    func fetchDetailUser(username: String, completion: @escaping ((Result<DetailUserModel, BaseError>) -> Void)) {
        let urlString = "\(Constants.baseURL)users/\(username)"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.errorNetwork))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let user = try JSONDecoder().decode(DetailUserModel.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidDecoding))
            }
        }.resume()
    }
}
