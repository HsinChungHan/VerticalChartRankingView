//
//  Calculator.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

class Calculator {
  
  func calculateDrawLineToValue(lineViewHeight height: CGFloat, lineViewHeightScale scale: CGFloat, lineViewValue value: CGFloat, rankingViewMaxValue maxValue: CGFloat, lineViewMaxY maxY: CGFloat) -> CGFloat {
    let valueheight = height * scale * CGFloat(value / maxValue)
    return CGFloat(Int(maxY - valueheight))
  }
  
  //計算第一段， icon 經過 time seconds 要移動到的 y 位置
  func calculateYPosition(lineViewHeight height: CGFloat, lineViewHeightScale scale: CGFloat, lineViewValue value: CGFloat, rankingViewMaxValue maxValue: CGFloat, lineViewMaxY maxY: CGFloat, drawLineDuration: TimeInterval, duration time: TimeInterval) -> CGFloat {
    let toValue = calculateDrawLineToValue(lineViewHeight: height, lineViewHeightScale: scale, lineViewValue: value, rankingViewMaxValue: maxValue, lineViewMaxY: maxY)
    let speed = calculateLineViewRaisingSpeedPerSecond(lineViewMaxY: maxY, yPositionOfToValue: toValue, duration: drawLineDuration)
    return calculateLineViewPositionYWithDuration(lineViewSpeed: speed, duration: time, lineViewMaxY: maxY)
  }
  
  func calculateXTransationToValue(padding: CGFloat, rank: Int, lineViewWidth width: CGFloat) -> CGFloat {
    return CGFloat(Int(padding * CGFloat(rank + 1) + width * CGFloat(rank)))
  }
  
  func calculateLineViewWidth(rankingViewWidth width: CGFloat, padding: CGFloat, numberOfPresentedViews num: Int) -> CGFloat {
    let totalPaddings = padding * CGFloat(num)
    return CGFloat(Int((width - totalPaddings) / CGFloat(num)))
  }
}


//MARK: - Supporting functions

extension Calculator {
  /// 計算由 lineView 的最低點到最高點的速度
  /// 每秒鐘可以上升多少高度
  /// - Parameters:
  ///   - maxY: lineView 的 maxY
  ///   - yPosition: lineView 的值所對應的 y
  ///   - time: draw line 的時間
  fileprivate func calculateLineViewRaisingSpeedPerSecond(lineViewMaxY maxY: CGFloat, yPositionOfToValue yPosition: CGFloat, duration time: TimeInterval) -> CGFloat {
    return (maxY - yPosition) / CGFloat(time)
  }
  
  /// 求出經過一段時間後 y position
  /// - Parameters:
  ///   - rate: lineView 的最低點到最高點的速度
  ///   - time: 所經過的時間
  ///   - maxY: lineView 的 maxY
  fileprivate func calculateLineViewPositionYWithDuration(lineViewSpeed rate: CGFloat, duration time: TimeInterval, lineViewMaxY maxY: CGFloat) -> CGFloat {
    let newHeight = rate * CGFloat(time)
    return maxY - newHeight
  }
}
