//
//  Room.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

public struct Room: Codable {
  
  var art: String?
  var key: String?
  var title: String?
  var live: Bool?
  var price: Float?
  var quantity: Int?

  init(dict: [String: AnyObject]) {
    art = dict["art"] as? String
    key = dict["key"] as? String
    title = dict["title"] as? String
    live = dict["live"] as? Bool
    price = dict["price"] as? Float
    quantity = dict["quantity"] as? Int
  }

  func toDict() -> [String: AnyObject] {
    return [
      "art": art as AnyObject,
      "key": key as AnyObject,
      "title": title as AnyObject,
      "live": live as AnyObject,
      "price": price as AnyObject,
      "quantity": quantity as AnyObject
    ]
  }
}
