//
//  ViewController.swift
//  Task1
//
//  Created by Nguyen Ty on 14/04/2022.
//

import UIKit

class ViewController: UIViewController {
    var operatorCalulator: String = ""
    var numFirst: String = ""
    var numSecond: String = ""
    var resultCalulator: Double = 0
    var checkDot = false
    var checkSwapNum = false

    let resultTextView = UITextView()

    let dataCollectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let calculators = Data.allCases // Naming Convention

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.backgroundColor
        let heightContainer = view.safeAreaLayoutGuide.layoutFrame.height
        flowLayout.minimumInteritemSpacing = 8

        resultTextView.text = "0"
        addConstrainsTextView(height: heightContainer)

        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        dataCollectionView.setCollectionViewLayout(flowLayout, animated: true)

        view.addSubview(dataCollectionView)
        addConstrainsCollectionView(height: heightContainer)
    }

    func addConstrainsTextView(height: CGFloat) {
        let viewSafe = view.safeAreaLayoutGuide
        let heightContainerTextView = height / 5

        resultTextView.textColor = Color.buttonAnswer
        resultTextView.backgroundColor = Color.backgroundColor
        resultTextView.textColor = Color.title
        // Define (view.safeAreaLayoutGuide.layoutFrame.width - 25) / 4) to computed propery or lazy
        resultTextView.font = UIFont.systemFont(ofSize: (view.safeAreaLayoutGuide.layoutFrame.width - 25) / 4)
        resultTextView.isSelectable = false
        resultTextView.textAlignment = .right
        resultTextView.textContainer.maximumNumberOfLines = 1

        view.addSubview(resultTextView)
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        resultTextView.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor).isActive = true
        resultTextView.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor).isActive = true
        resultTextView.topAnchor.constraint(equalTo: viewSafe.topAnchor, constant: heightContainerTextView / 2).isActive = true
        resultTextView.heightAnchor.constraint(equalToConstant: heightContainerTextView).isActive = true
    }

    // MARK: - Private

    // Naming Convention
    private func addConstrainsCollectionView(height: CGFloat) {
        let viewSafe = view.safeAreaLayoutGuide

        dataCollectionView.backgroundColor = Color.backgroundColor
        dataCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dataCollectionView.topAnchor.constraint(equalTo: viewSafe.topAnchor, constant: viewSafe.layoutFrame.height / 4).isActive = true

        dataCollectionView.centerYAnchor.constraint(equalTo: viewSafe.centerYAnchor).isActive = true
        dataCollectionView.leadingAnchor.constraint(equalTo: viewSafe.leadingAnchor).isActive = true
        dataCollectionView.trailingAnchor.constraint(equalTo: viewSafe.trailingAnchor).isActive = true
        dataCollectionView.bottomAnchor.constraint(equalTo: viewSafe.bottomAnchor).isActive = true

        dataCollectionView.register(aClass: DataCalculatorViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculators.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(aClass: DataCalculatorViewCell.self,
                                              indexPath: indexPath)

        let heightCell = view.safeAreaLayoutGuide.layoutFrame.cellWidthRatio
        let button = calculators[indexPath.item]
        cell.updateCellLable(title: button.rawValue,
                             textColor: button.textColor(),
                             fontSize: heightCell / 2,
                             backgroundColor: button.backgroundColor())
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch calculators[indexPath.item] {
//        case .equalMath :
//            print("tinh toan")
//        case .AC:
//            print("xoa ")
//        case .divisionPercent:
//            print("tinh phan tram")
//        case .addition ,.division, .multiplication , .subtraction :
//            print(calculator[indexPath.item].rawValue)
//        case
        case .swapNum:
            if operatorCalulator.isEmpty {
                if !numFirst.isEmpty {
                    if checkSwapNum {
                        numFirst.removeFirst()
                    } else {
                        numFirst = "-" + numFirst
                    }
                    resultTextView.text = numFirst
                    checkSwapNum = !checkSwapNum
                }
            } else {
                if !numSecond.isEmpty {
                    if checkSwapNum {
                        numSecond.removeFirst()
                    } else {
                        numSecond = "-" + numSecond
                    }
                    resultTextView.text = numSecond
                    checkSwapNum = !checkSwapNum
                }
            }
        case .AC:
            operatorCalulator = ""
            numFirst = ""
            resultCalulator = 0
            numSecond = ""
            checkDot = false
            checkSwapNum = false
            resultTextView.text = "0"

        case .division, .addition, .subtraction, .multiplication:
            if !operatorCalulator.isEmpty {
                let first = Double(numFirst) ?? 0
                let second = Double(numSecond) ?? 0
                switch operatorCalulator {
                case "+":
                    if numFirst.isEmpty {
                        resultCalulator = (resultCalulator + first)
                    } else {
                        resultCalulator = (resultCalulator + second)
                    }

                case "−":
                    if numFirst.isEmpty {
                        resultCalulator = (resultCalulator - first)
                    } else {
                        resultCalulator = (resultCalulator - second)
                    }

                case "÷":

                    if numFirst.isEmpty {
                        resultTextView.text = "0"
                    } else if second == 0 && !numSecond.isEmpty {
                        resultTextView.text = "Lỗi"
                    } else if numSecond.isEmpty {
                        resultCalulator = (resultCalulator / first)
                    } else {
                        resultCalulator = (resultCalulator / second)
                    }

                case "×":
                    if !numSecond.isEmpty {
                        resultCalulator = resultCalulator * second
                        numSecond = ""
                    } else {
                        resultCalulator = resultCalulator * first // commit x
                        numFirst = ""
                    }

                default:
                    resultTextView.text = "Lỗi"
                }

                if resultTextView.text != "Lỗi" && !numFirst.isEmpty {
                    let stringResult = String(format: "%g", resultCalulator)
//                    numFirst = stringResult
                    resultTextView.text = stringResult
                } else if numFirst.isEmpty {
                    numFirst = String(resultCalulator)
                }
            }
            operatorCalulator = calculators[indexPath.item].rawValue
            checkDot = false
            checkSwapNum = false
            numSecond = ""

        case .equalMath:

            let first = Double(numFirst) ?? 0
            let second = Double(numSecond) ?? 0
            print("second : ", numSecond)
            // var result: Double = 0
            if !operatorCalulator.isEmpty {
                print("equal in strOperator : ", numFirst)
                print("equal in strOperator: ", numSecond)
                print("equal in strOperator : ", operatorCalulator)
                switch operatorCalulator {
                case "+":
                    if numSecond.isEmpty {
                        resultCalulator = resultCalulator + first
                    } else {
                        resultCalulator = resultCalulator + second
                    }

                case "−":
                    if numSecond.isEmpty {
                        resultCalulator = resultCalulator - first
                        numFirst = String(resultCalulator)
                        print("check :", first)
                    } else {
                        resultCalulator = resultCalulator - second
                    }

                case "÷":
                    print("second : ", numSecond)
                    if numFirst.isEmpty {
                        resultTextView.text = "0"
                    } else if second == 0 && !numSecond.isEmpty {
                        resultTextView.text = "Lỗi"
                    } else if numSecond.isEmpty {
                        resultCalulator = (resultCalulator / first)
                    } else {
                        resultCalulator = (resultCalulator / second)
                    }

                case "×":
                    if numSecond.isEmpty {
                        resultCalulator = (resultCalulator * first)

                    } else if numFirst.isEmpty {
                        resultCalulator = (resultCalulator * second)
                    } else {
                        resultCalulator = first * second
                    }

                default:
                    print("1 :", numFirst)
                    print("2 :", numSecond)
                    if !numFirst.isEmpty {
                        resultTextView.text = numFirst
                    } else {
                        resultTextView.text = "0"
                    }
                }
            }

            if resultCalulator == 0 && numSecond.isEmpty {
                resultTextView.text = "0"
            } else if resultTextView.text != "Lỗi" && !numFirst.isEmpty {
                let stringResult = String(format: "%g", resultCalulator)
//                numFirst = stringResult
                resultTextView.text = stringResult
            } else if numFirst.isEmpty {
                resultTextView.text = "0"
            }
            print(numFirst)
            checkDot = false
            checkSwapNum = false
//            numFirst = numSecond
            numSecond = ""

        case .divisionPercent:
            checkDot = true
            let data = numFirst
            let value = (Double(data) ?? 0) / 100
            print("value : ", value)
            numFirst = String(value)
            resultTextView.text = numFirst

        default:
            if operatorCalulator.isEmpty {
                if calculators[indexPath.item] == .numZero && numFirst.isEmpty {
                    resultTextView.text = "0"
                } else if calculators[indexPath.item] == .dots && numFirst.isEmpty {
                    numFirst += "0."
                    resultTextView.text = numFirst
                    checkDot = true
                } else {
                    if checkDot {
                        if calculators[indexPath.item] != .dots {
                            numFirst += calculators[indexPath.item].rawValue
                            resultTextView.text = numFirst
                        }
                    } else {
                        if calculators[indexPath.item] == .dots {
                            checkDot = true
                            numFirst += calculators[indexPath.item].rawValue
                        } else {
                            numFirst += calculators[indexPath.item].rawValue
                        }

                        resultTextView.text = numFirst
                    }
                    resultCalulator = Double(numFirst) ?? 0
                }
            } else {
                if calculators[indexPath.item] == .numZero && numSecond.isEmpty {
                    resultTextView.text = "0"
                } else if calculators[indexPath.item] == .dots && numSecond.isEmpty {
                    numSecond += "0."
                    resultTextView.text = numSecond
                    checkDot = true
                } else {
                    if checkDot {
                        if calculators[indexPath.item] != .dots {
                            numSecond += calculators[indexPath.item].rawValue
                            resultTextView.text = numSecond
                        }
                    } else {
                        if calculators[indexPath.item] == .dots {
                            checkDot = true
                            numSecond += calculators[indexPath.item].rawValue
                        } else {
                            numSecond += calculators[indexPath.item].rawValue
                        }

                        resultTextView.text = numSecond
                    }
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightCell = view.safeAreaLayoutGuide.layoutFrame.cellWidthRatio
        if indexPath.item == 16 {
            return CGSize(width: heightCell * 2 + 8, height: heightCell)
        }
        return CGSize(width: heightCell, height: heightCell)
    }
}

private extension CGRect {
    var cellWidthRatio: CGFloat {
        return ( width - 25 )/4
    }
}
