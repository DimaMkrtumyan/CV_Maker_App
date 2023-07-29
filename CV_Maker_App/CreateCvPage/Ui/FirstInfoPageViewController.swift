//
//  FirstInfoPageViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 25.07.23.
//

import UIKit

final class FirstInfoPageViewController: UIViewController {
    
    // MARK: - Data
    private var birthDate: String?
    private var personCv: PersonsCv = PersonsCv()
    private var storage = StorageManager()
    
    // MARK: - UI elements
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy private var surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Surname"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy private var datePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birth date"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    lazy private var textFields: [CustomTextField] = {
        let textfields = [CustomTextField(), CustomTextField()]
        textfields[0].translatesAutoresizingMaskIntoConstraints = false
        textfields[0].placeholder = "Insert your name"
        textfields[1].translatesAutoresizingMaskIntoConstraints = false
        textfields[1].placeholder = "Insert your surname"
        return textfields
    }()
    
    lazy private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    lazy private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy private var submitButton: SubmitButton = {
        let button = SubmitButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    // MARK: - Methods
    private func setupDatePicker() {
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YY"
            formatter.dateStyle = .medium
            let dateStr = formatter.string(from: datePicker.date)
            self.birthDate = dateStr
            print(self.personCv)
        }), for: .valueChanged)
    }
    
    private func isTextFieldEmpty() -> Bool {
        if let text1 = textFields[0].text, let text2 = textFields[1].text {
            if text1.isEmpty || text2.isEmpty {
                return true
            }
        }
        return false
    }
    
    private func submitButtonAction() {
        submitButton.addAction(UIAction(handler: { [weak self]_ in
            if let self, let secondInfoPageVc = UIStoryboard(name: "CreateCv", bundle: nil).instantiateViewController(withIdentifier: "EducationInfoPageViewController") as? EducationInfoPageViewController {
                if isTextFieldEmpty() {
                    Alerts.emptyTextFieldAlert(vc: self)
                } else {
                    
                    // MARK: Data management and passing to the next page
                    self.personCv.name = "\(self.textFields[0].text ?? "Empty name field!")"
                    self.personCv.surname = "\(self.textFields[1].text ?? "Empty surname field!")"
                    self.personCv.birthDate = self.birthDate
                    secondInfoPageVc.personCv = self.personCv
                    self.navigationController?.pushViewController(secondInfoPageVc, animated: true)
                }
            }
        }), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        view.addSubview(stackView)
        view.addSubview(datePickerLabel)
        view.addSubview(datePicker)
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20),
            datePickerLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                constant: 20),
            datePickerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor,
                                           constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20),
            submitButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor,
                                           constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
       
        for textfield in textFields {
            switch textfield {
            case textFields[0]:
                textFields[0].autocorrectionType = .no
                stackView.addArrangedSubview(nameLabel)
                stackView.addArrangedSubview(textFields[0])
            case textFields[1]:
                textFields[1].autocorrectionType = .no
                stackView.addArrangedSubview(surnameLabel)
                stackView.addArrangedSubview(textFields[1])
            default:
                break
            }
            textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
            textfield.delegate = self
            textfield.autocorrectionType = .no
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupDatePicker()
        submitButtonAction()
    }

}

extension FirstInfoPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFields[0] where textField === textFields[0]:
            textFields[0].resignFirstResponder()
            textFields[1].becomeFirstResponder()
        case textFields[1] where textField === textFields[1]:
            textFields[1].resignFirstResponder()
        default:
            break
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ValidateTextField.isContainsDigits(in: string)
    }
}
