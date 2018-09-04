//
//  CommentCell.swift
//  liveshop
//
//  Created by Renan Kosicki on 29/08/18.
//  Copyright © 2018 LiveShopApp. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
  
  @IBOutlet weak var commentContainer: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var comment: Comment? {
    didSet {
      titleLabel.text = comment?.text
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commentContainer.layer.cornerRadius = 3
  }
}
