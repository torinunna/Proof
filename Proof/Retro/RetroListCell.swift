//
//  RetroListCell.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class RetroListCell: UITableViewCell {
    
    private lazy var categorylabel:  UILabel = {
        let label = UILabel()
        label.text = "Daily"
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private lazy var gradeImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .tertiaryLabel
        return image
    }()
    
    private lazy var likedLabel: UILabel = {
        let label = UILabel()
        label.text = "Liked"
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    private lazy var likedContents: UILabel = {
        let label = UILabel()
        label.text = "오늘 목표 달성"
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    private lazy var longedForLabel: UILabel = {
        let label = UILabel()
        label.text = "Longed For"
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    private lazy var longedForContents: UILabel = {
        let label = UILabel()
        label.text = "내일 목표 달성"
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    func setUp() {
        [categorylabel, gradeImageView, likedLabel, likedContents, longedForLabel, longedForContents].forEach { addSubview($0) }
        
        let inset: CGFloat = 15.0
        
        categorylabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        let width: CGFloat = 100.0
        
        gradeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(categorylabel.snp.bottom).offset(inset)
            $0.width.equalTo(width)
            $0.height.equalTo(width)
        }
        
        likedLabel.snp.makeConstraints {
            $0.leading.equalTo(gradeImageView.snp.trailing).offset(inset)
            $0.top.equalTo(gradeImageView.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        likedContents.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(likedLabel.snp.bottom).offset(5.0)
            $0.trailing.equalTo(likedLabel.snp.trailing)
        }
        
        longedForLabel.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(likedContents.snp.bottom).offset(7.0)
            $0.trailing.equalTo(likedLabel.snp.trailing)
        }
        
        longedForContents.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.leading)
            $0.top.equalTo(longedForLabel.snp.bottom).offset(5.0)
            $0.trailing.equalTo(likedLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        
    }
    
}
