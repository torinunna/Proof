//
//  CalendarTableViewCell.swift
//  Proof
//
//  Created by YUJIN KWON on 2023/03/03.
//

import SnapKit
import UIKit

class CalendarTableViewCell: UITableViewCell {
 
    static let identifier = "CalendarTableViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondaryLabel
        return image
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "daily"
        return label
    }()
    
    func setUp() {
        [image, categoryLabel].forEach { addSubview($0) }
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(13.0)
            $0.top.bottom.equalToSuperview().inset(13.0)
            $0.width.equalTo(8.0)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(15.0)
            $0.top.bottom.equalToSuperview().inset(13.0)
        }
    }
    
}

