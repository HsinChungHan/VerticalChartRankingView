//
//  File.swift
//  
//
//  Created by Chung Han Hsin on 2020/7/23.
//

import Foundation

extension Int {
  func formattedToNumberStr() -> String {
    var suffixStr = "th"
    switch self {
      case 1:
        suffixStr = "st"
      case 2:
        suffixStr = "nd"
      case 3:
        suffixStr = "rd"
      default:
        break
    }
    return "\(self)\(suffixStr)"
  }
}
