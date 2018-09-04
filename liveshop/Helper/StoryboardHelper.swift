//
//  StoryboardHelper.swift
//  liveshop
//
//  Created by Renan Kosicki on 28/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

import UIKit

public class StoryboardHelper: NSObject {
  static let helper = StoryboardHelper()
  
  lazy var storyboard: UIStoryboard = UIStoryboard(name: "Live", bundle: Bundle(for: StoryboardHelper.self))
  
  func liveController(room: Room) -> LiveViewController? {
    if let controller = storyboard.instantiateViewController(withIdentifier: "live") as? LiveViewController {
      controller.room = room
      return controller
    }
    
    return nil
  }
}
