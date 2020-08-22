//
//  ViewController.swift
//  IntToString
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var translatebtn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        translatebtn.layer.borderColor = UIColor.black.cgColor
        translatebtn.layer.borderWidth = 1
        translatebtn.layer.cornerRadius = translatebtn.bounds.height / 2
    }
  
    @IBAction func translatebtnAction(_ sender: Any) {
        newFunction(valueIs: Int(txtField?.text ?? "") ?? 0)
    }
    
    
    
    func newFunction(valueIs : Int) {
        let value = valueIs
        var convertedString = String()
        let totalCount = "\(value)".count
        if totalCount <= 9 {
            convertedString =  calculate(value: value, a: false)
        } else {
            let firstString = String("\(value)".suffix(7))
            let SecondString = String("\(value)".dropLast(7))
            convertedString = "\(calculate(value: Int(SecondString) ?? 0, a: false))" + "Crore" + " \(calculate(value: Int(firstString) ?? 0, a: true))"
        }
        lbl.text = convertedString
    }
    
    func calculate(value : Int , a : Bool) -> String{
        var convertedString = String()
        var arr = [String]()
        let halfCount = Int("\(value)".dropLast(3).count)
        let numberLeft = String("\(value)".dropLast(3))
        let firstNumber = String("\(value)".suffix(3))
        arr.append(firstNumber)
        var leftCount = numberLeft
        if leftCount.count == 1 {
            arr.append(leftCount)
            leftCount = String("\(leftCount)".dropLast(1))
        } else if leftCount != "" {
        for i in 0...halfCount/2 - 1{
            print("\(i)")
            if leftCount.count >= 2{
                let sb = "\(leftCount)".suffix(2)
                leftCount = String("\(leftCount)".dropLast(2))
                arr.append(String(sb))
            }else {
                let sb = "\(leftCount)".suffix(1)
                leftCount = String("\(leftCount)".dropLast(1))
                arr.append(String(sb))
            }
           
            }
        }
        if leftCount.count != 0 {
            arr.append(leftCount)
            leftCount = String("\(leftCount)".dropLast(1))
        }

        var reversedNames = [String]()

        for name in arr {
            reversedNames.insert(name, at: 0)
        }
        for i in 0...reversedNames.count - 1  {
            let converted = Int(reversedNames[i])?.plainEnglish() ?? ""
            if reversedNames[i] != "00" ||  reversedNames[i] == "0"{
                convertedString = "\(convertedString)" + " \(converted)" + " \(names(valueIs: reversedNames.count - (i+1)))"
            }
        }
        return convertedString
    }
}


