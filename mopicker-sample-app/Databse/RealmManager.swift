//
//  RealmManager.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 18.05.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm
    
    
    private init() {
        self.realm = try! Realm()
    }
    
    func getDataFromDB() -> Results<Result> {
        let results: Results<Result> = realm.objects(Result.self)
        return results
    }
    func addData(object: List<Result>) {
        object.forEach { result in
            if Array(getDataFromDB()).contains(where: { (storedObject) -> Bool in
                storedObject.id == result.id
            }) {
                print("val exists")
            } else {
                try! realm.write {
                    realm.add(object, update: .modified)
                    print("Added new object")
                }
            }
        }
        
    }
    func deleteAllFromDatabase()  {
        try! realm.write {
            realm.deleteAll()
        }
    }
    func deleteFromDb(object: TrendVideos)   {
        try! realm.write {
            realm.delete(object)
        }
    }
}
