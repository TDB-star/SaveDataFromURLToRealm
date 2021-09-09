//
//  ViewController.swift
//  SaveDataFromURLToRealm
//
//  Created by Tatiana Dmitrieva on 08/09/2021.
//

import UIKit
import RealmSwift

class HolidaysViewController: UITableViewController {
    
    var dataBaseLayer: DataBaseLayer?
    var holidays: Results<Holiday>?
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBaseLayer = DataBaseLayer()
        getDataFromServer()
        
        let realm = try! Realm()
        let result = realm.objects(Holiday.self)
        token = result.observe{ _ in
            self.tableView.reloadData()
        }
        holidays = realm.objects(Holiday.self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let usHolidays = holidays else {
            return 0
        }
        return usHolidays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let holidayTitle = holidays?[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = holidayTitle?.name
        content.secondaryText = holidayTitle?.date
        cell.contentConfiguration = content
        return cell
    }
    func getDataFromServer() {
        dataBaseLayer?.loadJSON()
    }
    deinit {
        token?.invalidate()
    }

}

