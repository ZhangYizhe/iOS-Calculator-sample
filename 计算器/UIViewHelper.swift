//
//  UIViewHelper.swift
//  计算器
//
//  Created by 张艺哲 on 2017/8/1.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit

extension UIView{
    @IBInspectable var boardwidth: CGFloat {//边框宽度
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {//边框颜色
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {//边框圆角
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0 //裁边
        }
    }
}

@IBDesignable class MyPreviewButton: UIButton {//方法可视化
    
}
