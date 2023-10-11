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
    var items: [CSModel]
}

extension CSEditListSectionModel: SectionModelType {
    typealias Item = CSModel
    
    init(original: CSEditListSectionModel, items: [CSModel]) {
        self = original
        self.items = items
    }
}
