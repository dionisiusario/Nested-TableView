//
//  ViewController.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  
  var posts: [Posts]? = []
  var photos: [Photos]? = []
  
  override func viewDidLoad() {
    super.viewDidLoad()

    registerTableView()
    fetchData(for: .photos) { [weak self] (photos: [Photos]?, error) in
        if let error = error {
            print("Error fetching photos: \(error.localizedDescription)")
            return
        }
        if let photos = photos {
          self?.photos = photos
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        }
    }
    
    fetchData(for: .posts) { [weak self] (posts: [Posts]?, error) in
        if let error = error {
            print("Error fetching posts: \(error.localizedDescription)")
            return
        }
        if let posts = posts {
          self?.posts = posts
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        }
    }
  }
  
  func registerTableView(){
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "IntroductionCell", bundle: nil), forCellReuseIdentifier: "introCell")
    tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
    tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "photoCell")
    
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "introCell", for: indexPath) as? IntroductionCell else {
             return UITableViewCell()
         }
      
      cell.setupGreetingLabel()
      cell.selectionStyle = .none
      
      return cell
      
    }else if indexPath.row == 1 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell else {
             return UITableViewCell()
         }
      
      cell.posts = self.posts ?? []
      cell.collectionView.reloadData()
      cell.selectionStyle = .none

      return cell
      
    }else if indexPath.row == 2 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
             return UITableViewCell()
         }
      
      cell.photos = self.photos ?? []
      cell.collectionView.reloadData()
      cell.selectionStyle = .none

      return cell
      
    }else {
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 1 {
      return 270
      
    }else if indexPath.row == 2 {
      return 310
      
    }
    return UITableView.automaticDimension
      
  }
  
}

extension UIViewController {
  func fetchData<T: Codable>(for type: APIType, completion: @escaping ([T]?, Error?) -> Void) {
      let apiUrlString = type.endpoint
      if let apiUrl = URL(string: apiUrlString) {
          let session = URLSession.shared
          let task = session.dataTask(with: apiUrl) { (data, response, error) in
              if let error = error {
                  completion(nil, error)
                  return
              }
              if let data = data {
                  do {
                      let decodedData = try JSONDecoder().decode([T].self, from: data)
                      completion(decodedData, nil)
                  } catch {
                      completion(nil, error)
                  }
              }
          }

          task.resume()
      }
  }
}
