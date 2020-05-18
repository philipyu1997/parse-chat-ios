//
//  Constant.swift
//  Parse Chat
//
//  Created by Philip Yu on 5/18/20.
//  Copyright © 2020 Philip Yu. All rights reserved.
//

import Foundation

struct Constant {
    
    // MARK: - Properties
    static let applicationId = fetchFromPlist(forResource: "Parse", forKey: "APP_ID")
    static let server = fetchFromPlist(forResource: "Parse", forKey: "SERVER_URL")
    
    // MARK: - Functions
    static func fetchFromPlist(forResource resource: String, forKey key: String) -> String? {
        
        let filePath = Bundle.main.path(forResource: resource, ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value = plist?.object(forKey: key) as? String
        
        return value
        
    }
    
}
