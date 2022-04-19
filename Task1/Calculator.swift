import Foundation

struct Calculator {
    var str: String = ""
    var result: String = ""
    var arrstr: [String] = []

    init(str: String, result: String) {
        self.str = str
        self.result = result
    }

    func truythamso(a: String) -> [String] {
        var number: String! = ""
        var arrayham = [String]()
        for tmp in a {
            let tm1: String = String(tmp)

            if Int(tm1) ?? -1 >= 0 && Int(tm1) ?? -1 <= 9 || tm1 == "." {
                number += tm1
            } else {
                if number != "" {
                    arrayham.append(number)
                    number = ""
                }

                arrayham.append(tm1)
            }
        }
        if number != "" {
            arrayham.append(number)
        }

        return arrayham
    }

    func compactData(a: [String]) -> [String] {
        var tezt: String = ""
        var arrcompact = [String]()
        for i in a {
            if Double(i) ?? -1 >= 0 {
                if tezt != "" {
                    arrcompact.append(tezt)
                    tezt = ""
                }
                arrcompact.append(i)
            } else {
                if tezt == "" {
                    tezt = i
                } else {
                    if tezt == "−" {
                        if i == "−" {
                            tezt = "+"
                        }
                    } else if tezt == "+" {
                        if i == "−" {
                            tezt = "−"
                        }
                    } else {
                        arrcompact.append(tezt)
                        arrcompact.append(i)
                        tezt = ""
                    }
                }
            }
        }
        return arrcompact
    }

    func customData(a: [String]) -> [String] {
        var arrcustom = [String]()
        var checknum: Int = -1
        var _: Bool = false
        for i in a.indices {
            if checknum == i {
                arrcustom.append(")")
                checknum = -1
            }

            if i == 0 && a[i] == "−" {
                arrcustom.append("(")
                arrcustom.append("0")
                arrcustom.append(a[i])
                checknum = i + 2
            } else if i == 0 && a[i] == "+" {
                continue
            } else if (a[i] == "÷" || a[i] == "%" || a[i] == "×") && (a[i + 1] == "−") {
                arrcustom.append(a[i])
                arrcustom.append("(")
                arrcustom.append("0")
                checknum = i + 3
            } else if (a[i] == "÷" || a[i] == "%" || a[i] == "×") && (a[i + 1] == "+") {
            } else {
                arrcustom.append(a[i])
            }
        }

        return arrcustom
    }

    func quedata(a: [String]) -> Queue<Any> {
        var _: Bool = false
        var stack = Stack<Any>()
        var queue = Queue<Any>()
        for i in a.indices {
            if Double(a[i]) ?? -1 >= 0 {
                queue.enqueue(a[i])
            } else {
                if stack.isEmpty {
                    stack.push(a[i])
                } else {
                    if a[i] == ")" {
                        while !stack.isEmpty {
                            let tmpstack: String = stack.pop() as! String
                            print(stack)
                            print(queue)
                            if tmpstack == "(" {
                                break
                            }

                            queue.enqueue(tmpstack)
                        }
                    } else {
                        let first1: String = stack.pop() as! String
                        let last: String = a[i]
                        if first1 == "(" || a[i] == "(" {
                            stack.push(first1)
                            stack.push(a[i])
                            //                        print("last : " + last);
                            //                        print(stack);
                        } else {
                            if checkdouutien(first: first1, second: last) == false {
                                queue.enqueue(first1)
                                stack.push(last)
                            } else {
                                stack.push(first1)
                                stack.push(last)
                            }
                        }
                    }
                }
            }
        }
        while !stack.isEmpty {
            let tmpstack: String = stack.pop() as! String
            if tmpstack == "(" {
                continue
            }
            queue.enqueue(tmpstack)
        }
        return queue
    }

    func checkdouutien(first: String, second: String) -> Bool {
        if Douutien(a: second) > Douutien(a: first) {
            return true
        }
        return false
    }

    func Douutien(a: String) -> Int {
        if a == "(" || a == ")" {
            return 1
        } else if a == "×" || a == "÷" || a == "%" {
            return 3
        }
        return 2
    }

    func resultcalculator(queue: Queue<Any>) -> String {
        var stackkq = Stack<Any>()
        var first: Double = 0
        var second: Double = 0
        var queuetmp = queue
        while !queuetmp.isEmpty {
            let tmp = queuetmp.dequeue() as! String
            if tmp == "−" {
                second = Double(stackkq.pop() as! String) ?? 0
                first = Double(stackkq.pop() as! String) ?? 0

                let kq = first - second
                stackkq.push(String(kq))
            } else if tmp == "+" {
                second = Double(stackkq.pop() as! String) ?? 0
                first = Double(stackkq.pop() as! String) ?? 0
                let kq = first + second
                stackkq.push(String(kq))
            } else if tmp == "×" {
                second = Double(stackkq.pop() as! String) ?? 0
                first = Double(stackkq.pop() as! String) ?? 0
                let kq = first * second

                stackkq.push(String(kq))
            } else if tmp == "÷" {
                second = Double(stackkq.pop() as! String) ?? 0
                first = Double(stackkq.pop() as! String) ?? 0
                if second == 0 {
                    return "ERROR"
                }
                let kq = first / second
                stackkq.push(String(kq))
            } else if tmp == "%" {
                second = Double(stackkq.pop() as! String) ?? 0
                first = Double(stackkq.pop() as! String) ?? 0
                let kq = Int(first) % Int(second)
                stackkq.push(String(kq))
            } else {
                stackkq.push(tmp)
            }
        }

        if let string = stackkq.pop() as? String {
            let kq1 = Double(string) ?? 0
            return String(kq1)
        } else {
            return ""
        }
    }

    mutating func createarr() {
        var arrstr1 = truythamso(a: str)
        print(arrstr1)
        arrstr1 = compactData(a: arrstr1)
        print(arrstr1)
        arrstr1 = customData(a: arrstr1)
        print(arrstr1)
        var queue1 = Queue<Any>()
        queue1 = quedata(a: arrstr1)
        print(queue1)
        let kq = resultcalculator(queue: queue1)
        print(kq)
        result = kq
    }
}
