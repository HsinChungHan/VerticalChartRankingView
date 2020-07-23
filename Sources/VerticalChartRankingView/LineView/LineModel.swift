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
  private(set) var rank: Int = 999999
  let iconNames: [String]
  let channelImageName: String
  
  var icons: [UIImage] {
    var icons = [UIImage]()
    for iconName in iconNames {
      let icon = UIImage(named: iconName)!
      icons.append(icon)
    }
    return icons
  }
  
  var channelImage: UIImage {
    let channelImage = UIImage(named: channelImageName)!
    return channelImage
  }
  
  init(id: String, name: String, value: Float, iconNames: [String], channelImageName: String) {
    self.id = id
    self.name = name
    self.value = value
    self.iconNames = iconNames
    self.channelImageName = channelImageName
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


