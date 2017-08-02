//
//  PublicSound.swift
//  计算器
//
//  Created by 张艺哲 on 2017/8/2.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import AudioToolbox

func BtnSound(){
    //建立的SystemSoundID对象
    var soundID:SystemSoundID = 0
    //获取声音地址
    let path = Bundle.main.path(forResource: "BtnTapSound", ofType: "wav")
    //地址转换
    let baseURL = NSURL(fileURLWithPath: path!)
    //赋值
    AudioServicesCreateSystemSoundID(baseURL, &soundID)
    //播放声音
    AudioServicesPlaySystemSound(soundID)
}
