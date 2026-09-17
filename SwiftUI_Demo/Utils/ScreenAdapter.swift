//
//  ScreenAdapter.swift
//  test
//
//  Created by 马腾 on 2023/11/14.
//

import UIKit


class ScreenAdapter: NSObject {
    
    // 固定的设计稿宽度
    static let designWidth: CGFloat = 390
    static let designHeight: CGFloat = 844

    // 根据目标尺寸和项目尺寸自动计算尺寸
    static func adaptSizeWithX(itemSize: CGFloat) -> CGFloat {
        let targetSize = UIScreen.main.bounds.width
        let sizeRatio = targetSize / designWidth
        return itemSize * sizeRatio
    }
    
    static func adaptSizeWithY(itemSize: CGFloat) -> CGFloat {
        let targetSize = UIScreen.main.bounds.height
        let sizeRatio = targetSize / designHeight
        return itemSize * sizeRatio
    }
    

}
// 定义一个全局函数来简化调用
@inline(__always) func adaptX(_ size: CGFloat) -> CGFloat {
    return ScreenAdapter.adaptSizeWithX(itemSize: size)
}

@inline(__always) func adaptY(_ size: CGFloat) -> CGFloat {
    return ScreenAdapter.adaptSizeWithY(itemSize: size)
}
