//
//  GitHub.swift
//  CompleteRest
//
//  Created by Nicola De FIlippo on 04/10/2018.
//  Copyright © 2018 Nicola De FIlippo. All rights reserved.
//

import Foundation

struct GitHubInfo: Codable {
    let name: String?
    let location: String?
    let blog: URL?
    let followers: Int?
    let avatarUrl: URL?
    let repos: Int?
    
    private enum Keys: String, CodingKey {
        case name
        case location
        case blog
        case followers
        case repos = "public_repos"
        case avatarUrl = "avatar_url"
        
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
            Keys.self)
        
        self.name = try valueContainer.decode(String.self,
                                            forKey: Keys.name)
        self.location = try valueContainer.decode(String.self,
                                               forKey: Keys.location)
        self.blog = try valueContainer.decode(URL.self,
                                                     forKey: Keys.blog)
        self.followers = try valueContainer.decode(Int.self, forKey:
            Keys.followers)
        self.avatarUrl = try valueContainer.decode(URL.self,
                                                   forKey: Keys.avatarUrl)
        self.repos = try valueContainer.decode(Int.self,
                                                   forKey: Keys.repos)
    }
    
}
