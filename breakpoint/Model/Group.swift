//
//  Group.swift
//  breakpoint
//
//  Created by Alex on 3/26/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import Foundation

class Group {
    private var _groupTitle: String
    private var _groupDesc: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDesc: String {
        return _groupDesc
    }
    
    var key: String {
        return _key
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String, key: String, memberCount: Int, members: [String]) {
        _groupTitle = title
        _groupDesc = description
        _key = key
        _memberCount = memberCount
        _members = members
    }
}
