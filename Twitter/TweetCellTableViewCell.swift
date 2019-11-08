//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Neha Swamy on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var tweet: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        
        if (favorited) {
            favoriteButton.setImage(UIImage(named: "favorite_red"), for: UIControl.State.normal)
            
        } else {
            favoriteButton.setImage(UIImage(named: "twitter_favorite_gray"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        } else {
            retweetButton.setImage(UIImage(named: "retweet-arrow-gray"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
             self.setRetweeted(true)
         }, failure: { (error) in
            print("Unable to retweet")
        })
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
                
            }, failure: { (error) in
                print("Tweet unable to be favorited")
            })
            
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
                
            }, failure: { (error) in
                print("Tweet unable to be unfavorited")
            })
        }
    }
}
