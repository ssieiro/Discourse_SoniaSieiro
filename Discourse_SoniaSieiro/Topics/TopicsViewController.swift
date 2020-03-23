//
//  TopicsViewController.swift
//  Discourse_SoniaSieiro
//
//  Created by Sonia Sieiro on 17/03/2020.
//  Copyright © 2020 Sonia Sieiro. All rights reserved.
//

import UIKit

enum LatestTopicsError: Error {
    case malformedURL
    case emptyData
}

class TopicsViewController: UIViewController {
    
    var latestTopics: [Topic] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        fetchLatestTopics { [weak self] (result) in
            switch result {
            case .success(let latestTopics):
                self?.latestTopics = latestTopics
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }

    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func fetchLatestTopics(completion: @escaping (Result<[Topic], Error>) -> Void) {
        guard let latestTopicsURL = URL(string: "https://mdiscourse.keepcoding.io/latest.json") else {
            completion(.failure(LatestTopicsError.malformedURL))
            return
        }

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        var request = URLRequest(url: latestTopicsURL)
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
                    completion(.failure(LatestTopicsError.emptyData))
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(LatestTopicsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.topicList.topics))
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



extension TopicsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDatasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestTopics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = latestTopics[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.darkGray
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Se ha hecho tap en la celda con al fila \(indexPath.row)")
        let topic = latestTopics[indexPath.row]
        let topicsDetailVC = TopicsDetailViewController.init(withId: topic.id)
        self.navigationController?.pushViewController(topicsDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


