//
//  ViewController_Color.swift
//  RankingVisualiztionTool
//
//  Created by Chung Han Hsin on 2020/6/16.
//  Copyright © 2020 Chung Han Hsin. All rights reserved.
//

import UIKit

struct Color {
  struct Neutral {
    static let v0  =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // FFFFFF
    static let v10 =  #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9725490196, alpha: 1) // F7F7F8
    static let v20 =  #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.937254902, alpha: 1) // EEEEEF
    static let v30 =  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9019607843, alpha: 1) // E5E5E6
    static let v40 =  #colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8352941176, alpha: 1) // D3D3D5
    static let v50 =  #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7568627451, alpha: 1) // BFBFC1
    static let v60 =  #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6705882353, alpha: 1) // A8A8AB
    static let v70 =  #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5843137255, alpha: 1) // 929295
    static let v80 =  #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.5019607843, alpha: 1) // 7C7C80
    static let v90 =  #colorLiteral(red: 0.4, green: 0.4, blue: 0.4156862745, alpha: 1) // 66666A
    static let v100 = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.337254902, alpha: 1) // 515156
    static let v200 = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2901960784, alpha: 1) // 45454A
    static let v300 = #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2431372549, alpha: 1) // 39393E
    static let v400 = #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1960784314, alpha: 1) // 2C2C32
    static let v500 = #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1490196078, alpha: 1) // 202026
  }
  
  struct Blue {
    static let v0 =   #colorLiteral(red: 0.937254902, green: 0.968627451, blue: 0.9921568627, alpha: 1) // EFF7FD
    static let v10 =  #colorLiteral(red: 0.8235294118, green: 0.8666666667, blue: 0.8941176471, alpha: 1) // D2DDE4
    static let v50 =  #colorLiteral(red: 0.1803921569, green: 0.5647058824, blue: 0.7176470588, alpha: 1) // 2E90B7
    static let v100 = #colorLiteral(red: 0.06274509804, green: 0.337254902, blue: 0.4823529412, alpha: 1) // 10567B
    static let v200 = #colorLiteral(red: 0.02352941176, green: 0.2549019608, blue: 0.3843137255, alpha: 1) // 064162
    static let v300 = #colorLiteral(red: 0, green: 0.2, blue: 0.3294117647, alpha: 1) // 003354
    static let v400 = #colorLiteral(red: 0.09411764706, green: 0.3215686275, blue: 0.6235294118, alpha: 1) // 18529F
  }
  
  struct Green {
    static let v0 =   #colorLiteral(red: 0.8980392157, green: 0.968627451, blue: 0.9568627451, alpha: 1) // E5F7F4
    static let v10 =  #colorLiteral(red: 0.628024065, green: 0.8666666667, blue: 0.8235294118, alpha: 1) // 98DDD2
    static let v50 =  #colorLiteral(red: 0.3254901961, green: 0.7764705882, blue: 0.7058823529, alpha: 1) // 53C6B4
    static let v100 = #colorLiteral(red: 0.1882352941, green: 0.7333333333, blue: 0.6470588235, alpha: 1) // 30BBA5
    static let v200 = #colorLiteral(red: 0.1725490196, green: 0.6745098039, blue: 0.5921568627, alpha: 1) // 2CAC97
    static let v300 = #colorLiteral(red: 0.1568627451, green: 0.6117647059, blue: 0.5411764706, alpha: 1) // 289C8A
    static let v400 = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1) // 0F2E3F
    static let v500 = #colorLiteral(red: 0.1019607843, green: 0.1529411765, blue: 0.2156862745, alpha: 1) // 1A2737
    static let v600 = #colorLiteral(red: 0.01176470588, green: 0.06666666667, blue: 0.1176470588, alpha: 1) // 03111E
  }
  
  struct Yellow {
    static let v0 =   #colorLiteral(red: 0.9960784314, green: 0.9725490196, blue: 0.9176470588, alpha: 1) // FEF8EA
    static let v10 =  #colorLiteral(red: 1, green: 0.8951116791, blue: 0.7837434738, alpha: 1) // FFEDAF
    static let v50 =  #colorLiteral(red: 1, green: 0.8705882353, blue: 0.4431372549, alpha: 1) // FFDE71
    static let v100 = #colorLiteral(red: 0.9803921569, green: 0.7960784314, blue: 0.3019607843, alpha: 1) // FACB4D
    static let v200 = #colorLiteral(red: 0.968627451, green: 0.7411764706, blue: 0.168627451, alpha: 1) // F7BD2B
    static let v300 = #colorLiteral(red: 0.937254902, green: 0.6823529412, blue: 0.03529411765, alpha: 1) // EFAE09
  }
  
  struct Salmon {
    static let v0 =   #colorLiteral(red: 0.9921568627, green: 0.9254901961, blue: 0.9215686275, alpha: 1) // FDECEB
    static let v10 =  #colorLiteral(red: 0.9607843137, green: 0.7019607843, blue: 0.6823529412, alpha: 1) // F5B3AE
    static let v50 =  #colorLiteral(red: 0.914524472, green: 0.5176470588, blue: 0.5146235185, alpha: 1) // EE847D
    static let v100 = #colorLiteral(red: 0.9450980392, green: 0.4235294118, blue: 0.3647058824, alpha: 1) // F16C5D
    static let v200 = #colorLiteral(red: 0.8980392157, green: 0.3764705882, blue: 0.3176470588, alpha: 1) // E56051
    static let v300 = #colorLiteral(red: 0.8549019608, green: 0.337254902, blue: 0.2823529412, alpha: 1) // DA5648
  }
  
  struct MyPink {
    static let v0 =   #colorLiteral(red: 0.9921568627, green: 0.9254901961, blue: 0.9215686275, alpha: 1) // FDECEB
    static let v10 =  #colorLiteral(red: 0.8325736973, green: 0.5819242294, blue: 0.6823529412, alpha: 1) // DA63AE
    static let v50 = #colorLiteral(red: 0.8549019608, green: 0.5, blue: 0.6723197648, alpha: 1) // DA2CAE
    static let v100 = #colorLiteral(red: 0.8666666667, green: 0.3827322346, blue: 0.6823529412, alpha: 1) // DD0FAE
    static let v200 = #colorLiteral(red: 0.8666666667, green: 0.5495772688, blue: 0.6823529412, alpha: 1) // DD0FAE
    static let v300 = #colorLiteral(red: 0.8666666667, green: 0.1607843137, blue: 0.6823529412, alpha: 1) // DD0FAE
  }
  
  struct Purple {
    static let v0 =   #colorLiteral(red: 0.9921568627, green: 0.9254901961, blue: 0.9215686275, alpha: 1) // FDECEB
    static let v10 =  #colorLiteral(red: 0.5568627451, green: 0.6196078431, blue: 0.968627451, alpha: 1) // 8E9EF7
    static let v50 =  #colorLiteral(red: 0.5568627451, green: 0.4980392157, blue: 0.968627451, alpha: 1) // 8E7FF7
    static let v100 =  #colorLiteral(red: 0.5568627451, green: 0.3725490196, blue: 0.968627451, alpha: 1) // 8E5FF7
    static let v200 =  #colorLiteral(red: 0.5641855736, green: 0.2085418135, blue: 0.968627451, alpha: 1) // 8E1BF7
    static let v300 =  #colorLiteral(red: 0.5786571649, green: 0.3533550942, blue: 1, alpha: 1) // 9D00FF
  }
  
  struct Red {
    static let v0 =   #colorLiteral(red: 1, green: 0.9137254902, blue: 0.9254901961, alpha: 1) // FFE9EC
    static let v10 =  #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1) // F86173
    static let v50 = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1) // C83A4C
    static let v100 = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) // C83A4C
    static let v200 = #colorLiteral(red: 0.8078431373, green: 0.3957887414, blue: 0.3333333333, alpha: 1) // C83A4C
    static let v300 =  #colorLiteral(red: 0.5696436216, green: 0, blue: 0, alpha: 1) // FF9EAA
  }
  
  
  
  // Lagacy color system
  struct Pink {
    static let v100 = #colorLiteral(red: 0.9607843137, green: 0.3294117647, blue: 0.5490196078, alpha: 1) // 0xF5548C
    static let v300 = #colorLiteral(red: 0.8392156863, green: 0.2470588235, blue: 0.4823529412, alpha: 1)
  }
  
  struct Gray {
    static let v100 = #colorLiteral(red: 0.7098039216, green: 0.7176470588, blue: 0.7254901961, alpha: 1) // 0x#B5B7B9
    static let v300 = #colorLiteral(red: 0.5137254902, green: 0.568627451, blue: 0.5882352941, alpha: 1) // 0x839196
    static let main = #colorLiteral(red: 0.4235294118, green: 0.4549019608, blue: 0.4901960784, alpha: 1) // 0x6C747D
  }
  
  static func getLineColorWith(value: Float) -> UIColor {
    switch value {
      case 0 ..< 100000:
        return Green.v10
      case 100000 ..< 200000:
        return Green.v50
      case 200000 ..< 300000:
        return Green.v100
      case 300000 ..< 400000:
        return Green.v200
      case 400000 ..< 500000:
        return Green.v300
      case 500000 ..< 600000:
        return Yellow.v10
      case 600000 ..< 700000:
        return Yellow.v50
      case 700000 ..< 800000:
        return Yellow.v100
      case 800000 ..< 900000:
        return Yellow.v200
      case 900000 ..< 1000000:
        return Yellow.v300
      case 1000000 ..< 1100000:
        return MyPink.v10
      case 1100000 ..< 1200000:
        return MyPink.v50
      case 1200000 ..< 1300000:
        return MyPink.v100
      case 1300000 ..< 1400000:
        return MyPink.v200
      case 1400000 ..< 1500000:
        return MyPink.v300
      case 1500000 ..< 1600000:
        return Purple.v10
      case 1600000 ..< 1700000:
        return Purple.v50
      case 1700000 ..< 1800000:
        return Purple.v100
      case 1800000 ..< 1900000:
        return Purple.v200
      case 900000 ..< 2000000:
        return Purple.v300
      case 2000000 ..< 2100000:
        return Red.v10
      case 2100000 ..< 2200000:
        return Red.v50
      case 2200000 ..< 2300000:
        return Red.v100
      case 2300000 ..< 2400000:
        return Red.v200
      default:
        return Red.v300
    }
  }
  
  static func getLineViewColor(currentLineCount: Int) -> UIColor {
    switch currentLineCount {
      case 0 ... 10:
        //yellow
        let blue = CGFloat(200 - currentLineCount * 20)
        return UIColor.init(red: 255/255, green: 228/255, blue: blue/255, alpha: 1)
      case 11 ... 20:
      	//pink
        let green = CGFloat(140 - (currentLineCount - 10) * 14)
      	return UIColor.init(red: 221/255, green: green/255, blue: 174/255, alpha: 1)
      case 21 ... 30:
      	//red
        let red = CGFloat(145 + currentLineCount * 11)
        return UIColor.init(red: red/255, green: 0/255, blue: 0/255, alpha: 1)
      default:
        //purple
        let green = CGFloat(90 - (currentLineCount - 20) * 9)
        return UIColor.init(red: 148/255, green: green/255, blue: 255/255, alpha: 1)
    }
  }
}

struct ThemeColor {
  let verticalRankingViewBgColor: UIColor
  let circleRankingBgColor: UIColor
  let titleViewRankingBgColor: UIColor
}

enum Theme {
  case Default
  case NBA
  case AnimalCrossing
  
  func getThemeColor() -> ThemeColor {
    switch self {
      case .Default:
        return ThemeColor(verticalRankingViewBgColor: Color.Green.v400, circleRankingBgColor: Color.Green.v500, titleViewRankingBgColor: Color.Green.v600)
      case .NBA:
        return ThemeColor(verticalRankingViewBgColor: Color.Blue.v400, circleRankingBgColor: Color.Salmon.v300, titleViewRankingBgColor: Color.Green.v400)
      case .AnimalCrossing:
        return ThemeColor(verticalRankingViewBgColor: Color.Green.v200, circleRankingBgColor: Color.Salmon.v300, titleViewRankingBgColor: Color.Green.v400)
    }
  }
}
