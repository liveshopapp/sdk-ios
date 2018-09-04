//
//  Profile.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

import Foundation

public class Profile {
  
  var username: String?
  
  static func getCurrentProfile() -> Profile? {
    return Profile()
  }
}
