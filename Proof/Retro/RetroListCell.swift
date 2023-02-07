//
//  RetroListCell.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/13.
//

import SnapKit
import UIKit

class RetroListCell: UITableViewCell {
    
    static let identifier = "RetroListCell"
    
    private lazy var categorylabel:  UILabel = {
        let label = UILabel()
        label.text = "Daily"
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
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
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var likedContents: UILabel = {
        let label = UILabel()
        label.text = "오늘 목표 달성"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    private lazy var learnedLabel: UILabel = {
        let label = UILabel()
        label.text = "Learned"
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var learnedContents: UILabel = {
        let label = UILabel()
        label.text = "캘린더 구현"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var lackedLabel: UILabel = {
        let label = UILabel()
        label.text = "Lacked"
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var lackedContents: UILabel = {
        let label = UILabel()
        label.text = "버튼스택뷰"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    
    private lazy var longedForLabel: UILabel = {
        let label = UILabel()
        label.text = "Longed For"
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var longedForContents: UILabel = {
        let label = UILabel()
        label.text = "내일 목표 달성"
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    
    func setUp() {
        
        [gradeImageView, categorylabel, likedLabel, likedContents, learnedLabel, learnedContents, lackedLabel, lackedContents, longedForLabel, longedForContents].forEach { addSubview($0) }
        
        let inset: CGFloat = 15.0
    
        gradeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalToSuperview().inset(inset)
            $0.width.equalTo(20.0)
            $0.height.equalTo(gradeImageView.snp.width)
        }
        
        categorylabel.snp.makeConstraints {
            $0.leading.equalTo(gradeImageView.snp.trailing).offset(8.0)
            $0.top.equalTo(gradeImageView.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        likedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalTo(gradeImageView.snp.bottom).offset(5.0)
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
        }
        
        longedForContents.snp.makeConstraints {
            $0.leading.equalTo(lackedLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(longedForLabel.snp.top)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        
    }
    
}
