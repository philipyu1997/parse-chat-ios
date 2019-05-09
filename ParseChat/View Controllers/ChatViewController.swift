//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var messages: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        // Remove line separators between table view cells
        tableView.separatorStyle = .none
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 80
        
    }
    
    @objc func onTimer() {
        
        // construct query
        let messageQuery = PFQuery(className: "Message")
        
        messageQuery.includeKey("user")
        messageQuery.addDescendingOrder("createdAt")
        
        // fetch data asynchronously
        messageQuery.findObjectsInBackground { (messages, error) in
            if error == nil {
                self.messages = []
                
                if let messages = messages {
                    self.messages = messages
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
        
    }
    
    @IBAction func onSendMessage(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["user"] = PFUser.current()!
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var messageCount = 0
        
        if let messages = self.messages {
            messageCount = messages.count
        }
        
        return messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        if let messages = self.messages {
            let message = messages[indexPath.row]
            
            if let user = message["user"] as? PFUser {
                // User found! update username label with username
                cell.usernameLabel.text = user.username
            } else {
                // No user found, set default username
                cell.usernameLabel.text = "🤖"
            }
            
            cell.chatMessageLabel.text = message["text"] as? String
        } else {
            print("Error in attempting to load messages...")
        }
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
