//
//  DetailUserViewModel.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 10/03/22.
//

import Foundation

class DetailUserViewModel {
    let useCase: DetailUserNetworkProvider

    // MARK: - Init
    init(useCase: DetailUserNetworkProvider) {
        self.useCase = useCase
    }

    // MARK: - Properties
    var detail: DetailUserModel?

    // MARK: - Output
    var didReceiveDetail: (() -> Void)?
    var didReceiveError: ((BaseError) -> Void)?

    // MARK: - Input
    func didLoadUser(username: String) {
        var result: Result<DetailUserModel, BaseError>?

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchDetailUser(username: username) { detailResult in
            result = detailResult
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            guard let result = result else {
                return
            }

            switch result {
            case .success(let data):
                self.detail = data
                self.didReceiveDetail?()
            case .failure(let error):
                self.didReceiveError?(error)
            }
        }
    }
}
