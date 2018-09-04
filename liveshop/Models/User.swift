//
//  User.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

struct User {
  
  var id = Int(arc4random())
  
  static let currentUser = User()
}
