//
//  ViewModelType.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
