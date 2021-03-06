//
//  LineViewModel.swift
//  ScrollViewTest
//
//  Created by Chung Han Hsin on 2020/5/16.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

protocol LineViewModelDelegate: AnyObject {
  func lineViewModelRankDidChange(_ lineViewModel: LineViewModel, rank: Int)
}

class LineViewModel {
  weak var delegate: LineViewModelDelegate?
  
  private(set) var lineModel: LineModel
  
  var id: String {
    return lineModel.id
  }
  
  var name: String {
    return lineModel.name
  }
  
  var iconNames: [String] {
    return lineModel.iconNames
  }
  
  var channelImageName: String {
    return lineModel.channelImageName
  }
  
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
  
  var value: Float {
    return lineModel.value
  }
  
  private(set) var isValueChanged: Bool = false
  
  private(set) var rank: Int
  
  private(set) var rankingViewMaxValue: Float
  
  private(set) var transationFromValue: CGFloat = UIScreen.main.bounds.width
  private(set) var drawLineFromValue: CGFloat = 0.0
  
  let lineViewHeight: CGFloat
  let lineViewMaxY: CGFloat
  let lineViewHeightScale: CGFloat
  
  var drawLineToValue: CGFloat {
    let calculator = Calculator()
    return calculator.calculateDrawLineToValue(lineViewHeight: lineViewHeight, lineViewHeightScale: lineViewHeightScale, lineViewValue: CGFloat(value), rankingViewMaxValue: CGFloat(rankingViewMaxValue), lineViewMaxY: lineViewMaxY)
  }
  
  var shouldEraseLine: Bool {
    return drawLineToValue > drawLineFromValue
  }
    
  init(lineModel model: LineModel, rankingViewMaxValue: Float, lineViewHeight: CGFloat, maxY: CGFloat, lineViewHeightScale: CGFloat) {
    self.lineModel = model
    self.rankingViewMaxValue = rankingViewMaxValue
    self.lineViewHeight = lineViewHeight
    drawLineFromValue = maxY
    lineViewMaxY = maxY
    self.lineViewHeightScale = lineViewHeightScale
    rank = lineModel.rank
  }
  
  func setNextRoundTransationFromValue(_ value: CGFloat) {
    self.transationFromValue = value
  }
  
  func setLineModel(_ lineModel: LineModel) {
    self.lineModel = lineModel
  }
  
  func updateDrawLineToValue() {
    drawLineFromValue = drawLineToValue
  }
  
  func setRankingViewMaxValue(_ maxValue: Float) {
    self.rankingViewMaxValue = maxValue
  }
  
  func setRank(_ rank: Int) {
    self.rank = rank
    delegate?.lineViewModelRankDidChange(self, rank: rank + 1)
  }
  
  func didChangeValue() {
    isValueChanged = true
  }
  
  func alreadyChangedValue() {
    isValueChanged = false
  }
}

