//
//  RetroTableViewCell.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class RetroTableViewCell: UITableViewCell {
    
    static let identifier = "RetroTableViewCell"
    
    let fontSize: CGFloat = 15.0
    
    lazy var categoryLabel:  UILabel = {
        let label = UILabel()
        label.text = "Daily"
        label.font = .systemFont(ofSize: 17.0, weight: .medium)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var likedLabel: UILabel = {
        let label = UILabel()
        label.text = "Liked"
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
        return label
    }()
    
    lazy var likedContents: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize - 1.0)
        return label
    }()

    private lazy var learnedLabel: UILabel = {
        let label = UILabel()
        label.text = "Learned"
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
        return label
    }()
    
    lazy var learnedContents: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize - 1.0)
        return label
    }()
    
    private lazy var lackedLabel: UILabel = {
        let label = UILabel()
        label.text = "Lacked"
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
        return label
    }()
    
    lazy var lackedContents: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize - 1.0)
        return label
    }()
    
    private lazy var longedForLabel: UILabel = {
        let label = UILabel()
        label.text = "Longed For"
        label.font = .systemFont(ofSize: fontSize, weight: .medium)
        return label
    }()
    
    lazy var longedForContents: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize - 1.0)
        return label
    }()
    
    func setUp() {
        
        [categoryLabel, likedLabel, likedContents, learnedLabel, learnedContents, lackedLabel, lackedContents, longedForLabel, longedForContents].forEach { addSubview($0) }
        
        let inset: CGFloat = 15.0
            
        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8.0)
            $0.top.equalToSuperview().inset(8.0)
            $0.height.equalTo(30.0)
            $0.width.equalTo(100.0)
        }
        
        likedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10.0)
            $0.width.equalTo(120.0)
        }
        
        likedContents.snp.makeConstraints {
            $0.leading.equalTo(likedLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(likedLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        learnedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(likedLabel.snp.bottom).offset(5.0)
            $0.width.equalTo(120.0)
        }
        
        learnedContents.snp.makeConstraints {
            $0.leading.equalTo(learnedLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(learnedLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        lackedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(learnedLabel.snp.bottom).offset(5.0)
            $0.width.equalTo(120.0)
        }
        
        lackedContents.snp.makeConstraints {
            $0.leading.equalTo(lackedLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(lackedLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        longedForLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(lackedLabel.snp.bottom).offset(5.0)
            $0.width.equalTo(120.0)
            $0.bottom.equalToSuperview().inset(10.0)
        }
        
        longedForContents.snp.makeConstraints {
            $0.leading.equalTo(lackedLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(longedForLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(10.0)
        }
    
    }
    
}
