//
//  CSEditListHeader.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/12.
//

import UIKit
import SnapKit
import RxSwift

final class CSEditListHeader: UICollectionReusableView {
    
    var disposeBag = DisposeBag()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "술 / 10000 원"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
}



