//
//  CSEditListCell.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import UIKit
import SnapKit

class CSEditListCell: UICollectionViewCell {
    
    var name: String = "제롬"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 5
        label.text = name
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
