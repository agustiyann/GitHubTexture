//
//  DetailUserModel.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 10/03/22.
//

import Foundation

struct DetailUserModel: Codable, Equatable {
    let id: Int
    let username: String?
    let avatarURL: String?
    let name: String?
    let bio: String?
    let location: String?
    let followers: Int?
    let following: Int?
    let repositories: Int?
    let gists: Int?
    let created: String?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, followers, following, bio, location
        case username = "login"
        case avatarURL = "avatar_url"
        case repositories = "public_repos"
        case gists = "public_gists"
        case created = "created_at"
        case url = "html_url"
    }
}

// MARK: - Repo List Model

struct RepositoryModel: Codable {
    let name: String
    let description: String?
}
