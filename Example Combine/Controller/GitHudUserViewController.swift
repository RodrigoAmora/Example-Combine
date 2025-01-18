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
        
        self.userNameTextField.placeholder = "Enter Github user....";
        
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.userNameLabel.textAlignment = .center
        self.userNameLabel.text = ""
        
        self.sendButton.setTitle(String(localized: "Send"), for: .normal)
    }
    
    private func updateUI(with user: GitHudUser) {
        self.userNameLabel.text = user.login
        
        self.userAvatarImageView.roundedImage()
        self.userAvatarImageView.loadImageFromURL(user.avatar_url.absoluteString)
        
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
