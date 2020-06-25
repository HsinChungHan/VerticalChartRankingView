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
  
  func verticalChartRankingViewContentSizeWidth(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewBackgroundColor(_ rankingView: VerticalChartRankingView) -> UIColor
  
  func verticalChartRankingViewLineViewIDLabelBackgroundColor(_ rankingView: VerticalChartRankingView) -> UIColor
  func verticalChartRankingViewLineViewIDLabelTextColor(_ rankingView: VerticalChartRankingView) -> UIColor
  func verticalChartRankingViewLineViewIDLabelFont(_ rankingView: VerticalChartRankingView) -> UIFont
  func verticalChartRankingViewLineViewIDLabelIsSizeToFit(_ rankingView: VerticalChartRankingView) -> Bool
  
  func verticalChartRankingViewOneRoundDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  
  func verticalChartRankingViewXTransactionDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewDoDrawLineViewDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  
  func verticalChartRankingViewIconViewLayerOpacityDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewIconViewLayerStayDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewIconViewLayerFirstXYTransationDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  func verticalChartRankingViewIconViewLayerTotoalDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  
  func verticalChartRankingViewLineViewIconYTransationDuration(_ rankingView: VerticalChartRankingView) -> TimeInterval
  
  func verticalChartRankingViewNumberOfPresentedViews(_ rankingView: VerticalChartRankingView) -> Int
  func verticalChartRankingViewPadding(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineModels(_ rankingView: VerticalChartRankingView) -> [(id: String, value: Float, icon: String, description: String)]
  
  func verticalChartRankingViewLineViewHeightScale(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewTextLayerHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewIconViewLayerScaleToValue(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewIconViewLayerScaleXToValue(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewHeight(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewLineViewColor(_ rankingView: VerticalChartRankingView) -> UIColor
  
  func verticalChartRankingViewTextLayerFontSize(_ rankingView: VerticalChartRankingView) -> CGFloat
  func verticalChartRankingViewTextLayerTextColor(_ rankingView: VerticalChartRankingView) -> UIColor
  func verticalChartRankingViewTextLayerFont(_ rankingView: VerticalChartRankingView) -> UIFont
}

public protocol VerticalChartRankingViewDelegate: AnyObject {
  func verticalChartRankingDidStart(_ rankingView: VerticalChartRankingView)
  func verticalChartRankingDidStop(_ rankingView: VerticalChartRankingView)
}

public class VerticalChartRankingView: UIView {
  
  public weak var dataSource: VerticalChartRankingViewDataSource?
  public weak var delegate: VerticalChartRankingViewDelegate?
  
  lazy var viewModel = makeRankingViewVM()
  lazy var scrollView = makeScrollView()
  lazy var overallView = makeOverallView()
  var lastIconViewLayer: IconViewLayer?
  var timer: Timer?
  
  public func launch() {
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
    let oneRoundDuration = dataSource.verticalChartRankingViewOneRoundDuration(self)
    
    let timer = Timer.init(timeInterval: oneRoundDuration, target: self, selector: #selector(onTimerFires(sender:)), userInfo: nil, repeats: true)
    return timer
  }
  
  @objc func onTimerFires(sender: Timer) {
    delegate?.verticalChartRankingDidStart(self)
    lastIconViewLayer?.initializeLayer()
    guard let lineModel = viewModel.lineModelsPopLast(), let dataSource = dataSource else {
      invalidateTimer()
      scrollView.isScrollEnabled = true
      return
    }
    let imageLayerHeight = viewModel.imageLayerHeight
    let textLayerHeight = dataSource.verticalChartRankingViewLineViewTextLayerHeight(self)
    let scale = dataSource.verticalChartRankingViewIconViewLayerScaleToValue(self)
    let scaleX = dataSource.verticalChartRankingViewIconViewLayerScaleXToValue(self)
    let width = viewModel.lineViewWidth / scaleX
    let iconViewLayerHeight = (imageLayerHeight + textLayerHeight) / scale
    
    //在這邊決定好 rank
    viewModel.updatePresentedRank(currentLineModel: lineModel)
    
    //設定 iconViewLayer
    let iconViewLayer = makeIconViewLayer()
    lastIconViewLayer = iconViewLayer
    iconViewLayer.frame = CGRect(x: frame.midX - width / 2 , y: bounds.minY, width: width, height: iconViewLayerHeight)
    
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
    delegate?.verticalChartRankingDidStop(self)
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
  
  fileprivate func makeRankingViewVM() -> VeritcalChartRankingViewVM {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let numberOfPresentingViews = dataSource.verticalChartRankingViewNumberOfPresentedViews(self)
    let padding = dataSource.verticalChartRankingViewPadding(self)
    let lineModelTuples = dataSource.verticalChartRankingViewLineModels(self)
    var lineModels = [LineModel]()
    for tuple in lineModelTuples {
      let lineModel = LineModel(id: tuple.id, value: tuple.value, icon: UIImage(named: tuple.icon)!)
      lineModels.append(lineModel)
    }
    layoutIfNeeded()
    let vm = VeritcalChartRankingViewVM(numberOfPresentingViews: numberOfPresentingViews, padding: padding, rawDataOflineModels: lineModels, rankingViewWidth: bounds.width)
    return vm
  }
  
  fileprivate func makeScrollView() -> UIScrollView {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for RankingView.")
    }
    let color = dataSource.verticalChartRankingViewBackgroundColor(self)
    let scrollView = UIScrollView()
    //    scrollView.delegate = self
    scrollView.isScrollEnabled = false
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
