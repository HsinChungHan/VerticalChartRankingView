//
//  RankingViewIconViewLayerProtocol.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

extension VerticalChartRankingView: IconViewLayerDataSource {
  
  func iconViewLayerOpacityDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerOpacityDuration(self)
  }
  
  func iconViewLayerLineViewHeightScale(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewHeightScale(self)
  }
  
  func iconViewLayerLineModel(_ iconViewLayer: IconViewLayer) -> LineModel {
    //TODO: - 要去寫 LineModel == nil 的情況
    return viewModel.currentLineModel ?? LineModel(id: "QQQ", value: 0, icon: UIImage())
  }
  
  func iconViewLayerXTransationToValue(_ iconViewLayer: IconViewLayer) -> CGFloat {
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
  
  func iconViewLayerYTransationInitialToValue(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let lineViewIconHeight = imageLayerHeight + textLayerHeight
    return iconViewLayer.vm.initialTransationY - lineViewIconHeight / 2
  }
  
  func iconViewLayerYTransationToValue(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let lineViewIconHeight = imageLayerHeight + textLayerHeight
    return iconViewLayer.vm.transationYToValue - lineViewIconHeight / 2
  }
  
  func iconViewLayerScaleToValue(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
  }
  
  func iconViewLayerScaleXToValue(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewIconViewLayerScaleXToValue(self)
  }
  
  func iconViewLayerLineViewDrawLineDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewDoDrawLineViewDuration(self)
    return duration
  }
  
  func iconViewLayerInitialYTransationDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewIconViewLayerInitialYTransationDuration(self)
    return duration
  }
  
  func iconViewLayerTotoalDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let duration = dataSource.verticalChartRankingViewIconViewLayerTotoalDuration(self)
    return duration
  }
  
  func iconViewLayerRankingViewMaxValue(_ iconViewLayer: IconViewLayer) -> Float {
    return viewModel.rankingViewMaxValue
  }
  
  func iconViewLayerLineViewHeight(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
         fatalError("🚨 You have to set dataSource for RankingView.")
    }
    return dataSource.verticalChartRankingViewLineViewHeight(self)
  }
  
  func iconViewLayerlineViewMaxY(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
         fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let lineViewHeight = dataSource.verticalChartRankingViewLineViewHeight(self)
    return bounds.minY + lineViewHeight
  }
  
  func iconViewLayerWidthOfLayer(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleXToValue(self)
    return viewModel.lineViewWidth / scaleToValue
  }
  
  func iconViewLayerImageLayerHeiht(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
    return imageLayerHeight / scaleToValue
  }
  
  func iconViewLayerTextLayerHeiht(_ iconViewLayer: IconViewLayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let scaleToValue = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
    return textLayerHeight / scaleToValue
  }
  
  
}

extension VerticalChartRankingView: IconViewLayerDelegate {
  func iconViewLayerDoneAllAnimation(_ iconView: IconViewLayer) {
    if let currentLineView = viewModel.presentedLineViews.last {
      currentLineView.imageLayer.isHidden = false
      currentLineView.textLayer.isHidden = false
      currentLineView.overallLayer.isHidden = false
    }
  }
}
