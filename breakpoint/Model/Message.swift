//
//  Message.swift
//  breakpoint
//
//  Created by Alex on 3/2/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import Foundation

class Message {
    private var _content: String
    private var _senderId: String
    private var _username: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    var username: String {
        return _username
    }
    
    init(content: String, senderId: String, username: String) {
        _content = content
        _senderId = senderId
        _username = username
    }
}
