//
//  UserModel.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import Foundation

struct UserModel: Codable {
    let totalCount: Int
    let items: [User]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct User: Codable, Equatable {
    let id: Int
    let username: String
    let avatar: String
    let url: String

    private enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case avatar = "avatar_url"
        case url = "html_url"
    }
}
