//
//  Comment.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

struct Comment {
  
  var text: String
  
  init(dict: [String: AnyObject]) {
    text = dict["text"] as! String
  }
}
