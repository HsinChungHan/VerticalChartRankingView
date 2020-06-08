//
//  RankingView.swift
//  RankingSystem
//
//  Created by Chung Han Hsin on 2020/6/1.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit
import HsinUtils

//MARK: - RankingViewDataSource
public protocol VerticalChartRankingViewDataSource: AnyObject {
  typealias LineModelTuple = (id: String, value: String, icon: String)
  
  func verticalChartRankingViewContentSizeWidth(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewBackgroundColor(_ rankingView: VerticalChartRankingView) -> UIColor
  func verticalChartRankingViewXTransactionDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewDoDrawLineViewDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewDoDrawLineAnimationWhileTransation(_ rankingView: VerticalChartRankingView) -> Bool
  func verticalChartRankingViewNumberOfPresentedViews(_ rankingView: VerticalChartRankingView) -> Int
  func verticalChartRankingViewPadding(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineModels(_ rankingView: VerticalChartRankingView) -> [LineModelTuple]
  func verticalChartRankingViewLineViewIconTransationDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewLineViewHeightScale(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewImageLayerHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewTextLayerHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewIconViewLayerScaleToValue(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewIconViewLayerOpacityDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewIconViewLayerInitialYTransationDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewIconViewLayerTotoalDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewColor(_ rankingView: VerticalChartRankingView) -> UIColor
}

public class VerticalChartRankingView: UIView {
  
  public weak var dataSource: VerticalChartRankingViewDataSource?
  
  lazy var viewModel = makeRankingViewVM()
  lazy var scrollView = makeScrollView()
  lazy var overallView = makeOverallView()
  var lastIconViewLayer: IconViewLayer?
  var timer: Timer?
  
  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let width = dataSource.verticalChartRankingViewContentSizeWidth(self)
    scrollView.contentSize = .init(width: width, height: bounds.height)
    setupLayout()
    timer = makeTimer()
    RunLoop.current.add(timer!, forMode: .common)
  }
  
  fileprivate func makeTimer() -> Timer {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let shouldDoDrawAnimationWhileTransation = dataSource.verticalChartRankingViewDoDrawLineAnimationWhileTransation(self)
    let drawLineDuration = dataSource.verticalChartRankingViewDoDrawLineViewDuration(self)
    let lineViewIconDuration = dataSource.verticalChartRankingViewLineViewIconTransationDuration(self)
    let transationDuration = dataSource.verticalChartRankingViewXTransactionDuration(self)
    //每次做完所有動畫後，再多一秒的停頓
    var totalDuration: TimeInterval = 0.0
    if shouldDoDrawAnimationWhileTransation {
      totalDuration = max(drawLineDuration, lineViewIconDuration, transationDuration) + 1
    }else {
      totalDuration = transationDuration + max(drawLineDuration, lineViewIconDuration) + 1
    }
    let timer = Timer.init(timeInterval: totalDuration, target: self, selector: #selector(onTimerFires(sender:)), userInfo: nil, repeats: true)
    return timer
  }
  
  @objc func onTimerFires(sender: Timer) {
    lastIconViewLayer?.initializeLayer()
      guard let lineModel = viewModel.lineModelsPopLast(), let dataSource = dataSource else {
        invalidateTimer()
        return
      }
      let imageLayerHeight = dataSource.verticalChartRankingViewLineViewImageLayerHeight(self)
      let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
      let scale = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
      let width = viewModel.lineViewWidth / scale
      let iconViewLayerHeight = (imageLayerHeight + textLayerHeight) / scale
      
      //在這邊決定好 rank
      viewModel.updatePresentedRank(currentLineModel: lineModel)
      
      //設定 iconViewLayer
      let iconViewLayer = makeIconViewLayer()
      lastIconViewLayer = iconViewLayer
      iconViewLayer.frame = CGRect(x: frame.midX - width / 2 , y: frame.minY, width: width, height: iconViewLayerHeight)
    
      if viewModel.isCurrentLineModelAlreadyExistInPresentedLineModels {
        if let currentLineView = viewModel.currentLineView {
          currentLineView.updateDrawLine()
          //FIXME: - 不知為何不能寫在外面，否則 scroll 的時候會 crash
          overallView.layer.addSublayer(iconViewLayer)
          iconViewLayer.launchAnimation(isFirstTimePresented: false)
        }
      }else {
        viewModel.appendInPresentedLineModelsWith(lineModel: lineModel)
        let lineView = makeLineView()
        viewModel.appendInPresentedLineViewsWith(lineView: lineView)
        
        overallView.addSubview(lineView)
        lineView.anchor(top: overallView.topAnchor, bottom: nil, leading: nil, trailing: overallView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: viewModel.lineViewWidth), size: .init(width: viewModel.lineViewWidth, height: bounds.height))
        superview?.layoutIfNeeded()
        lineView.drawLine()
        //FIXME: - 不知為何不能寫在外面，否則 scroll 的時候會 crash
        overallView.layer.addSublayer(iconViewLayer)
        iconViewLayer.launchAnimation(isFirstTimePresented: true)
      }
      
      moveLineViews(lineViews: viewModel.presentedLineViews)
      viewModel.presentedLineViews.forEach {
        $0.updateDrawLine()
      }
  }
  
  func invalidateTimer() {
    if let _ = timer {
      timer!.invalidate()
    }
    timer = nil
  }
  
  //因為 CABasicAnimation 會以 view 的中心點去對齊 fromValue 和 toValue
  //所以 fromValue 要加上 width / 2，toValue 要減去 width / 2
  //fromValue 動畫的起點
  //toValue 動畫的終點
  fileprivate func makeXTransationAnimation(lineView view: LineView, padding: CGFloat, width: CGFloat, duration: TimeInterval) -> CAAnimation {
    let animation = CASpringAnimation(keyPath: "position.x")
    animation.fromValue = view.viewModel.transationFromValue
    let calculator = Calculator()
    let toValue = CGFloat(Int(calculator.calculateXTransationToValue(padding: padding, rank: view.viewModel.rank, lineViewWidth: viewModel.lineViewWidth) + width / 2))
    animation.toValue = toValue
    view.viewModel.setNextRoundTransationFromValue(toValue)
    animation.duration = duration
    animation.fillMode = .forwards
    animation.isRemovedOnCompletion = false
    animation.delegate = self
    animation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
    //為了可以在 didStopDelegate 中可以用來辨識特定的 current lineView animation，等等要讓 lineView drawLine
    animation.setValue(view, forKey: "lineViewTransation")
    return animation
  }
  
  
  fileprivate func moveLineViews(lineViews views: [LineView]) {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView")
    }
    let padding = dataSource.verticalChartRankingViewPadding(self)
    let duration = dataSource.verticalChartRankingViewXTransactionDuration(self)
    let width = viewModel.lineViewWidth
    
    for view in views {
      let animation = makeXTransationAnimation(lineView: view, padding: padding, width: width, duration: duration)
      view.layer.add(animation, forKey: "translation")
    }
    CATransaction.begin()
    CATransaction.commit()
  }
  
  fileprivate func makeRankingViewVM() -> RankingViewVM {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let numberOfPresentingViews = dataSource.verticalChartRankingViewNumberOfPresentedViews(self)
    let padding = dataSource.verticalChartRankingViewPadding(self)
    let lineModelTuples = dataSource.verticalChartRankingViewLineModels(self).reversed()
    var lineModels = [LineModel]()
    for tuple in lineModelTuples {
      let lineModel = LineModel(id: tuple.id, value: Float(tuple.value)!, icon: UIImage(named: tuple.icon)!)
      lineModels.append(lineModel)
    }
    layoutIfNeeded()
    let vm = RankingViewVM(numberOfPresentingViews: numberOfPresentingViews, padding: padding, rawDataOflineModels: lineModels, rankingViewWidth: bounds.width)
    return vm
  }
  
  fileprivate func makeScrollView() -> UIScrollView {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewBackgroundColor(self)
    let scrollView = UIScrollView()
//    scrollView.delegate = self
    scrollView.isScrollEnabled = true
    scrollView.backgroundColor = color
    return scrollView
  }
  
  fileprivate func makeOverallView() -> UIView {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewBackgroundColor(self)
    let view = UIView()
    view.backgroundColor = color
    return view
  }
  
  func makeLineView() -> LineView {
    let view = LineView()
    view.dataSource = self
    view.delegate = self
    return view
  }
  
  func makeIconViewLayer() -> IconViewLayer {
    let layer = IconViewLayer()
    layer.dataSource = self
    layer.myDelegate = self
    layer.delegate = self
    return layer
  }
  
  fileprivate func setupLayout() {
    addSubview(scrollView)
    scrollView.fillSuperView()
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let backgroundColor = dataSource.verticalChartRankingViewBackgroundColor(self)
    let width = dataSource.verticalChartRankingViewContentSizeWidth(self)
    let height = dataSource.verticalChartRankingViewHeight(self)
    scrollView.backgroundColor = backgroundColor
    scrollView.addSubview(overallView)
    overallView.anchor(top: scrollView.topAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: nil, size: .init(width: width, height: height))
    layoutIfNeeded()
  }
}

extension VerticalChartRankingView: CAAnimationDelegate {
  
}
