//
//  RankingViewLineViewProtocol.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

extension VerticalChartRankingView: LineViewDataSource {
  func lineViewStrokeColor(_ lineView: LineView) -> UIColor {
    return Color.getLineViewColor(currentLineCount: viewModel.presentedLineViews.count)
  }
  
  
  func lineViewShouldUseIDLabel(_ lineView: LineView) -> Bool {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewShouldUseIDLabel(self)
  }
  
  func lineViewTextLayerFont(_ lineView: LineView) -> UIFont {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let font = dataSource.verticalChartRankingViewTextLayerFont(self)
    return font
  }
  
  func lineViewIDLabelBackgroundColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewLineViewIDLabelBackgroundColor(self)
    return color
  }
  
  func lineViewIDLabelTextColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewLineViewIDLabelTextColor(self)
    return color
  }
  
  func lineViewIDLabelFont(_ lineView: LineView) -> UIFont {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let font = dataSource.verticalChartRankingViewLineViewIDLabelFont(self)
    return font
  }
  
  func lineViewIDLabelIsSizeToFit(_ lineView: LineView) -> Bool {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let isSizeToFit = dataSource.verticalChartRankingViewLineViewIDLabelIsSizeToFit(self)
    return isSizeToFit
  }
  
  func lineViewMaxValueOfRankingView(_ lineView: LineView) -> Float {
    return viewModel.rankingViewMaxValue
  }
  
  func lineViewDrawLineDuration(_ lineView: LineView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let drawLineDuration = dataSource.verticalChartRankingViewDoDrawLineViewDuration(self)
    return drawLineDuration
  }
  
  func lineViewIconYTransationDuration(_ lineView: LineView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewIconYTransationDuration(self)
  }
  
  func lineViewErasedColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewBackgroundColor(self)
  }
  
  func lineViewWidth(_ lineView: LineView) -> CGFloat {
    return viewModel.lineViewWidth
  }
  
  func lineViewHeight(_ lineView: LineView) -> CGFloat {
    return lineView.bounds.height
  }
  
  func lineViewHeightScale(_ lineView: LineView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewHeightScale(self)
  }
  
  func lineViewImageLayerHeight(_ lineView: LineView) -> CGFloat {
    return viewModel.imageLayerHeight
  }
  
  func lineViewTextLayerHeight(_ lineView: LineView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
  }
  
  func lineViewMaxY(_ lineView: LineView) -> CGFloat {
//    return lineView.frame.maxY
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let lineViewHeight = dataSource.verticalChartRankingViewLineViewHeight(self)
    return bounds.minY + lineViewHeight
  }
  
  func lineViewLineModel(_ lineView: LineView) -> LineModel {
    //TODO: - 要去寫 LineModel == nil 的情況
    return viewModel.currentLineModel ?? LineModel(id: "QQQ", name: "GGG", value: 0, icon: UIImage(), channelImage: UIImage())
  }
  
  func lineViewTextLayerTextColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let textColor = dataSource.verticalChartRankingViewTextLayerTextColor(self)
    return textColor
  }
  
  func lineViewTextLayerBackgroundColor(_ lineView: LineView) -> UIColor {
    return .clear
  }
  
  func lineViewTextLayerFontSize(_ lineView: LineView) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let fontSize = dataSource.verticalChartRankingViewTextLayerFontSize(self)
    return fontSize
  }
}


extension VerticalChartRankingView: LineViewDelegate {
  func lineViewDidAnimationStop(_ lineView: LineView, anim: CAAnimation, finished flag: Bool, id: String) {
    
  }
}
