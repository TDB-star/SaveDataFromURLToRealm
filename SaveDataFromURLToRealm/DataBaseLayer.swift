//
//  DataBaseLayer.swift
//  SaveDataFromURLToRealm
//
//  Created by Tatiana Dmitrieva on 08/09/2021.
//

import RealmSwift

struct DataBaseLayer {
    mutating func loadJSON() {
        guard let url = URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
              let decoder = JSONDecoder()
                let holidayModel = try decoder.decode([Holiday].self, from: dataResponse)
                let realm = try! Realm()
                for holiday in holidayModel {
                    try! realm.write({
                        realm.add(holiday, update: .all)
                    })
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
