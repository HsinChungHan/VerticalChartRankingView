//
//  IconViewModel.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

class IconViewLayerViewModel {
  private(set) var lineModel: LineModel
  
  var value: Float {
    return lineModel.value
  }
  
  var id: String {
    return lineModel.id
  }
  
  var icon: UIImage {
    return lineModel.icon
  }
  
  var rank: Int {
    return lineModel.rank
  }
  
  private(set) var rankingViewMaxValue: Float
  private(set) var lineViewHeight: CGFloat
  private(set) var lineViewMaxY: CGFloat
  private(set) var lineViewHeightScale: CGFloat
  private(set) var drawLineDuration: TimeInterval
  private(set) var opacityAndStayTransationAndFirstXYTransationDuration: TimeInterval
  private(set) var isIconLayerFirstPresented: Bool = true
  
  var transationYToValue: CGFloat {
    let calculator = Calculator()
    let toValue = calculator.calculateDrawLineToValue(lineViewHeight: lineViewHeight, lineViewHeightScale: lineViewHeightScale, lineViewValue: CGFloat(value), rankingViewMaxValue: CGFloat(rankingViewMaxValue), lineViewMaxY: lineViewMaxY)
    return toValue
  }
  
  //第一段移動到 lineView 時的 y
  var initialTransationY: CGFloat {
    let calculator = Calculator()
    let toValue = calculator.calculateYPosition(lineViewHeight: lineViewHeight, lineViewHeightScale: lineViewHeightScale, lineViewValue: CGFloat(value), rankingViewMaxValue: CGFloat(rankingViewMaxValue), lineViewMaxY: lineViewMaxY, drawLineDuration: drawLineDuration, duration: opacityAndStayTransationAndFirstXYTransationDuration)
    return toValue
  }
  
  init(lineModel model: LineModel, rankingViewMaxValue: Float, lineViewHeight: CGFloat, lineViewMaxY: CGFloat, lineViewHeightScale: CGFloat, drawLineDuration: TimeInterval, initialDuration: TimeInterval) {
    self.lineModel = model
    self.rankingViewMaxValue = rankingViewMaxValue
    self.lineViewHeight = lineViewHeight
    self.lineViewMaxY = lineViewMaxY
    self.lineViewHeightScale = lineViewHeightScale
    self.drawLineDuration = drawLineDuration
    self.opacityAndStayTransationAndFirstXYTransationDuration = initialDuration
  }
  
  func setIsIconLayerFirstPresented(isIconLayerFirstPresented: Bool) {
    self.isIconLayerFirstPresented = isIconLayerFirstPresented
  }
}
