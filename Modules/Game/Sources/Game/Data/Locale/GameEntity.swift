//
//  GameEntity.swift
//
//
//  Created by Rizal Fahrudin on 20/12/23.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var desc: String = ""
    @objc dynamic var ratingTopString: String = ""

    override public class func primaryKey() -> String? {
        return "id"
    }
}
