//
//  LiveShop.swift
//  liveshop
//
//  Created by Renan Kosicki on 23/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

import Foundation
import Alamofire

public class LiveShop {
  private var appKey: String?

  public required init(appKey: String) {
    self.appKey = appKey

    guard let appKey = self.appKey, appKey.count > 0 else {
      fatalError("AppKey not found on LiveShop initilization!")
    }
  }
  public func getRooms(completionHandler: @escaping ([Room]?, Error?) -> Void) {
    let roomUrl = "\(Config.baseUrl)/room?token=\(self.appKey!)"

    Alamofire
      .request(roomUrl)
      .responseData(completionHandler: { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            let parsedObject = try decoder.decode(RoomResponse.self, from: data)
            return completionHandler(parsedObject.rooms, nil)
          } catch let error {
            return completionHandler(nil, error)
          }
        case .failure(let validationError):
          return completionHandler(nil, validationError)
        }
      })
  }

  public func start(room: Room,
                    navigationController: UINavigationController,
                    shopButtonPressed: (() -> ())?,
                    dismissButtonPressed: (() -> ())?) {
    guard let liveController = StoryboardHelper.helper.liveController(room: room) else { return }

    liveController.shopButtonPressed = shopButtonPressed
    liveController.dismissButtonPressed = dismissButtonPressed

    navigationController.present(liveController, animated: true)
  }
}
