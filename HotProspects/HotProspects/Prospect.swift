//
//  Prospect.swift
//  HotProspects
//
//  Created by Brandon Johns on 3/29/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool 
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
