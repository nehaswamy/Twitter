//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Neha Swamy on 11/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    @IBOutlet var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetTextView.layer.borderWidth = 1.0
        self.tweetTextView.layer.borderColor = UIColor.gray.cgColor
        self.tweetTextView.layer.cornerRadius = 10.0
        self.tweetTextView.becomeFirstResponder()
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweet: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet")
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
