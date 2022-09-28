//
//  SearchViewModel.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import Foundation

class SearchViewModel {
    let useCase: UsersNetwokProvider

    // MARK: - Init
    init(useCase: UsersNetwokProvider) {
        self.useCase = useCase
    }

    // MARK: - Properties
    var users: [User] = []

    // MARK: - Output
    var didReceiveUsers: (() -> Void)?
    var didReceiveError: ((BaseError) -> Void)?

    // MARK: - Input
    func didLoadUsers(query: String, page: Int) {
        var result: Result<UserModel, BaseError>?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchUsers(query: query, page: page) { userResult in
            result = userResult
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            guard let result = result else {
                return
            }

            switch result {
            case .success(let data):
                self.users.append(contentsOf: data.items)
                self.didReceiveUsers?()
            case .failure(let error):
                self.users = []
                self.didReceiveError?(error)
            }
        }
    }
}
