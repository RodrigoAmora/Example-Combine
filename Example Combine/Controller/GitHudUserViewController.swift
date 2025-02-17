//
//  GitHudUserViewController.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 14/01/25.
//

import UIKit

class GitHudUserViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var publicRepositoriesLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    // MARK: - Atributes
    private let service = GitHudUserService()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    // MARK: - Methods
    private func initViews() {
        self.loading.isHidden = true
        self.loading.color = .systemBlue
        
        self.userNameTextField.accessibilityIdentifier = "userNameTextField"
        self.userNameTextField.placeholder = "Enter Github user....";
        
        self.userNameLabel.accessibilityIdentifier = "userNameLabel"
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.userNameLabel.textAlignment = .center
        self.userNameLabel.text = ""
        
        self.followersLabel.text = ""
        self.followersLabel.textAlignment = .left
        
        self.followingLabel.text = ""
        self.followingLabel.textAlignment = .right
        
        self.publicRepositoriesLabel.text = ""
        self.publicRepositoriesLabel.textAlignment = .center
        self.publicRepositoriesLabel.numberOfLines = 2
        
        self.sendButton.accessibilityIdentifier = "sendButton"
        self.sendButton.setTitle(String(localized: "Send"), for: .normal)
    }
    
    private func updateUI(with user: GitHubUser) {
        self.userNameLabel.text = user.login
        
        self.userAvatarImageView.roundedImage()
        self.userAvatarImageView.loadImageFromURL(user.avatar_url.absoluteString)
        
        self.followersLabel.text = "Followers: \(user.followers)"
        self.followingLabel.text = "Following: \(user.following)"
        
        self.publicRepositoriesLabel.text = "Public Repositories:\n \(user.public_repos)"
        
        self.loading.isHidden = true
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: String(localized: "OK"), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction private func fetchtGitHubUser() {
        let userName = self.userNameTextField.text ?? ""
        if userName.isEmpty {
            self.showAlert(title: "", message: "Type a user name!")
            return
        }
        
        self.loading.isHidden = false
        
        self.service.getGitHubUser(userName: userName){ [weak self] result in
            switch result {
            case .success(let user):
                self?.updateUI(with: user)
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
}
