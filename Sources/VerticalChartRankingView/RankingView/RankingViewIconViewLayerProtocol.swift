//
//  RankingViewIconViewLayerProtocol.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

extension VerticalChartRankingView: IconViewDataSource {
  func iconViewLayerImageType(_ iconViewLayer: IconView) -> ImageType {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageType = dataSource.verticalChartRankingViewIconViewLayerImageType(self)
    return imageType
  }
  
  func iconViewLayerTextLayerBackgroundColor(_ iconViewLayer: IconView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewIconViewLayerTextLayerBackgroundColor(self)
    return color
  }
  
  func iconViewLayerImageLayerBackgroundColor(_ iconViewLayer: IconView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewIconViewLayerImageLayerBackgroundColor(self)
    return color
  }
  
  
  func iconViewLayerTextLayerFont(_ iconViewLayer: IconView) -> UIFont {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let font = dataSource.verticalChartRankingViewTextLayerFont(self)
    return font
  }
  
  func iconViewLayerTextLayerFontSize(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let fontSize = dataSource.verticalChartRankingViewTextLayerFontSize(self)
    return fontSize
  }
  
  func iconViewLayerTextLayerTextColor(_ iconViewLayer: IconView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let textColor = dataSource.verticalChartRankingViewTextLayerTextColor(self)
    return textColor
  }
  
  func iconViewLayerStayDuration(_ iconViewLayer: IconView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerStayDuration(self)
  }
  
  
  func iconViewLayerOpacityDuration(_ iconViewLayer: IconView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerOpacityDuration(self)
  }
  
  func iconViewLayerLineViewHeightScale(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewHeightScale(self)
  }
  
  func iconViewLayerLineModel(_ iconViewLayer: IconView) -> LineModel {
    //TODO: - 要去寫 LineModel == nil 的情況
    return viewModel.currentLineModel ?? LineModel(id: "QQQ", name: "GGG", value: 0, iconNames: [""], channelImageName: "")
  }
  
  func iconViewLayerXTransationToValue(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let padding = dataSource.verticalChartRankingViewPadding(self)
    let calculator = Calculator()
    //TODO: - 要去寫 LineModel == nil 的情況
    let offSetX =
      calculator.calculateXTransationToValue(padding: padding, rank: viewModel.currentLineModel?.rank ?? 999999, lineViewWidth: viewModel.lineViewWidth) + viewModel.lineViewWidth / 2
    return offSetX
  }
  
  func iconViewLayerYTransationInitialToValue(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let lineViewIconHeight = imageLayerHeight + textLayerHeight
    return iconViewLayer.vm.initialTransationY - lineViewIconHeight / 2
  }
  
  func iconViewLayerYTransationToValue(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let lineViewIconHeight = imageLayerHeight + textLayerHeight
    return iconViewLayer.vm.transationYToValue - lineViewIconHeight / 2
  }
  
  func iconViewLayerScaleToValue(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
  }
  
  func iconViewLayerScaleXToValue(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerScaleXToValue(self)
  }
  
  //為了要算 lineView drawLine 的速度，所以要傳進去 lineView drawLine duration
  func iconViewLayerLineViewDrawLineDuration(_ iconViewLayer: IconView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewDoDrawLineViewDuration(self)
    return duration
  }
  
  func iconViewLayerFirstXYTransationDuration(_ iconViewLayer: IconView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewIconViewLayerFirstXYTransationDuration(self)
    return duration
  }
  
  func iconViewLayerTotoalDuration(_ iconViewLayer: IconView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewIconViewLayerTotoalDuration(self)
    return duration
  }
  
  func iconViewLayerRankingViewMaxValue(_ iconViewLayer: IconView) -> Float {
    return viewModel.rankingViewMaxValue
  }
  
  func iconViewLayerLineViewHeight(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
         fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewHeight(self)
  }
  
  func iconViewLayerlineViewMaxY(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
         fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let lineViewHeight = dataSource.verticalChartRankingViewLineViewHeight(self)
    return bounds.minY + lineViewHeight
  }
  
  func iconViewLayerWidthOfLayer(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleXToValue(self)
    return viewModel.lineViewWidth / scaleToValue
  }
  
  func iconViewLayerImageLayerHeiht(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
    return imageLayerHeight / scaleToValue
  }
  
  func iconViewLayerTextLayerHeiht(_ iconViewLayer: IconView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
    return textLayerHeight / scaleToValue
  }
  
  
}

extension VerticalChartRankingView: IconViewDelegate {
  func iconViewLayerDoneAllAnimation(_ iconView: IconView) {
    if let currentLineView = viewModel.presentedLineViews.last {
      currentLineView.imageLayer.isHidden = false
      currentLineView.textLayer.isHidden = false
      currentLineView.overallLayer.isHidden = false
    }
  }
}
