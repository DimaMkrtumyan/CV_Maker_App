//
//  AllCvsPageTableViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 29.07.23.
//

import UIKit

class AllCvsPageTableViewController: UITableViewController {
    
    // MARK: - Data
//    let storage = StorageManager()
    var personsCvs = [PersonsCv]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(personsCvs)
        self.tableView.register(UINib(nibName: "OwnerCvPageTableViewCell", bundle: nil), forCellReuseIdentifier: "OwnerCvPageTableViewCell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsCvs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCvPageTableViewCell") as? OwnerCvPageTableViewCell {
            if !(personsCvs.isEmpty) {
                guard let name = personsCvs[indexPath.row].name, let surname = personsCvs[indexPath.row].surname else { return UITableViewCell() }
                cell.setup(info: "\(name) \(surname)")
                return cell
            }
            cell.setup(info: "Error!")
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "OwnerCv", bundle: nil).instantiateViewController(withIdentifier: "OwnerCvViewController") as? OwnerCvViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.personCv = self.personsCvs[indexPath.row]
            print(self.personsCvs[indexPath.row])
            vc.isPersonDataPassed = true
        }
    }
}
