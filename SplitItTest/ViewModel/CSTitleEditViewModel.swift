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
    
    func transform(input: Input) -> Output {
        input.titleChange
            .subscribe { st in
                self.data.titleEdit(title: st)
            }
            .disposed(by: disposeBag)
        
        return Output(popNavigator: input.saveBtnTap.asObservable())
    }
    
    struct Input {
        let saveBtnTap: ControlEvent<Void>
        let titleChange: Observable<String>
    }
    
    struct Output {
        let popNavigator: Observable<Void>
    }
    
}
