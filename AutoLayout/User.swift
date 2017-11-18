//
//  User.swift
//  AutoLayout
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 modi. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [User(name: "name1_login1_company1", company: "company1_name1_login1", login: "login1", password: "password1")
                    ,User(name: "name2_login2_company2_modi_siri_lihaha", company: "company2_name2_login2_modi_siri_lihaha", login: "login2", password: "password2")
                    ,User(name: "name3", company: "company3", login: "login3", password: "password3")] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
}
