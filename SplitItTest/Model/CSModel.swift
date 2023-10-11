//
//  JsModel.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import Foundation

struct CSModel {
    var title: String
    var totalPrice: Int
    var member: [String]
    var item: [ExclItem]
}

struct ExclItem {
    var itemName: String
    var exclMember: [Bool]
}
