//
//  IconView.swift
//  ScrollViewTest
//
//  Created by Chung Han Hsin on 2020/5/23.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit
import CANumberTextLayer
import HsinUtils
import TinderStyleWipedCard

public enum ImageType {
  case layerType
  
  //contentMode=aspectFill, gradientLayer=true, informationLabel=true
  case defaultDeskViewType
  
  //contentMode=aspectFit, gradientLayer=false, informationLabel=false
  case puredDeskViewType
}

protocol IconViewDataSource: AnyObject {
  
  func iconViewLayerLineModel(_ iconViewLayer: IconView) -> LineModel
  func iconViewLayerXTransationToValue(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerYTransationInitialToValue(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerYTransationToValue(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerScaleToValue(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerScaleXToValue(_ iconViewLayer: IconView) -> CGFloat
  
  func iconViewLayerLineViewDrawLineDuration(_ iconViewLayer: IconView) -> TimeInterval
  func iconViewLayerOpacityDuration(_ iconViewLayer: IconView) -> TimeInterval
  func iconViewLayerStayDuration(_ iconViewLayer: IconView) -> TimeInterval
  func iconViewLayerFirstXYTransationDuration(_ iconViewLayer: IconView) -> TimeInterval
  func iconViewLayerTotoalDuration(_ iconViewLayer: IconView) -> TimeInterval
  
  func iconViewLayerRankingViewMaxValue(_ iconViewLayer: IconView) -> Float
  func iconViewLayerLineViewHeight(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerLineViewHeightScale(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerlineViewMaxY(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerWidthOfLayer(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerImageLayerHeiht(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerTextLayerHeiht(_ iconViewLayer: IconView) -> CGFloat
  
  func iconViewLayerTextLayerFontSize(_ iconViewLayer: IconView) -> CGFloat
  func iconViewLayerTextLayerTextColor(_ iconViewLayer: IconView) -> UIColor
  func iconViewLayerTextLayerFont(_ iconViewLayer: IconView) -> UIFont
  func iconViewLayerImageLayerBackgroundColor(_ iconViewLayer: IconView) -> UIColor
  func iconViewLayerTextLayerBackgroundColor(_ iconViewLayer: IconView) -> UIColor
  
  func iconViewLayerImageType(_ iconViewLayer: IconView) -> ImageType
  
  
}

protocol IconViewDelegate: AnyObject {
  func iconViewLayerDoneAllAnimation(_ iconView: IconView)
}

class IconView: UIView {
  weak var dataSource: IconViewDataSource?
  weak var myDelegate: IconViewDelegate?
  lazy var vm = makeViewModel()
}


extension IconView {
  
  fileprivate func makeViewModel() -> IconViewVM {
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
    
    let vm = IconViewVM(lineModel: lineModel, rankingViewMaxValue: rankingViewMaxValue, lineViewHeight: lineViewHeight, lineViewMaxY: lineViewMaxY, lineViewHeightScale: lineViewHeightScale, drawLineDuration: drawLineDuration, initialDuration: initialDuration)
    return vm
  }
  
  fileprivate func makeCardDeskView() -> CardDeskView {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }
    let bgColor = dataSource.iconViewLayerImageLayerBackgroundColor(self)
    let deskView = CardDeskView()
    deskView.backgroundColor = bgColor
    deskView.dataSource = self
    return deskView
  }
  
  fileprivate func makeImageLayer() -> CALayer {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }
    let bgColor = dataSource.iconViewLayerImageLayerBackgroundColor(self).cgColor
    let layer = CALayer()
    layoutIfNeeded()
    layer.frame = bounds
    layer.contents = vm.icons.last!.cgImage
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
    removeFromSuperview()
    layer.sublayers?.removeAll()
    layer.removeAllAnimations()
//    removeFromSuperlayer()
//    sublayers?.removeAll()
//    removeAllAnimations()
  }
  
  func launchAnimation(isFirstTimePresented: Bool) {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconViewLayer")
    }

    let width = dataSource.iconViewLayerWidthOfLayer(self)
    let imageLayerHeight = dataSource.iconViewLayerImageLayerHeiht(self)
    let textLayerHeight = dataSource.iconViewLayerTextLayerHeiht(self)
    let imageType = dataSource.iconViewLayerImageType(self)
    //在這邊決定要用 deskView 還是 imageLayer
    switch imageType {
      case .layerType:
      	let imageLayer = makeImageLayer()
       	layer.addSublayer(imageLayer)
      	imageLayer.frame = CGRect(x: 0, y: 0, width: width, height: imageLayerHeight)
      default:
      	let imageDeskView = makeCardDeskView()
      	addSubview(imageDeskView)
      	imageDeskView.frame = CGRect(x: 0, y: 0, width: width, height: imageLayerHeight)
        imageDeskView.putIntoCards()
        imageDeskView.launchTimer()
    }
    
    let textLayer = makeTextLayer()
    layer.addSublayer(textLayer)
    textLayer.frame = CGRect(x: 0, y: imageLayerHeight, width: width, height: textLayerHeight)
    textLayer.launchDisplayLink()
    
    vm.setIsIconLayerFirstPresented(isIconLayerFirstPresented: isFirstTimePresented)
    layer.add(makeOpacityAnimationGroup(groupId: "opacityAnimationGroup"), forKey: "opacityAnimationGroup")
  }
}


extension IconView: CAAnimationDelegate {
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    let groupId = anim.value(forKey: "groupId") as! String
    
    if groupId == "opacityAnimationGroup" {
      if vm.isIconLayerFirstPresented {
        layer.add(makeStayTransation(groupId: "stayTransationGroupForFirstPresented"), forKey: "stayTransationGroup")
      }else {
         layer.add(makeStayTransation(groupId: "stayTransationGroupForAlreadyPresented"), forKey: "stayTransationGroup")
      }
    }
    
    //這邊是 icon layer 第一次出現，所要做的動畫
    if groupId == "stayTransationGroupForFirstPresented" {
      layer.add(makeXYTransationAndScaleGroup(groupId: "XYTransationAndScaleGroupForFirstTimePresented", isFirstTimePresented: true), forKey: "XYTransationAndScaleGroup")
    }
    
    if groupId == "XYTransationAndScaleGroupForFirstTimePresented" {
      layer.add(makeYTransationGroup(groupId: "YTransationGroupForFirstTimePresented"), forKey: "YTransationGroup")
    }
    
    if groupId == "YTransationGroupForFirstTimePresented" {
      myDelegate?.iconViewLayerDoneAllAnimation(self)
    }
    
    //這邊是已經出現過的 icon layer 所要走的動畫
    if groupId == "stayTransationGroupForAlreadyPresented" {
      layer.add(makeXYTransationAndScaleGroup(groupId: "XYTransationAndScaleGroupForAlreadyPresented", isFirstTimePresented: false), forKey: "XYTransationAndScaleGroup")
    }
    
    if groupId == "stayTransationGroupForAlreadyPresented" {
//      initializeLayer()
    }
  }
}

extension IconView: CANumberTextLayerDataSource {
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

extension IconView: CardDeskViewDataSource {
  func cardDeskViewCardShouldAddBarStackView(_ cardDeskView: CardDeskView) -> Bool {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let type = dataSource.iconViewLayerImageType(self)
    switch type {
      case .puredDeskViewType:
        return false
      default:
        return true
    }
  }
  
  func cardDeskViewCardPhotoContentMode(_ cardDeskView: CardDeskView) -> UIView.ContentMode {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let type = dataSource.iconViewLayerImageType(self)
    switch type {
      case .puredDeskViewType:
        return .scaleAspectFit
      default:
      	return .scaleAspectFill
    }
  }
  
  func cardDeskViewCardShouldAddGradientLayer(_ cardDeskView: CardDeskView) -> Bool {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let type = dataSource.iconViewLayerImageType(self)
    switch type {
      case .puredDeskViewType:
        return false
      default:
        return true
    }
  }
  
  func cardDeskViewCardShouldAddInformationLabel(_ cardDeskView: CardDeskView) -> Bool {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let type = dataSource.iconViewLayerImageType(self)
    switch type {
      case .puredDeskViewType:
        return false
      default:
        return true
    }
  }
  
  func cardDeskViewARoundDuration(_ cardDeskView: CardDeskView) -> TimeInterval {
    guard let dataSource = dataSource else {
      fatalError("🚨 You have to set dataSource for IconView")
    }
    let duration = (dataSource.iconViewLayerStayDuration(self) + dataSource.iconViewLayerOpacityDuration(self)) / Double(vm.iconNames.count)
    
    return duration
  }
  
  func cardDeskViewAllCardViewModelTuples(_ cardDeskView: CardDeskView) -> [(title: String, textAlignment: NSTextAlignment, images: [String])] {
    return [(title: vm.title, textAlignment: .center, images: vm.iconNames)]
  }
}
