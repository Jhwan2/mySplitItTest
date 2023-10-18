//
//  CSPriceEditViewModel.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/14.
//

import Foundation
import RxSwift
import RxCocoa

final class CSPriceEditViewModel: ViewModelType {
    var data = DataManager.shared
    var disposeBag = DisposeBag()
    
    let priceSubject = BehaviorSubject<String>(value: "")
    
    func transform(input: Input) -> Output {
        input.saveBtnTap
            .subscribe(onNext: { self.saveData() })
            .disposed(by: disposeBag)
        return Output(popNavigator: input.saveBtnTap.asObservable())
    }
    
    func saveData() {
        if let updatedPrice = try? priceSubject.value() {
            data.totalPriceEdit(price: updatedPrice)
        }
    }
    
    struct Input {
        let saveBtnTap: ControlEvent<Void>
    }
    
    struct Output {
        let popNavigator: Observable<Void>
    }
    
}


