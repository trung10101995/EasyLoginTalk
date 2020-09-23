//
//  UserDefaultManager.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//

import Foundation

class UserDefaultManager {
    
    static let share = UserDefaults.standard
    
    private init() {}
    
    static let KEY_LIST_USER = "KEY_LIST_USER"
    
    func saveNewUser(userData: UserDataModel, complete: (()-> Void)? ,failure:@escaping (String)->()) {
        /// remove duplicate
        do {
            var listUser = try self.getListUser()
            listUser.removeAll { (data) -> Bool in
                return data.talkID == userData.talkID
            }
            /// add
            listUser.append(userData)
            
            let placesData = try JSONEncoder().encode(listUser)
            UserDefaults.standard.set(placesData, forKey: UserDefaultManager.KEY_LIST_USER)
            
            complete?()
        } catch {
            failure("error")
        }
        
    }
    
    func deleteUser(talkID: String, complete: (()-> Void)? ,failure:@escaping (String)->()) {
        
        do {
            var listUser = try self.getListUser()
            listUser.removeAll { (data) -> Bool in
                return data.talkID == talkID
            }
            let placesData = try JSONEncoder().encode(listUser)
            UserDefaults.standard.set(placesData, forKey: UserDefaultManager.KEY_LIST_USER)
            complete?()
        } catch {
            failure("error")
        }
        
        
    }
    
    func getListUser() throws -> [UserDataModel] {
        guard let userDataModel = UserDefaults.standard.data(forKey: UserDefaultManager.KEY_LIST_USER) else {
            return []
        }
        return try JSONDecoder().decode([UserDataModel].self, from: userDataModel)
    }
}
