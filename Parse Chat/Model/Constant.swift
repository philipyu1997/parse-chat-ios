//
//  Constant.swift
//  Parse Chat
//
//  Created by Philip Yu on 5/18/20.
//  Copyright © 2020 Philip Yu. All rights reserved.
//

import UIKit

struct Constant {
    
    // MARK: - Properties
    static let applicationId = fetchFromPlist(forResource: "Parse", forKey: "APP_ID")
    static let server = fetchFromPlist(forResource: "Parse", forKey: "SERVER_URL")
    static let theme = UIColor(red: 28.0/255.0, green: 156.0/255.0, blue: 242.0/255.0, alpha: 1.0)
    
    // MARK: - Functions
    static func fetchFromPlist(forResource resource: String, forKey key: String) -> String? {
        
        let filePath = Bundle.main.path(forResource: resource, ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value = plist?.object(forKey: key) as? String
        
        return value
        
    }
    
}

extension UIButton {
    
    func makeRounded(withRadius cornerRadius: CGFloat) {
        
        self.layer.cornerRadius = cornerRadius
        
    }
    
}

extension UIImageView {
    
    func circleImage() {
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
    }
    
}
