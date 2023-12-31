//
//  CSTitleEditViewModel.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/12.
//

import Foundation
import RxSwift
import RxCocoa

final class CSTitleEditViewModel: ViewModelType {
    var data = DataManager.shared
    var disposeBag = DisposeBag()
    
    let titleSubject = BehaviorSubject<String>(value: "")
    
    func transform(input: Input) -> Output {
        input.saveBtnTap
            .subscribe(onNext: { self.saveData() })
            .disposed(by: disposeBag)
        return Output(popNavigator: input.saveBtnTap.asObservable())
    }
    
    func saveData() {
        if let updatedTitle = try? titleSubject.value() {
            data.titleEdit(title: updatedTitle)
        }
    }
    
    struct Input {
        let saveBtnTap: ControlEvent<Void>
    }
    
    struct Output {
        let popNavigator: Observable<Void>
    }
    
}


