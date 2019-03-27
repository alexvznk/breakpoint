//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DataService.instance.REF_FEED.removeAllObservers()
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else {
            return UITableViewCell()
        }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
        }
        return cell
    }
  
}

