//
//  GiftEvent.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

class GiftEvent: NSObject {
  
  var senderId: Int
  var giftId: Int
  var giftCount: Int
  
  init(dict: [String: AnyObject]) {
    senderId = dict["senderId"] as! Int
    giftId = dict["giftId"] as! Int
    giftCount = dict["giftCount"] as! Int
  }
  
  func shouldComboWith(_ event: GiftEvent) -> Bool {
    return senderId == event.senderId && giftId == event.giftId
  }
}
