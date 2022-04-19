//
//  DataCalculatorViewCell.swift
//  Task1
//
//  Created by Nguyen Ty on 14/04/2022.
//

import UIKit

class DataCalculatorViewCell: UICollectionViewCell {
    @IBOutlet var viewData: UIView!
    @IBOutlet var lableData: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

     func updateCellLable(title: String, textColor: UIColor, fontSize: CGFloat, backgroundColor: UIColor) {
        lableData.text = title
        lableData.font = .systemFont(ofSize: fontSize, weight: .medium)
        lableData.textColor = textColor
        viewData.backgroundColor = backgroundColor
    }

}

extension UICollectionView {
    func register<T: UICollectionViewCell>(aClass: T.Type) {
        let className = String(describing: aClass)
        register(UINib(nibName: className, bundle: nil) , forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T: UICollectionViewCell>(aClass: T.Type, indexPath: IndexPath) -> T {
        let className = String(describing: aClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            assertionFailure("\(className) isn't exist")
            return T()
        }
        return cell
    }
    
    
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}
