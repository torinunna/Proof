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
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()
    
    func weeklySetUp() {
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func monthlySetUp() {
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}


