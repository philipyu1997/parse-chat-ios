//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageField: UITextField!
    
    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var messages: [PFObject]? = []
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.fetchMessages), userInfo: nil, repeats: true)
        
        // Remove line separators between table view cells
        tableView.separatorStyle = .none
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 80
        // Table view will start at bottom (scroll up)
        tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        // Move scroll indicator to the right hand side
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: tableView.bounds.size.width - 8.0)
        // Dismiss keyboard when scrolling up
        tableView.keyboardDismissMode = .interactive
        tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        // Remove space between text field and keyboard
        sendMessageField.delegate = self
        sendMessageField.keyboardDistanceFromTextField = -14
        
        // Pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchMessages), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
    }
    
    @objc func fetchMessages() {
        
        // Construct query
        let messageQuery = PFQuery(className: "Message")
        
        messageQuery.includeKey("user")
        messageQuery.addDescendingOrder("createdAt")
        messageQuery.limit = 20
        
        // Fetch data asynchronously
        messageQuery.findObjectsInBackground { (messages, error) in
            if error == nil {
                if let messages = messages {
                    self.messages = messages
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            
            self.tableView.reloadData()
            self.refresh()
        }
        
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
     
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
        
    }
    
    // Call the delay method in your onRefresh() method
    func refresh() {
     
        run(after: 2) {
           self.refreshControl.endRefreshing()
        }
        
    }
    
    // MARK: - IBAction Section
    
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
        chatMessage["text"] = sendMessageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.sendMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var messageCount = 0
        
        if let messages = self.messages {
            messageCount = messages.count
        }
        
        return messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! ChatCell
        let baseURL = "https://api.adorable.io/avatars/"
        
        cell.bubbleView.backgroundColor = .systemGreen
        
        // Flip cell upside down
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        if let messages = self.messages {
            let message = messages[indexPath.row]

            if let user = message["user"] as? PFUser {
                // User found! update username label with username
                if user.username == PFUser.current()?.username {
                    cell.bubbleView.backgroundColor = Constant.theme
                }
                
                cell.usernameLabel.text = user.username
                
                // Set avatar
                let path = "/100/\(user.username!)"
                let url = URL(string: baseURL + path)
                
                if let avatarURL = url {
                    cell.avatarImageView.af.setImage(withURL: avatarURL)
                    cell.avatarImageView.circleImage()
                }
            } else {
                // No user found, set default username
                cell.usernameLabel.text = "🤖"
            }

            cell.messageLabel.text = message["text"] as? String
        } else {
            print("Error in attempting to load messages...")
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Section
    
}
