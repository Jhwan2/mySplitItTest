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
    
    var viewModel = CSEditListViewModel()
    
//    let tableViewHeaderString = UITableView.
    let csHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "각 항목을 탭하여 수정하세요."
        return label
    }()
    
    let csTitleLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let csTotalPriceLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("차수 수정 완료", for: .normal)
        return button
    }()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
//        viewBinding()
        configureUI()
    }
    
    func setTableView() {
        tableView.register(CSEditListCell.self, forCellReuseIdentifier: viewModel.csCellIdentifier)
//        collectionView.register(CSEditListHeader.self, forSupplementaryViewOfKind: collectionViewHeaderString, withReuseIdentifier: viewModel.csHeaderIdentifier)contentView.addSubview(memberLabel)

    }
    
    func configureUI() {
        view.backgroundColor = UIColor(red: 0.973, green: 0.969, blue: 0.957, alpha: 1)
        view.addSubview(csHeaderLabel)
        csHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        tableView.backgroundColor = .blue
        
        let titleLB = UILabel()
        titleLB.text = "이름"
        titleLB.font = .systemFont(ofSize: 12)
        let titleBtn = UIButton(type: .system)
        titleBtn.setTitle("수정하기", for: .normal)
        titleBtn.tintColor = .lightGray
        titleBtn.titleLabel?.font = .systemFont(ofSize: 12)
        
        let roundTitleStack = UIStackView(arrangedSubviews: [csTitleLabel, titleBtn])
        roundTitleStack.axis = .horizontal
        roundTitleStack.layer.cornerRadius = 8
        roundTitleStack.layer.borderWidth = 1
        roundTitleStack.distribution = .equalSpacing
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLB,roundTitleStack])
        titleStackView.axis = .vertical
        titleStackView.spacing = 4
        roundTitleStack.snp.makeConstraints { make in
            make.height.equalTo(43)
        }
        
    }
    
//    func viewBinding() {
//        viewModel.itemsObservable
//            .map { items in
////                // 각 섹션에 해당하는 아이템 배열을 생성
////                var sections: [CSEditListCustomSectionModel] = []
////                for item in items {
////                    sections.append(CSEditListSectionModel(header: item.itemName, items: item.exclMember))
////                }
////                return sections
//                [CSEditListSectionModel(header: "", items: [])]
//            }
//            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
//            .disposed(by: disposeBag)
//
//        viewModel.titleObservable
//            .bind(to: csTitleLabel.rx.title())
//            .disposed(by: disposeBag)
//
//        viewModel.totalObservable
//            .bind(to: csTotalLabel.rx.title())
//            .disposed(by: disposeBag)
//
//        viewModel.membersObservable
//            .bind(to: csMemberLabel.rx.title())
//            .disposed(by: disposeBag)
//
//        let input = CSEditListViewModel.Input(titleBtnTap: csTitleLabel.rx.tap,
//                                              totalPriceTap: csTotalLabel.rx.tap,
//                                              memberTap: csMemberLabel.rx.tap,
//                                              exclItemTap: tableView.rx.itemSelected)
//
//        let output = viewModel.transform(input: input)
//        output.pushTitleEditVC
//            .subscribe(onNext: { self.pushTitleEditViewController()})
//            .disposed(by: disposeBag)
//        output.pushPriceEditVC
//            .subscribe(onNext: { self.pushTotalPriceEditViewController()})
//            .disposed(by: disposeBag)
//        output.pushMemberEditVC
//            .subscribe(onNext: { self.pushMemberEditViewController()})
//            .disposed(by: disposeBag)
//        output.pushExclItemEditVC
//            .subscribe(onNext: {
//                self.pushExclItemEditViewController(index: $0)
//            })
//            .disposed(by: disposeBag)
//    }

}

// MARK: CSEditListView/Navigation-PUSH
extension CSEditListView {
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

