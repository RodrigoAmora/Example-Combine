//
//  GitHudUserService.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 14/01/25.
//

import Foundation
import Combine

class GitHudUserService {
    private var cancellables: AnyCancellable?
    
    func getGitHubUser(completion: @escaping(Result<GitHudUser, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/octocat")!
        
        
//        let publihser = URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: GitHudUser.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
        
        self.cancellables = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: GitHudUser.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Error \(error)")
                        completion(.failure(error))
                }
            }, receiveValue: { user in
                completion(.success(user))
            }
        )
        
    }
}
