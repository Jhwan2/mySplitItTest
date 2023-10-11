//
//  ViewController.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa
import RxDataSources

final class CSEditListView: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private let viewModel = CSEditListViewModel()
    
    let csHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "각 항목을 탭하여 수정하세요."
        return label
    }()
    
    let csTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "양꼬치집"
        return label
    }()
    
    let csTotalLabel: UILabel = {
       let label = UILabel()
        label.text = "가격"
        return label
    }()
    
    let csMemberLabel: UILabel = {
       let label = UILabel()
        label.text = "각 멤버"
        return label
    }()
    
    let itemHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "빼줄 상품"
        return label
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        viewBinding()
        configureUI()
    }
    
    func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CSEditListCell.self, forCellWithReuseIdentifier: viewModel.csCellIdentifier)
        collectionView.rx.setDelegate(self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
    }
    
    func configureUI() {
        collectionView.backgroundColor = .blue
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [csHeaderLabel, csTitleLabel,
                                                       csTotalLabel, csMemberLabel,
                                                       itemHeaderLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view).offset(100)
            make.height.equalTo(150)
        }
    
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func viewBinding() {
        viewModel.initialDataOb
            .map { [CSEditListSectionModel(header: "", items: [$0])]}
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource!))
            .disposed(by: disposeBag)
        
        viewModel.titleObservable
            .bind(to: csTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalObservable
            .bind(to: csTotalLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.membersObservable
            .bind(to: csMemberLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

extension CSEditListView: UICollectionViewDelegateFlowLayout {
    // 섹션 헤더의 크기를 설정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    // 셀과 헤더 사이의 간격을 조절하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

