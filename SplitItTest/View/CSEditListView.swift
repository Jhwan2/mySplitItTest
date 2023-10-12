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
    
    let collectionViewHeaderString = UICollectionView.elementKindSectionHeader
    
    let csHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "각 항목을 탭하여 수정하세요."
        return label
    }()
    
    let csTitleLabel: UIButton = {
        let label = UIButton(type: .system)
        return label
    }()
    
    let csTotalLabel: UIButton = {
        let label = UIButton(type: .system)
        return label
    }()
    
    let csMemberLabel: UIButton = {
        let label = UIButton(type: .system)
        return label
    }()
    
    let itemHeaderLabel: UILabel = {
       let label = UILabel()
        label.text = "빼줄 상품"
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("차수 수정 완료", for: .normal)
        return button
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        viewBinding()
        configureUI()
    }
    
    func setCollectionView() {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        view.addSubview(collectionView)
        collectionView.register(CSEditListCell.self, forCellWithReuseIdentifier: viewModel.csCellIdentifier)
        collectionView.register(CSEditListHeader.self, forSupplementaryViewOfKind: collectionViewHeaderString, withReuseIdentifier: viewModel.csHeaderIdentifier)
//        let layout = UICollectionViewFlowLayout()
//        collectionView.collectionViewLayout = layout
    }
    
    func configureUI() {
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
        
        let diview = UIView()
        diview.backgroundColor = .lightGray
        view.addSubview(diview)
        diview.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.height.equalTo(1)
        }
    
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(diview.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-35)
            make.centerX.equalToSuperview()
        }
    }
    
    func viewBinding() {
        viewModel.itemsObservable
            .map { items in
                // 각 섹션에 해당하는 아이템 배열을 생성
                var sections: [CSEditListSectionModel] = []
                for item in items {
                    sections.append(CSEditListSectionModel(header: item.itemName, items: item.exclMember))
                }
                return sections
            }
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        viewModel.titleObservable
            .bind(to: csTitleLabel.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.totalObservable
            .bind(to: csTotalLabel.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.membersObservable
            .bind(to: csMemberLabel.rx.title())
            .disposed(by: disposeBag)
        
        let input = CSEditListViewModel.Input(titleBtnTap: csTitleLabel.rx.tap,
                                              totalPriceTap: csTotalLabel.rx.tap,
                                              memberTap: csMemberLabel.rx.tap,
                                              exclItemTap: collectionView.rx.itemSelected)
        
        let output = viewModel.transform(input: input)
        output.pushTitleEditVC
            .subscribe(onNext: { self.pushTitleEditViewController()})
            .disposed(by: disposeBag)
        output.pushPriceEditVC
            .subscribe(onNext: { self.pushTotalPriceEditViewController()})
            .disposed(by: disposeBag)
        output.pushMemberEditVC
            .subscribe(onNext: { self.pushMemberEditViewController()})
            .disposed(by: disposeBag)
        output.pushExclItemEditVC
            .subscribe(onNext: {
                self.pushExclItemEditViewController(index: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func pushTitleEditViewController() {
        let vc = CSTitleEditView()
        vc.view.backgroundColor = .white
        viewModel.titleObservable
            .bind(to: vc.textField.rx.text)
            .disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushTotalPriceEditViewController() {
        let vc = CSTotalPriceEditView()
        vc.view.backgroundColor = .white
        viewModel.totalObservable
            .bind(to: vc.textField.rx.text)
            .disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushMemberEditViewController() {
        let vc = CSMemberEditView()
        vc.view.backgroundColor = .white
        viewModel.membersObservable
            .bind(to: vc.label.rx.text)
            .disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushExclItemEditViewController(index: IndexPath) {
        let vc = CSExclItemEditView()
        vc.view.backgroundColor = .white
        viewModel.itemsObservable
            .map { $0[index.section].itemName }
            .bind(to: vc.label.rx.text)
            .disposed(by: disposeBag)
        navigationController?.pushViewController(vc, animated: true)
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

