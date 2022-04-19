//
//  Data.swift
//  Task1
//
//  Created by Nguyen Ty on 17/04/2022.
//

import UIKit

enum Data: String, CaseIterable {
    case AC
    case swapNum = "+/-"
    case divisionPercent = "%"
    case multiplication = "÷"
    
    case numSeven = "7"
    case numEight = "8"
    case numNine = "9"
    case division = "×"
    case numFour = "4"
    case numFive = "5"
    case numSix = "6"
    case subtraction = "−"

    case numOne = "1"
    case numTwo = "2"
    case numThree = "3"
    case addition = "+"
    case numZero = "0"
    case dots = "."
    case equalMath = "="
    
    func textColor() -> UIColor {
        switch self {
        case .AC, .swapNum, .divisionPercent:
            return Color.titleAc
        default:
            return Color.title
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .AC, .swapNum, .divisionPercent:
            return Color.buttonColorAC
        case .division, .addition, .subtraction, .equalMath, .multiplication:
            return Color.buttonAnswer
        default:
            return Color.buttonColorNum
        }
    }
}
