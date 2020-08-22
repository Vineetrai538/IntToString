//
//  Extension.swift
//  IntToString
//
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
public extension Int {

    var digitCount: Int {
    get {
        return numberOfDigits(in: self)
    }
}
    var usefulDigitCount: Int {
    get {
        var count = 0
        for digitOrder in 0..<self.digitCount {
            let digit = self % (Int(truncating: pow(10, digitOrder + 1) as NSDecimalNumber))
                / Int(truncating: pow(10, digitOrder) as NSDecimalNumber)
            if isUseful(digit) { count += 1 }
        }
        return count
    }
}
private func numberOfDigits(in number: Int) -> Int {
    if number < 10 && number >= 0 || number > -10 && number < 0 {
        return 1
    } else {
        return 1 + numberOfDigits(in: number/10)
    }
}
private func isUseful(_ digit: Int) -> Bool {
    return (digit != 0) && (self % digit == 0)
}
}
extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}

extension Int {
    func plainEnglish (negativeSign: String = "negative") -> String {
        func singleNumberName (number: Int) -> String {
            switch (number) {
            case 1: return "One"
            case 2: return "Two"
            case 3: return "Three"
            case 4: return "Four"
            case 5: return "Five"
            case 6: return "Six"
            case 7: return "Seven"
            case 8: return "Eight"
            case 9: return "Nine"
            default:return ""
            }
        }

        func tensNumberName (number: Int) -> String {
            switch (number) {
            case 2: return "Twenty"
            case 3: return "Thirty"
            case 4: return "Fourty"
            case 5: return "Fifty"
            case 6: return "Sixty"
            case 7: return "Seventy"
            case 8: return "Eighty"
            case 9: return "Ninety"
            default:return ""
            }
        }

        func teensNumberName (number: Int) -> String {
            switch (number) {
            case 0: return "Ten"
            case 1: return "Eleven"
            case 2: return "Twelve"
            case 3: return "Thirteen"
            case 5: return "Fifteen"
            default:return singleNumberName(number: number) + "teen"
            }
        }

        var number = self
        var digits: [Int] = []

        while number != 0 {
            digits.append(abs(number%10))
            number /= 10
        }

        var plainEnglish: [String] = []

        var isTeen = false
        let totalPlaces = digits.count
        var currentPlace = 0
        let ab = digits.reversed()
        for (index, digit) in ab.enumerated() {
            currentPlace = totalPlaces - index
            if currentPlace % 3 == 0 && digit > 0 {
                plainEnglish.append(singleNumberName(number: digit) + " hundred")
            } else if (currentPlace + 1) % 3 == 0 {
                if digit == 1 {
                    isTeen = true
                    continue;
                } else {
                    isTeen = false
                    plainEnglish.append(tensNumberName(number: digit))
                }
            } else {
                if isTeen {
                    plainEnglish.append(teensNumberName(number: digit))
                } else {
                    plainEnglish.append(singleNumberName(number: digit))
                }
            }

            if currentPlace == 4 {
                plainEnglish.append("thousand")
            } else if currentPlace == 7 {
                plainEnglish.append("million")
            } else if currentPlace == 10 {
                plainEnglish.append("billion")
            }
        }

        let initial = (self < 0) ? negativeSign : ""

        func combine (first: String, second: String) -> String {
            return first + " " + second
        }

        let finalString = plainEnglish.reduce(initial, combine)
        return finalString.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension ViewController {
    func names(valueIs : Int) -> String{
          var convert = String()
          
          switch valueIs {
          case 1:
               convert = "Thousand"
          case 2:
              convert = "Lakh"
          case 3:
              convert = "Crore"
          default:
              convert = ""
          }
          return convert
      }
}
