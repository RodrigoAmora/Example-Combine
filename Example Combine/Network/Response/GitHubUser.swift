//
//  GitHudUser.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 14/01/25.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatar_url: URL
    let id: Int
    let followers: Int
    let following: Int
    let public_repos: Int
}
