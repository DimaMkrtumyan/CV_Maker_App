//
//  MainPageViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

final class MainPageViewController: UIViewController {
    
    // MARK: - Data
    var personsCvs = [PersonsCv]()
    
    // MARK: - UI elements
    private let ownerCvButton: MainPageButton = {
        let button = MainPageButton()
        button.setTitle("Owner CV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let createCvButton: MainPageButton = {
        let button = MainPageButton()
        button.setTitle("Create CV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let allCvButton: MainPageButton = {
        let button = MainPageButton()
        button.setTitle("All CVs", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Setup UI methods
    private func setupUi() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        stackView.addArrangedSubview(ownerCvButton)
        ownerCvButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ownerCvButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let vc = UIStoryboard(name: "OwnerCv", bundle: nil).instantiateViewController(withIdentifier: "OwnerCvViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        stackView.addArrangedSubview(createCvButton)
        createCvButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        stackView.addArrangedSubview(allCvButton)
        allCvButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    // MARK: - Actions
    private func allCvButtonAction() {
        allCvButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            if let vc = UIStoryboard(name: "AllCvs", bundle: nil).instantiateViewController(withIdentifier: "AllCvsPageTableViewController") as? AllCvsPageTableViewController {
                vc.personsCvs = self.personsCvs
                print(self.personsCvs)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }), for: .touchUpInside)
    }
    
    private func createCvButtonAction() {
        createCvButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let vc = UIStoryboard(name: "CreateCv", bundle: nil).instantiateViewController(withIdentifier: "FirstInfoPageViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        allCvButtonAction()
        createCvButtonAction()
    }

}
//
//extension MainPageViewController: DataPassDelegate {
//    func pass(cv: PersonsCv) {
//        self.personCv = cv
//    }
//}

