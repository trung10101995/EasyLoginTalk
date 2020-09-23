//
//  UserDataModel.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import Foundation
import ObjectMapper

class UserDataModel: Mappable, Decodable, Encodable {
    var sessionId: String = ""
    var userName : String = ""
    var fullName : String = ""
    var avatar : String = ""
    var hubID :  String = ""
    var talkID :  String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        sessionId <- map["sessionId"]
        userName <- map["userName"]
        fullName <- map["fullName"]
        
        avatar <- map["avatar"]
        hubID <- map["hubID"]
        talkID <- map["talkID"]
    }
}

