//
//  LoginViewController.swift
//  Twitter
//
//  Created by Neha Swamy on 10/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "loggedIn") == true) {
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let url =  "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: url, success: {
            UserDefaults.standard.set(true, forKey: "loggedIn")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: { (Error) in
            print("Login failed")
        })
    }
    
}
