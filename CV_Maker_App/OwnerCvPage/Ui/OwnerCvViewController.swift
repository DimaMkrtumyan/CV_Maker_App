//
//  OwnerCvViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

final class OwnerCvViewController: UIViewController {
    
    // MARK: - Data
    var personCv = PersonsCv()
    var defaultCv = PersonsCv(
        name: "Dima",
        surname: "Mkrtumyan",
        birthDate: "18/01/1996",
        education: [
            "National University of Architechture and Constraction of Armenian",
            "Bachelor",
            "2019"
        ],
        experience: [
            "AAA LLC",
            "iOS Developer",
            "5 month"
        ],
        skills: [
            "Swift",
            "Leadership"
        ]
    )
    var isPersonDataPassed = false
    private var personDefaultCv = [
        "Name",
        "Surname",
        "Date of Birth",
        "Education",
        "Work experince",
        "Skills"
    ]
    
    // MARK: - UI elements
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - UI setup methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OwnerCvPageTableViewCell", bundle: nil), forCellReuseIdentifier: "OwnerCvPageTableViewCell")
        tableView.sectionHeaderTopPadding = 10
        view.addSubview(tableView)
        let top = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    // MARK: - Actions
    private func backButtonAction() {
        let customBackButton = UIBarButtonItem(title: "Main Page", style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc
    private func goBack() {
        if let vc = self.navigationController?.viewControllers[0] as? MainPageViewController {
            vc.personsCvs.append(self.personCv)
            print(self.personCv)
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(personCv)
        setupTableView()
        backButtonAction()
    }

}

extension OwnerCvViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 3
        case 4:
            return 3
        case 5:
            return 2
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        personDefaultCv.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCvPageTableViewCell", for: indexPath) as? OwnerCvPageTableViewCell {
            switch indexPath.section {
            case 0:
                if isPersonDataPassed {
                    guard let name = personCv.name else { return UITableViewCell() }
                    cell.setup(info: name)
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.name!)
                cell.selectionStyle = .none
                return cell
            case 1:
                if isPersonDataPassed {
                    guard let surname = personCv.surname else { return UITableViewCell() }
                    cell.setup(info: surname)
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.surname!)
                cell.selectionStyle = .none
                return cell
            case 2:
                if isPersonDataPassed {
                    guard let birthDate = personCv.birthDate else { return UITableViewCell() }
                    cell.setup(info: birthDate)
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.birthDate!)
                cell.selectionStyle = .none
                return cell
            case 3:
                if isPersonDataPassed {
                    cell.setup(info: personCv.education![indexPath.row])
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.education![indexPath.row])
                cell.selectionStyle = .none
                return cell
            case 4:
                if isPersonDataPassed {
                    cell.setup(info: personCv.experience![indexPath.row])
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.experience![indexPath.row])
                cell.selectionStyle = .none
                return cell
            case 5:
                if isPersonDataPassed {
                    cell.setup(info: personCv.skills![indexPath.row])
                    cell.selectionStyle = .none
                    return cell
                }
                cell.setup(info: defaultCv.skills![indexPath.row])
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
        }

        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        personDefaultCv[section]
    }
}

extension OwnerCvViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
}
