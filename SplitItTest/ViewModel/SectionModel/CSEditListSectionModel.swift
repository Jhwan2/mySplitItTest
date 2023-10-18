//
//  CSEditListSectionModel.swift
//  SplitItTest
//
//  Created by 주환 on 2023/10/11.
//

import Foundation
import RxDataSources

struct CSEditListSectionModel {
    var header: String
    var items: [String]
}

extension CSEditListSectionModel: SectionModelType {
    typealias Item = String
    
    init(original: CSEditListSectionModel, items: [String]) {
        self = original
        self.items = items
    }
}

struct CSEditListItemSectionModel {
    var header: String
    var items: [String]
}

extension CSEditListItemSectionModel: SectionModelType {
    typealias Item = String
    
    init(original: CSEditListItemSectionModel, items: [String]) {
        self = original
        self.items = items
    }
}


