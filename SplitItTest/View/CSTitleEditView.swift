//
//  CSTitleEditView.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/12.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CSTitleEditView: UIViewController {
    var disposeBag = DisposeBag()
    
    let viewModel = CSTitleEditViewModel()
    
    let textField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정하기", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setBinding()
    }
    
    func setUI() {
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
    }
    
    func setBinding() {
        let input = CSTitleEditViewModel.Input.init(saveBtnTap: saveButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.titleSubject)
            .disposed(by: disposeBag)
        
        output.popNavigator
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }

}
