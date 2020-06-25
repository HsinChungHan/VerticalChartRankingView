//
//  RankingViewVM.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

class VeritcalChartRankingViewVM {
  let numberOfPresentingViews: Int
  let padding: CGFloat
  let rankingViewWidth: CGFloat
  
  private(set) var rawDataOflineModels: [LineModel]
  private(set) var currentLineModel: LineModel?
  fileprivate var presentedLineModels = [LineModel]()
  private(set) var presentedLineViews = [LineView]()
  
  var rankingViewMaxValue: Float {
    let maxValue: Float = currentLineModel?.value ?? 0
    for lineModel in presentedLineModels {
      //TODO: - 未來如果有確實排名的話，可以改此種寫法。目前因為要測試的關係先用下面的方法
      if lineModel.rank == 0 {
        return max(lineModel.value, maxValue)
      }
//      maxValue = max(maxValue, lineModel.value)
    }
    return maxValue
  }
  
  var lineViewWidth: CGFloat {
    let calculator = Calculator()
    return calculator.calculateLineViewWidth(rankingViewWidth: rankingViewWidth, padding: padding, numberOfPresentedViews: numberOfPresentingViews)
  }
  
  var imageLayerHeight: CGFloat {
    return lineViewWidth
  }
  
  var currentLineView: LineView? {
    if let currentLineModel = currentLineModel {
      for lineView in presentedLineViews {
        if lineView.viewModel.id == currentLineModel.id {
          return lineView
        }
      }
    }
    return nil
  }
  
  var isCurrentLineModelAlreadyExistInPresentedLineModels: Bool {
    //TODO: - 要去思考 currentLineModel 為 nil 時的情況
    if let currentLineModel = currentLineModel {
      for lineModel in presentedLineModels {
        if lineModel.id == currentLineModel.id {
          return true
        }
      }
    }
    return false
  }
  
  init(numberOfPresentingViews: Int, padding: CGFloat, rawDataOflineModels: [LineModel], rankingViewWidth: CGFloat) {
    self.numberOfPresentingViews = numberOfPresentingViews
    self.padding = padding
    self.rawDataOflineModels = rawDataOflineModels
    self.rankingViewWidth = rankingViewWidth
  }
  
  //每次外面的 timer 都會最先呼叫這個 function
  func lineModelsPopLast() -> LineModel? {
    guard let lineModel = rawDataOflineModels.popLast() else {
      return nil
    }
    currentLineModel = lineModel
    return lineModel
  }
  
  func updatePresentedRank(currentLineModel: LineModel) {
    var newPresentedLineModels: [LineModel]
    
    if isCurrentLineModelAlreadyExistInPresentedLineModels {
      for (index, model) in presentedLineModels.enumerated() {
        if model.id == currentLineModel.id {
          presentedLineModels[index] = currentLineModel
          presentedLineViews[index].viewModel.setLineModel(currentLineModel)
          presentedLineViews[index].viewModel.didChangeValue()
          break
        }
      }
      newPresentedLineModels = presentedLineModels
    }else {
      newPresentedLineModels = presentedLineModels
      newPresentedLineModels.append(currentLineModel)
    }
    
    //找到排序過後的 PresentedLineModels
    let sortedNewPresentedLineModels = Heap(sort: <, elements: newPresentedLineModels).heapSorted()
    //將排序過後的 PresentedLineModels，利用 index 更新成新的 rank
    for (index, _) in sortedNewPresentedLineModels.enumerated() {
      sortedNewPresentedLineModels[index].setRank(index)
    }
    
    //最後去更新 currentLineModel, presentedLineModels, presentedRankingNodeView 的 rank
    for (newModelIndex, newModel) in sortedNewPresentedLineModels.enumerated() {
      if newModel.id == currentLineModel.id {
        self.currentLineModel?.setRank(newModelIndex)
      }
      
      for (modelIndex, model) in presentedLineModels.enumerated() {
        if model.id == newModel.id {
          presentedLineModels[modelIndex].setRank(newModel.rank)
          presentedLineViews[modelIndex].viewModel.setRank(newModel.rank)
          break
        }
      }
    }
  }
  
  func appendInPresentedLineModelsWith(lineModel: LineModel) {
    presentedLineModels.append(lineModel)
  }
  
  func appendInPresentedLineViewsWith(lineView: LineView) {
    presentedLineViews.append(lineView)
  }
}
