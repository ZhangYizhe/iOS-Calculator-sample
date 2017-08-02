//
//  ViewController.swift
//  计算器
//
//  Created by 张艺哲 on 2017/8/1.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit


import AudioToolbox

class ViewController: UIViewController {
    
    
    var firstNum : Double = 0
    var resultNum :Double = 0
    
    
    
    @IBOutlet weak var numberout: UILabel!//数字输出
    @IBOutlet weak var numbererror: UILabel!//数字过大后
    @IBOutlet weak var ACBtn: UIButton!
    
    @IBAction func numberBtnTap(_ sender: UIButton) {
        
        
        Digitalcombination(flag: sender.tag)
        
        
        BtnSound()
        
        
    }
    
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var lessBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var exceptBtn: UIButton!
    
    
    
    var Operator = 0 //运算符
    
    @IBAction func operationBtnTap(_ sender: UIButton) {
        
        BtnSound()
        
        
        
        decimalpoint = false
        doubleflag = false
        
        plusBtn.boardwidth = 0.5
        lessBtn.boardwidth = 0.5
        multiplyBtn.boardwidth = 0.5
        exceptBtn.boardwidth = 0.5
        
        switch sender.tag {
        case 100://除
            sender.boardwidth = 2
            Operator = 100
            
            Operation_process()
            
            break
        case 101://乘
            sender.boardwidth = 2
            Operator = 101
            
            Operation_process()
            
            break
        case 102://减
            sender.boardwidth = 2
            Operator = 102
            
            Operation_process()
            
            
            break
        case 103://加
            sender.boardwidth = 2
            Operator = 103
            
            Operation_process()
            
            
            
            
            break
            
        case 104:
            
            Operation_process()
            
            Operator = 0
            break
            
        default:
            break
        }
        
        firstNum = 0
        
        
        
    }
    
    
    var decimalpoint = false
    var doubleflag = false
    
    @IBAction func decimalpointBtnTap(_ sender: UIButton) {//小数点
        
        BtnSound()
        
        
        
        if !decimalpoint{
            numberout.text = (numberout.text! + "." ).description
            doubleflag = true
            
        }
        
        
        decimalpoint = true
        
        
    }
    
    
    func Digitalcombination(flag:Int!) {//数字键
        
        ACBtn.setTitle("C", for: .normal)
        
        
        plusBtn.boardwidth = 0.5
        lessBtn.boardwidth = 0.5
        multiplyBtn.boardwidth = 0.5
        exceptBtn.boardwidth = 0.5
        
        
        
        
        
        let flag = Double(flag)
        
        
        if !decimalpoint{
            
            firstNum = flag + firstNum * 10
            
            
            
            
        }else{
            
            if doubleflag {
                
                firstNum = firstNum + flag/10
                
                doubleflag = false
            }else{
                
                let Number_of_bits =  String(firstNum).characters.count -  String(Int(firstNum)).characters.count
                
                firstNum = firstNum + flag/(power(flag: Number_of_bits))
                
            }
            

        }

        Printresults(flag:firstNum)
        
    }
    
    func power(flag:Int!) -> Double {//乘方运算
        
        var product:Double = 1
        
        
        for _ in 0...flag-1 {
            
            product = 10 * product
            
        }
        
        return product
        
        
    }
    
    
    ////////////////运算过程
    
    
    func Operation_process() {
        
        switch Operator {
        case 100:
            
            if resultNum == 0 {
                
                resultNum = firstNum
            } else if firstNum == 0{
                
                break
                
            } else {
                resultNum = resultNum / firstNum
            }
            
            
        case 101:
            
            if resultNum == 0 {
                
                resultNum = firstNum
                
            } else if firstNum == 0{
                
                break
                
            } else {
                
                resultNum = resultNum * firstNum
                
            }

        case 102:
            
            if resultNum == 0 {
                resultNum = firstNum
            }else{
                resultNum = resultNum - firstNum
            }

        case 103:
            
            resultNum = resultNum + firstNum

            
        default:
            break
        }
        
        
        Printresults(flag:resultNum)
        
    }
    
    /////////清零
    
    @IBAction func clearedBtn(_ sender: UIButton) {
        
        
        
        BtnSound()
        
        if(ACBtn.title(for: .normal)! == "C" && Operator != 0){
            
            firstNum = 0
            ACBtn.setTitle("AC", for: .normal)
            
            switch Operator {
            case 100:
                 exceptBtn.boardwidth = 2
                break
            case 101:
                multiplyBtn.boardwidth = 2
                break
            case 102:
                lessBtn.boardwidth = 2
                break
            case 103:
                plusBtn.boardwidth = 2
                break
            default:
            
                break
            }
            
        }else{
            
            ACBtn.setTitle("AC", for: .normal)
            
            firstNum = 0
            resultNum = 0
            
            Operator = 0 //运算符
            
            
            plusBtn.boardwidth = 0.5
            lessBtn.boardwidth = 0.5
            multiplyBtn.boardwidth = 0.5
            exceptBtn.boardwidth = 0.5
            
            
        }
        
        //小数点
        decimalpoint = false
        doubleflag = false
        
        Printresults(flag:firstNum)
        
        
        
        
    }
    
    //数字反转及百分数
    
    @IBAction func moreBtnTap(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            
            if firstNum != 0 {
                
                firstNum = -firstNum
                Printresults(flag:firstNum)
                
            }else{
                resultNum = -resultNum
                Printresults(flag:resultNum)
            }
            
            break
        case 2:
            
            if firstNum != 0 {
                
                firstNum = firstNum/100
                Printresults(flag:firstNum)
                
            }else{
                resultNum = resultNum/100
                Printresults(flag:resultNum)
            }
            
            break
        default:
            break
        }
        
        
        
    }
    
    
    
    
    //结果打印函数
    
    func Printresults(flag:Double) {
        
        
       let Number_of_bits =  String(flag).characters.count -  String(Int(flag)).characters.count
        

        
        
        if (String(format: "%.6f", flag).characters.count) < 21 {
            
            if flag - Double(Int(flag)) == 0{
                numberout.text = String(Int(flag))
                
            }else{
                
                if Number_of_bits <= 6 {
                   numberout.text = String(flag)
                }else{
                    numberout.text = String(format: "%.6f", flag)
                }
                

            }
            
            numbererror.text = ""
            
        }else{
            
            numbererror.text = "数字过大!"
            
        }

    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get {
            return .lightContent
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        numberout.adjustsFontSizeToFitWidth = true
        numbererror.adjustsFontSizeToFitWidth = true
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

