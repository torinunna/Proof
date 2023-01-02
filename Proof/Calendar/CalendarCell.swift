//
//  CalendarCell.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/16.
//

import SnapKit
import UIKit

class CalendarCell: UICollectionViewCell {
    
    static let identifier = "CalendarCell"
    
    var dayOfMonth: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    func setUp() {
        addSubview(dayOfMonth)
        dayOfMonth.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}


