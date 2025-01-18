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
    
    func getGitHubUser(userName: String, completion: @escaping(Result<GitHudUser, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(userName)")!
        
        
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
    
    func exmapleRequestWithPost() {
        let myData =  MyData(id: 1, name: "Rodrigo")
        
        guard let url = URL(string: "http://api.exemplo.com/ednpoint") else {
            fatalError("Invalid URL!")
        }
        
        guard let jsonData = try? JSONEncoder().encode(myData) else {
            fatalError("Invalid JSON!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: GitHudUser.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Error \(error)")
                }
            }, receiveValue: { responseData in
                print("Response: \(responseData)")
                
            })
    }
}
