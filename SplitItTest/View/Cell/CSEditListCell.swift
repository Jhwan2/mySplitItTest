//
//  CSEditListCell.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import UIKit
import SnapKit
import RxSwift

class CSEditListCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    lazy var memberLabel: UILabel = {
        let button = UILabel()
        button.textAlignment = .center
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = .lightGray
        contentView.addSubview(memberLabel)
        memberLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
