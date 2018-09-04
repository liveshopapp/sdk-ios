//
//  TableView+App.swift
//  liveshop
//
//  Created by Renan Kosicki on 30/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

extension UITableView {
  
  func scrollToBottom() {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1, section: self.numberOfSections-1)
      self.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
  
  func scrollToTop() {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: 0, section: 0)
      self.scrollToRow(at: indexPath, at: .top, animated: false)
    }
  }
}
