//
//  GitHudUserViewController.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 14/01/25.
//

import UIKit

class GitHudUserViewController: UIViewController {
    let service = GitHudUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchtGitHubUser()
    }

    private func fetchtGitHubUser() {
        self.service.getGitHubUser{ [weak self] result in
            switch result {
            case .success(let user):
                self?.updateUI(with: user)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    private func updateUI(with user: GitHudUser) {
        print(user.id)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
