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
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        _content = content
        _senderId = senderId
    }
}
