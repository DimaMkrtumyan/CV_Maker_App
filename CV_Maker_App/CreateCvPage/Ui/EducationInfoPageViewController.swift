//
//  EducationInfoPageViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

final class EducationInfoPageViewController: UIViewController {

    // MARK: - UI elements
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy private var titleLabels: [UILabel] = {
        let labelsArray = [UILabel(), UILabel(), UILabel()]
        labelsArray[0].text = "School"
        labelsArray[0].textColor = .gray
        labelsArray[1].text = "Degree"
        labelsArray[1].textColor = .gray
        labelsArray[2].text = "Education Year"
        labelsArray[2].textColor = .gray
        labelsArray[0].font = .boldSystemFont(ofSize: 15)
        labelsArray[1].font = .boldSystemFont(ofSize: 15)
        labelsArray[2].font = .boldSystemFont(ofSize: 15)
        return labelsArray
    }()
    
    lazy private var textFields: [CustomTextField] = {
        let textFields = [CustomTextField(), CustomTextField(), CustomTextField()]
        return textFields
    }()
    
    lazy private var submitButton: SubmitButton = {
        let button = SubmitButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    // MARK: - Data
    var personCv = PersonsCv()
    private var tableViewHeaders: [String] = [
        "School",
        "Degree",
        "Graduation Year"
    ]

    // MARK: - Setup UI methods
    private func setupUi() {
        view.addSubview(stackView)
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                              constant: -20),
            submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                              constant: 50),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupTextFields() {
        for textField in textFields {
            textField.translatesAutoresizingMaskIntoConstraints = false
            switch textField {
            case textFields[0]:
                textFields[0].delegate = self
                textFields[0].autocorrectionType = .no
                stackView.addArrangedSubview(titleLabels[0])
                stackView.addArrangedSubview(textFields[0])
                textFields[0].placeholder = "Insert school name"
            case textFields[1]:
                textFields[1].delegate = self
                textFields[1].autocorrectionType = .no
                stackView.addArrangedSubview(titleLabels[1])
                stackView.addArrangedSubview(textFields[1])
                textFields[1].placeholder = "Insert degree"
            case textFields[2]:
                textFields[2].delegate = self
                textFields[2].autocorrectionType = .no
                stackView.addArrangedSubview(titleLabels[2])
                stackView.addArrangedSubview(textFields[2])
                textFields[2].placeholder = "Insert graduation year"
            default:
                print("Deafult!")
            }
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    private func isTextFieldEmpty() -> Bool {
        if let text1 = textFields[0].text, let text2 = textFields[1].text, let text3 = textFields[2].text {
            if text1.isEmpty || text2.isEmpty || text3.isEmpty {
                return true
            }
        }
        return false
    }
    
    // MARK: - Action methods
    private func submitButtonAction() {
        submitButton.addAction(UIAction(handler: { [weak self] _ in
            if let self, let vc = storyboard?.instantiateViewController(withIdentifier: "WorkExperienceViewController") as? WorkExperienceViewController {
                if isTextFieldEmpty() {
                    Alerts.emptyTextFieldAlert(vc: self)
                } else {
                    
                    // MARK: Data management and passing to the next page
                    self.personCv.education![0] = self.textFields[0].text!
                    self.personCv.education![1] = self.textFields[1].text!
                    self.personCv.education![2] = self.textFields[2].text!
                    vc.personCv = self.personCv
                    print(vc.personCv)
                    self.navigationController?.pushViewController(vc, animated: true)}
            }
        }), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupTextFields()
        submitButtonAction()
    }

}

extension EducationInfoPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === textFields[2] {
            return ValidateTextField.isContainsCharacters(in: string)
        } else {
            return ValidateTextField.isContainsDigits(in: string)
        }
    }
}
