//
//  GitHubInfoController.swift
//  CompleteRest
//
//  Created by Nicola De FIlippo on 04/10/2018.
//  Copyright © 2018 Nicola De FIlippo. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

class GitHubInfoController {
    
    func fetchGitHubInfo(completion: @escaping (GitHubInfo?) -> Void)
    {
        let baseURL = URL(string: "https://api.github.com/users/niqt")!
        
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let gitHubInfo = try?
                    jsonDecoder.decode(GitHubInfo.self, from: data) {
                completion(gitHubInfo)
            } else {
                print("Either no data was returned, or data was notserialized.")
                    completion(nil)
            }
        }
        task.resume()
    }
}
