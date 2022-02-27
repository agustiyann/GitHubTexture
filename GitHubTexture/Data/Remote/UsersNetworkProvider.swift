//
//  UsersNetworkProvider.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import Foundation

protocol UsersNetwokProvider {
    func fetchUsers(query: String, completion: @escaping ((Result<UserModel, GUError>) -> Void))
}

struct UsersUseCase: UsersNetwokProvider {
    func fetchUsers(query: String, completion: @escaping ((Result<UserModel, GUError>) -> Void)) {
        let urlString = "\(Constants.baseURL)search/users?q=\(query)"
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
                let users = try JSONDecoder().decode(UserModel.self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.invalidDecoding))
            }
        }.resume()
    }
}
