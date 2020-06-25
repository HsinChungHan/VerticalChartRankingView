//
//  IconView.swift
//  ScrollViewTest
//
//  Created by Chung Han Hsin on 2020/5/23.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit
import CANumberTextLayer

protocol IconViewLayerDataSource: AnyObject {
  
  func iconViewLayerLineModel(_ iconViewLayer: IconViewLayer) -> LineModel
  func iconViewLayerXTransationToValue(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerYTransationInitialToValue(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerYTransationToValue(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerScaleToValue(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerScaleXToValue(_ iconViewLayer: IconViewLayer) -> CGFloat
  
  func iconViewLayerLineViewDrawLineDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval
  func iconViewLayerOpacityDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval
  func iconViewLayerStayDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval
  func iconViewLayerFirstXYTransationDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval
  func iconViewLayerTotoalDuration(_ iconViewLayer: IconViewLayer) -> TimeInterval
  
  func iconViewLayerRankingViewMaxValue(_ iconViewLayer: IconViewLayer) -> Float
  func iconViewLayerLineViewHeight(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerLineViewHeightScale(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerlineViewMaxY(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerWidthOfLayer(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerImageLayerHeiht(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerTextLayerHeiht(_ iconViewLayer: IconViewLayer) -> CGFloat
  
  func iconViewLayerTextLayerFontSize(_ iconViewLayer: IconViewLayer) -> CGFloat
  func iconViewLayerTextLayerTextColor(_ iconViewLayer: IconViewLayer) -> UIColor
  func iconViewLayerTextLayerFont(_ iconViewLayer: IconViewLayer) -> UIFont
  func iconViewLayerImageLayerBackgroundColor(_ iconViewLayer: IconViewLayer) -> UIColor
  func iconViewLayerTextLayerBackgroundColor(_ iconViewLayer: IconViewLayer) -> UIColor
}

protocol IconViewLayerDelegate: AnyObject {
  func iconViewLayerDoneAllAnimation(_ iconView: IconViewLayer)
}

class IconViewLayer: CALayer {
  weak var dataSource: IconViewLayerDataSource?
  weak var myDelegate: IconViewLayerDelegate?
  lazy var vm = makeViewModel()
}


extension IconViewLayer {
  
  fileprivate func makeViewModel() -> IconViewLayerViewModel {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    
    let lineModel = dataSource.iconViewLayerLineModel(self)
    let rankingViewMaxValue = dataSource.iconViewLayerRankingViewMaxValue(self)
    let lineViewHeight = dataSource.iconViewLayerLineViewHeight(self)
    let lineViewMaxY = dataSource.iconViewLayerlineViewMaxY(self)
    let lineViewHeightScale = dataSource.iconViewLayerLineViewHeightScale(self)
    let drawLineDuration = dataSource.iconViewLayerLineViewDrawLineDuration(self)
    let opacityDuration = dataSource.iconViewLayerOpacityDuration(self)
    let stayTransation = dataSource.iconViewLayerStayDuration(self)
    let firstXYTransation = dataSource.iconViewLayerFirstXYTransationDuration(self)
    let initialDuration = opacityDuration + stayTransation + firstXYTransation
    
    let vm = IconViewLayerViewModel(lineModel: lineModel, rankingViewMaxValue: rankingViewMaxValue, lineViewHeight: lineViewHeight, lineViewMaxY: lineViewMaxY, lineViewHeightScale: lineViewHeightScale, drawLineDuration: drawLineDuration, initialDuration: initialDuration)
    return vm
  }
  
  fileprivate func makeImageLayer() -> CALayer {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }
    let bgColor = dataSource.iconViewLayerImageLayerBackgroundColor(self).cgColor
    let layer = CALayer()
    layoutIfNeeded()
    layer.frame = bounds
    layer.contents = vm.icon.cgImage
    layer.contentsGravity = .resizeAspect
    layer.backgroundColor = bgColor
    layer.isGeometryFlipped = true
    return layer
  }
  
  fileprivate func makeTextLayer() -> CANumberTextlayer {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }
    let bgColor = dataSource.iconViewLayerTextLayerBackgroundColor(self).cgColor
    let layer = CANumberTextlayer()
    layer.dataSource = self
    layer.setLayerProperties()
    layer.alignmentMode = .center
    layer.backgroundColor = bgColor
    return layer
  }
  
  fileprivate func makeXTransation(fromValue: CGFloat, toValue: CGFloat) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "position.x")
    animation.fromValue = fromValue
    animation.toValue = toValue
    return animation
  }
  
  fileprivate func makeYTransation(fromValue: CGFloat, toValue: CGFloat) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "position.y")
    animation.fromValue = fromValue
    animation.toValue = toValue
    return animation
  }
  
  fileprivate func makeScaleAnimation(toValue: CGFloat) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.fromValue = 1.0
    animation.toValue = toValue
    return animation
  }
  
  fileprivate func makeOpacityAnimation() -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = 0.0
    animation.toValue = 1.0
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    return animation
  }
  
  fileprivate func makeGroupAnimation(groupId: String, duration: TimeInterval, animations: CAAnimation...) -> CAAnimationGroup {
    let group = CAAnimationGroup()
    group.animations = animations
    group.duration = duration
//    group.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
    group.fillMode = .forwards
    group.isRemovedOnCompletion = false
    group.delegate = self
    group.setValue(groupId, forKey: "groupId")
    return group
  }
  
  //第一段動畫，用於 iconImageLayer 一開始淡化出現
  fileprivate func makeOpacityAnimationGroup(groupId id: String) -> CAAnimationGroup {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
  	
    let opacityDuration = dataSource.iconViewLayerOpacityDuration(self)
    let animation = makeOpacityAnimation()
    return makeGroupAnimation(groupId: id, duration: opacityDuration, animations: animation)
  }
  
  //第二段動畫，用於 iconImageLayer 移動到指定的 lineView
  fileprivate func makeStayTransation(groupId id: String) -> CAAnimationGroup {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let duration = dataSource.iconViewLayerStayDuration(self)
    let stayTransation = makeXTransation(fromValue: frame.midX, toValue: frame.midX)
    return makeGroupAnimation(groupId: id, duration: duration, animations: stayTransation)
  }
  
  
  //第三段動畫，用於 iconImageLayer 移動到指定的 lineView
  fileprivate func makeXYTransationAndScaleGroup(groupId id: String, isFirstTimePresented: Bool) -> CAAnimationGroup {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    
    let xTransationToValue = dataSource.iconViewLayerXTransationToValue(self)
    let yTransationToValue = dataSource.iconViewLayerYTransationInitialToValue(self)
    let scaleToValue = dataSource.iconViewLayerScaleToValue(self)
    
    let duration = dataSource.iconViewLayerFirstXYTransationDuration(self)
    
    
    let xTransation = makeXTransation(fromValue: frame.midX, toValue: xTransationToValue)
    
    let yTransation = makeYTransation(fromValue: frame.midY, toValue: yTransationToValue)
    let scaleAnimation = makeScaleAnimation(toValue: scaleToValue)
    
    if isFirstTimePresented {
      return makeGroupAnimation(groupId: id, duration: duration, animations: scaleAnimation, xTransation, yTransation)
    }
    //TODO: - 讓 icon imageLayer 停留在原地
    let stayTransation = makeXTransation(fromValue: frame.midX, toValue: frame.midX)
    return makeGroupAnimation(groupId: id, duration: duration, animations: stayTransation)
  }
  
  //第四段動畫，用於 iconImageLayer 移動到 lineView 的 value 所對應的 YPosition
  fileprivate func makeYTransationGroup(groupId id: String) -> CAAnimationGroup {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    //第四段的 fromValue = 第三段的 toValue
    let yTransationFromValue = dataSource.iconViewLayerYTransationInitialToValue(self)
    let yTransationToValue = dataSource.iconViewLayerYTransationToValue(self)
    let yTransation = makeYTransation(fromValue: yTransationFromValue, toValue: yTransationToValue)
    
    let totalDuration = dataSource.iconViewLayerTotoalDuration(self)
    let opacityAndStayTransationAndFirstXYTransationDuration = vm.opacityAndStayTransationAndFirstXYTransationDuration
    if totalDuration < opacityAndStayTransationAndFirstXYTransationDuration {
      fatalError("🚨 The total duration should larger than initial duration")
    }
    
    let secondGroupDuration = totalDuration - opacityAndStayTransationAndFirstXYTransationDuration
    return makeGroupAnimation(groupId: id, duration: secondGroupDuration, animations: yTransation)
  }
  
  func initializeLayer() {
    removeFromSuperlayer()
    sublayers?.removeAll()
    removeAllAnimations()
  }
  
  func launchAnimation(isFirstTimePresented: Bool) {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }

    let width = dataSource.iconViewLayerWidthOfLayer(self)
    let imageLayerHeight = dataSource.iconViewLayerImageLayerHeiht(self)
    let textLayerHeight = dataSource.iconViewLayerTextLayerHeiht(self)
    let imageLayer = makeImageLayer()
    let textLayer = makeTextLayer()
    addSublayer(imageLayer)
    addSublayer(textLayer)
    
    imageLayer.frame = CGRect(x: 0, y: 0, width: width, height: imageLayerHeight)
    textLayer.frame = CGRect(x: 0, y: imageLayerHeight, width: width, height: textLayerHeight)
    textLayer.launchDisplayLink()
    
    vm.setIsIconLayerFirstPresented(isIconLayerFirstPresented: isFirstTimePresented)
    add(makeOpacityAnimationGroup(groupId: "opacityAnimationGroup"), forKey: "opacityAnimationGroup")
  }
}


extension IconViewLayer: CAAnimationDelegate {
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    let groupId = anim.value(forKey: "groupId") as! String
    
    if groupId == "opacityAnimationGroup" {
      if vm.isIconLayerFirstPresented {
        add(makeStayTransation(groupId: "stayTransationGroupForFirstPresented"), forKey: "stayTransationGroup")
      }else {
         add(makeStayTransation(groupId: "stayTransationGroupForAlreadyPresented"), forKey: "stayTransationGroup")
      }
    }
    
    //這邊是 icon layer 第一次出現，所要做的動畫
    if groupId == "stayTransationGroupForFirstPresented" {
      add(makeXYTransationAndScaleGroup(groupId: "XYTransationAndScaleGroupForFirstTimePresented", isFirstTimePresented: true), forKey: "XYTransationAndScaleGroup")
    }
    
    if groupId == "XYTransationAndScaleGroupForFirstTimePresented" {
      add(makeYTransationGroup(groupId: "YTransationGroupForFirstTimePresented"), forKey: "YTransationGroup")
    }
    
    if groupId == "YTransationGroupForFirstTimePresented" {
      myDelegate?.iconViewLayerDoneAllAnimation(self)
    }
    
    //這邊是已經出現過的 icon layer 所要走的動畫
    if groupId == "stayTransationGroupForAlreadyPresented" {
      add(makeXYTransationAndScaleGroup(groupId: "XYTransationAndScaleGroupForAlreadyPresented", isFirstTimePresented: false), forKey: "XYTransationAndScaleGroup")
    }
    
    if groupId == "stayTransationGroupForAlreadyPresented" {
//      initializeLayer()
    }
  }
}

extension IconViewLayer: CANumberTextLayerDataSource {
  func animationNumberTextLayerStartValue(_ animationNumberLabel: CANumberTextlayer) -> Int {
    var value = Int(vm.value)
    for _ in 0 ... (String(value).count - 2) {
      value = value % 10
    }
    return value
  }
  
  func animationNumberTextLayerEndValue(_ animationNumberLabel: CANumberTextlayer) -> Int {
    let value = Int(vm.value)
    return value
  }
  
  func animationNumberTextLayerDuration(_ animationNumberLabel: CANumberTextlayer) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let totalDuration = dataSource.iconViewLayerTotoalDuration(self)
    return totalDuration
  }
  
  func animationNumberTextLayerBackgroundColor(_ animationNumberLabel: CANumberTextlayer) -> UIColor {
    return .clear
  }
  
  func animationNumberTextLayerTextColor(_ animationNumberLabel: CANumberTextlayer) -> UIColor {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let color = dataSource.iconViewLayerTextLayerTextColor(self)
    return color
  }
  
  func animationNumberTextLayerLabelFont(_ animationNumberLabel: CANumberTextlayer) -> UIFont {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let font = dataSource.iconViewLayerTextLayerFont(self)
    return font
  }
  
  func animationNumberTextLayerLabelFontSize(_ animationNumberLabel: CANumberTextlayer) -> CGFloat {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let scale = dataSource.iconViewLayerScaleToValue(self)
    let fontSize = dataSource.iconViewLayerTextLayerFontSize(self)
    return fontSize / scale
//    return 22 / scale
  }
  
  func animationNumberTextLayerTextAlignment(_ animationNumberLabel: CANumberTextlayer) -> CATextLayerAlignmentMode {
    return .center
  }
}
