//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Neha Swamy on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var tweetsArray = [NSDictionary]()
    var numberOfTweets = Int()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets(number: 20)
        refresh.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    @objc func loadTweets(number: Int) {
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = ["count": number]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: parameters, success: { (tweets: [NSDictionary]) in
            self.tweetsArray.removeAll()
            
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refresh.endRefreshing()
            
        }, failure: { (Error) in
            print("Unable to retrieve tweets")
        })
    }

    @IBAction func logout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary
        let imageURL = URL(string: user["profile_image_url_https"] as! String)!
        let data = try? Data(contentsOf: imageURL)
        
        if let imageData = data {
            cell.profilePicture.image = UIImage(data: imageData)
        }
        
        cell.tweet.text = tweetsArray[indexPath.row]["text"] as? String
        cell.userName.text = user["name"] as? String
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetsArray.count {
            loadTweets(number: tweetsArray.count + 20)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
}
