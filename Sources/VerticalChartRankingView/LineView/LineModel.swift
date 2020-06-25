//
//  DataModel.swift
//  ScrollViewTest
//
//  Created by Chung Han Hsin on 2020/5/16.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

public class LineModel {
  
  let id: String
  let name: String
  private(set) var value: Float
  private(set) var rank: Int = 0
  let icon: UIImage
  let channelImage: UIImage
  
  init(id: String, name: String, value: Float, icon: UIImage, channelImage: UIImage) {
    self.id = id
    self.name = name
    self.value = value
    self.icon = icon
    self.channelImage = channelImage
  }
  
  func setRank(_ rank: Int) {
    self.rank = rank
  }
}

extension LineModel: Comparable {
  public  static func == (lhs: LineModel, rhs: LineModel) -> Bool {
    if lhs.value == rhs.value {
      return true
    }
    return false
  }
  
  public static func < (lhs: LineModel, rhs: LineModel) -> Bool {
    if lhs.value < rhs.value {
      return true
    }
    return false
  }
}


