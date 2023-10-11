//
//  CSEditListViewModel.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import UIKit


final class CSEditListViewModel: ViewModelType {
    let csCellIdentifier = "CSCell"
    
    var disposeBag = DisposeBag()
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<CSEditListSectionModel>?
    private var dummyData = BehaviorSubject<CSModel>(value: CSModel(title: "양꼬치집", totalPrice: 128000, member: ["제리", "모아나", "코리", "완", "제롬", "토마토"], item: [ExclItem(itemName: "술값", exclMember: [false, true, false, false, true, false])]))
    var initialDataOb: Observable<CSModel> {
        return dummyData.asObservable()
    }
    
    var titleObservable: Observable<String> {
        return dummyData.map { $0.title }
    }
    
    var totalObservable: Observable<String> {
        return dummyData.map { "\($0.totalPrice)" }
    }

    var membersObservable: Observable<String> {
        return dummyData.map { $0.member.joined(separator: ", ") }
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    
    init() {
        dataSource = RxCollectionViewSectionedReloadDataSource<CSEditListSectionModel> {
            [weak self] (dataSource, collectionView, indexPath, item) in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.csCellIdentifier, for: indexPath) as! CSEditListCell
            if let name = item.item.first?.itemName {
                cell.name = name
                return cell
            } else {
                return cell
            }
        }
        
    }
    
}
