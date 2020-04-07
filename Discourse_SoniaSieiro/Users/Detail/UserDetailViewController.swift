//
//  UserDetailViewController.swift
//  Discourse_SoniaSieiro
//
//  Created by Sonia Sieiro on 07/04/2020.
//  Copyright © 2020 Sonia Sieiro. All rights reserved.
//

import UIKit

enum SingleUserError: Error {
    case malformedURL
    case emptyData
}

class UserDetailViewController: UIViewController {
    
    var singleUser: SingleUserResponse?
    var username: String?
    var delegate: UserViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateButton.isHidden = true
        self.nameField.isHidden = true
    
    fetchSingleUser { [weak self] (result) in
        switch result {
        case .success(let singleUser):
            self?.singleUser = singleUser
            self?.setupUI()
        case .failure(let error):
            print(error)
            self?.showErrorAlert(message: error.localizedDescription)
        }
    }
    }
    
    func setupUI() {
        if let singleUser = singleUser {
            userId.text = "Id: \(singleUser.user.id)"
            usernameLabel.text = singleUser.user.username
            name.text = singleUser.user.name ?? "-"
            if singleUser.user.canEditName == true {
                nameField.isHidden = false
                name.isHidden = true
                updateButton.isHidden = false
                nameField.text = singleUser.user.username
            }
        }

    }
    
    convenience init(withUsername username: String) {
        self.init(nibName: "UserDetailViewController", bundle: nil)
        self.username = username
        self.title = "User detail"
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    

    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }

    func fetchSingleUser(completion: @escaping (Result<SingleUserResponse, Error>) -> Void) {
        if let username = username {
            guard let singleUserURL = URL(string: "https://mdiscourse.keepcoding.io/users/\(username).json") else {
                completion(.failure(LatestTopicsError.malformedURL))
                return
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)

            var request = URLRequest(url: singleUserURL)
            request.httpMethod = "GET"
            request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
            request.addValue("ssieiro2", forHTTPHeaderField: "Api-Username")
            
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(SingleUserError.emptyData))
                    }
                    return
                }

                do {
                    let response = try JSONDecoder().decode(SingleUserResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch(let error) {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }

            dataTask.resume()
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
