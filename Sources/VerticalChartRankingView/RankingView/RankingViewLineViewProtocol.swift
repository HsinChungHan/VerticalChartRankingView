//
//  RankingViewLineViewProtocol.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

extension VerticalChartRankingView: LineViewDataSource {
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
  
  func lineViewIconTransationDuration(_ lineView: LineView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewIconTransationDuration(self)
  }
  
  func lineViewErasedColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewBackgroundColor(self)
  }
  
  func lineViewStrokeColor(_ lineView: LineView) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewColor(self)
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
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return viewModel.imageLayerHeight
//      dataSource.verticalChartRankingViewLineViewImageLayerHeight(self)
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
    return frame.minY + lineViewHeight
  }
  
  func lineViewLineModel(_ lineView: LineView) -> LineModel {
    //TODO: - 要去寫 LineModel == nil 的情況
    return viewModel.currentLineModel ?? LineModel(id: "QQQ", value: 0, icon: UIImage())
  }
  
  func lineViewTextLayerTextColor(_ lineView: LineView) -> UIColor {
    return .white
  }
  
  func lineViewTextLayerBackgroundColor(_ lineView: LineView) -> UIColor {
    return .clear
  }
  
  func lineViewTextLayerFontSize(_ lineView: LineView) -> CGFloat {
    return 22
  }
}


extension VerticalChartRankingView: LineViewDelegate {
  func lineViewDidAnimationStop(_ lineView: LineView, anim: CAAnimation, finished flag: Bool, id: String) {
    
  }
}
