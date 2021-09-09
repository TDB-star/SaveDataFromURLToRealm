//
//  NationalUSHolidaysModel.swift
//  SaveDataFromURLToRealm
//
//  Created by Tatiana Dmitrieva on 08/09/2021.
//

import Foundation
import RealmSwift

class Holiday: Object, Decodable {
    @objc dynamic var date: String?
    @objc dynamic var localName: String?
    @objc dynamic var name: String?
    @objc dynamic var fixed: Bool
    @objc dynamic var global: Bool
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
    
