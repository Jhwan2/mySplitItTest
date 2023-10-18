//
//  DataManager.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import Foundation
import RxSwift

struct DataManager {
    static let shared = DataManager()
    
    var data = BehaviorSubject<CSModel>(value: CSModel(title: "양꼬치집", totalPrice: 128000,
                                                       member: ["제리", "모아나", "코리", "완", "제롬", "토마토"],
                                                       items: [
                                                           ExclItem(itemName: "술값",
                                                                    itemPrice: 10000, exclMember: ["모아나", "제롬", "제롬", "토마토", "제롬", "토마토", "제롬", "토마토"]),
                                                           ExclItem(itemName: "기름값",
                                                                    itemPrice: 30000, exclMember: ["코리", "토마토"])]))
    
    func titleEdit(title: String) {
        var currentValue = try! data.value()
        currentValue.title = title
        data.onNext(currentValue)
    }
    
    func totalPriceEdit(price: String) {
        var currentValue = try! data.value()
        currentValue.totalPrice = Int(price)!
        data.onNext(currentValue)
    }
}
