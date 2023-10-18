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
    var disposeBag = DisposeBag()
    let csCellIdentifier = "CSCell"
    let csHeaderIdentifier = "CSHeader"
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<CSEditListSectionModel> = {
       let dataSource = RxTableViewSectionedReloadDataSource<CSEditListSectionModel> {
           (dataSource, collectionView, indexPath, item) in
//           guard let self = self else { return UICollectionViewCell() }
           let cell = collectionView.dequeueReusableCell(withIdentifier: self.csCellIdentifier, for: indexPath) as! CSEditListCell
           
           // itemsObservable을 활용하여 셀의 내용 업데이트
           self.itemsObservable
               .map { $0[indexPath.section] }
               .map { $0.exclMember[indexPath.item] }
               .subscribe(onNext: { st in
//                   cell.memberLabel.text = st
               })
               .disposed(by: cell.disposeBag) // 셀 내부의 disposeBag 사용
           
           return cell
       } 
        return dataSource
    }()
    
    private var data: Observable<CSModel> {
        return DataManager.shared.data.asObservable()
    }
    
    var itemsObservable: Observable<[ExclItem]> {
        return data.map { $0.items }
    }
    
    var titleObservable: Observable<String> {
        return data.map { $0.title }
    }
    
    var totalObservable: Observable<String> {
        return data.map { "\($0.totalPrice)" }
    }

    var membersObservable: Observable<String> {
        return data.map { $0.member.joined(separator: ", ") }
    }
    
    struct Input {
        let titleBtnTap: ControlEvent<Void>
        let totalPriceTap: ControlEvent<Void>
        let memberTap: ControlEvent<Void>
//        let sectionHeaderSelectedSubject: ControlEvent<CSEditListHeader>
        let exclItemTap: ControlEvent<IndexPath>
    }
    
    struct Output {
        let pushTitleEditVC: Observable<Void>
        let pushPriceEditVC: Observable<Void>
        let pushMemberEditVC: Observable<Void>
//        let sectionHeaderSelectedObservable: Observable<CSEditListHeader>
        let pushExclItemEditVC: Observable<IndexPath>
//        let pushExclItemEditVC: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let title = input.titleBtnTap.asObservable()
        let price = input.totalPriceTap.asObservable()
        let member = input.memberTap.asObservable()
        let exclcell = input.exclItemTap.asObservable()
//        let item = input.exclItemTap.asObservable()
//        exclcell
//            .subscribe { _ in
//                print("셀클릭 됌")
//            }
        
        return Output(pushTitleEditVC: title, pushPriceEditVC: price, pushMemberEditVC: member, pushExclItemEditVC: exclcell)
    }
    
}
