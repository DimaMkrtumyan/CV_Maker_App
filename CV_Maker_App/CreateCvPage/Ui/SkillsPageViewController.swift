//
//  SkillsPageViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 27.07.23.
//

import UIKit

final class SkillsPageViewController: UIViewController {
    
    // MARK: - Data
    var personCv = PersonsCv()
    var storage = StorageManager()
    
    // MARK:  - UI elements
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy private var stackview: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        return stack
    }()
    
    lazy private var titleLabels: [UILabel] = {
        let labels = [UILabel(), UILabel()]
        labels[0].text = "Programming language"
        labels[1].text = "Soft skills"
        labels[0].translatesAutoresizingMaskIntoConstraints = false
        labels[1].translatesAutoresizingMaskIntoConstraints = false
        labels[0].textColor = .gray
        labels[1].textColor = .gray
        labels[0].font = .boldSystemFont(ofSize: 15)
        labels[1].font = .boldSystemFont(ofSize: 15)
        return labels
    }()
    
    lazy private var textFields: [CustomTextField] = {
        let textfields = [CustomTextField(), CustomTextField()]
        textfields[0].placeholder = "Insert programming language"
        textfields[1].placeholder = "Insert soft skills"
        textfields[0].translatesAutoresizingMaskIntoConstraints = false
        textfields[1].translatesAutoresizingMaskIntoConstraints = false
        return textfields
    }()
    
    lazy private var submitButton: SubmitButton = {
        let button = SubmitButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    lazy private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.setImage(.add, for: .normal)
        button.setImage(.add, for: .highlighted)
        return button
    }()
    
    
    // MARK: - UI setup methods
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackview)
        for textField in textFields {
            switch textField {
            case textFields[0]:
                stackview.addArrangedSubview(titleLabels[0])
                stackview.addArrangedSubview(textFields[0])
                textFields[0].delegate = self
                textFields[0].autocorrectionType = .no
            case textFields[1]:
                stackview.addArrangedSubview(titleLabels[1])
                stackview.addArrangedSubview(textFields[1])
                textFields[1].delegate = self
                textFields[1].autocorrectionType = .no
            default:
                return
            }
        }
        scrollView.addSubview(addButton)
        scrollView.addSubview(submitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            stackview.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackview.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackview.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.9),
            
            addButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            
            submitButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 50),
            submitButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
        for textField in textFields {
            switch textField {
            case textFields[0]:
                textFields[0].heightAnchor.constraint(equalToConstant: 50).isActive = true
            case textFields[1]:
                textFields[1].heightAnchor.constraint(equalToConstant: 50).isActive = true
            default:
                return
            }
        }
    }
    
    private func isTextFieldEmpty() -> Bool {
        if let text1 = textFields[0].text, let text2 = textFields[1].text {
            if text1.isEmpty || text2.isEmpty {
                return true
            }
        }
        return false
    }
    
    // MARK: - Actions
    private func submitButtonAction() {
        submitButton.addAction(UIAction(handler: { [weak self] _ in
            if let self, let vc = UIStoryboard(name: "OwnerCv", bundle: nil).instantiateViewController(identifier: "OwnerCvViewController") as? OwnerCvViewController {
                if isTextFieldEmpty() {
                    Alerts.emptyTextFieldAlert(vc: self)
                } else {
                    guard let name = self.personCv.name else { return }
                    guard let surname = self.personCv.name else { return }
                    // MARK: Data management and passing to the next page
                    self.personCv.skills![0] = self.textFields[0].text!
                    self.personCv.skills![1] = self.textFields[1].text!
                    storage.setStructure(self.personCv, forKey: name)
                    storage.setDictionary([name : surname], forKey: (name + surname))
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.personCv = self.personCv
                    vc.isPersonDataPassed = true
                }
            }
        }), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        submitButtonAction()
    }

}

extension SkillsPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ValidateTextField.isContainsDigits(in: string)
    }
}
