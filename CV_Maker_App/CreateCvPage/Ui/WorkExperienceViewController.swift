//
//  WorkExperienceViewController.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 26.07.23.
//

import UIKit

class WorkExperienceViewController: UIViewController {

    // MARK: - Data
    var personCv = PersonsCv()
    
    // MARK: - UI elements
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy private var stackView: UIStackView = {
        let scroll = UIStackView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.axis = .vertical
        scroll.spacing = 10
        return scroll
    }()
    
    lazy private var textFields: [CustomTextField] = {
        let textfields = [CustomTextField(), CustomTextField(), CustomTextField()]
        return textfields
    }()
    
    lazy private var titleLabels: [UILabel] = {
        let labels = [UILabel(), UILabel(), UILabel()]
        labels[0].text = "Company name"
        labels[1].text = "Job title"
        labels[2].text = "Duration"
        labels[0].textColor = .gray
        labels[1].textColor = .gray
        labels[2].textColor = .gray
        labels[0].font = .boldSystemFont(ofSize: 15)
        labels[1].font = .boldSystemFont(ofSize: 15)
        labels[2].font = .boldSystemFont(ofSize: 15)
        return labels
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
    private func setupSubViews() {
        view.addSubview(scrollView)
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: 2000)

        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabels[0])
        stackView.addArrangedSubview(textFields[0])
        stackView.addArrangedSubview(titleLabels[1])
        stackView.addArrangedSubview(textFields[1])
        stackView.addArrangedSubview(titleLabels[2])
        stackView.addArrangedSubview(textFields[2])
        scrollView.addSubview(addButton)
        scrollView.addSubview(submitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            submitButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: scrollView.contentLayoutGuide.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
        
        for textField in textFields {
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 50),
                textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
                textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            ])
        }
        
        for label in titleLabels {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            ])
        }
    }
    
    private func setupTextField() {
        for textField in textFields {
            switch textField {
            case textFields[0]:
                textFields[0].placeholder = "Insert company name"
                textFields[0].delegate = self
                textFields[0].autocorrectionType = .no
            case textFields[1]:
                textFields[1].placeholder = "Insert job title"
                textFields[1].delegate = self
                textFields[1].autocorrectionType = .no
            case textFields[2]:
                textFields[2].placeholder = "Insert job duration"
                textFields[2].delegate = self
                textFields[2].autocorrectionType = .no
            default:
                return
            }
        }
    }
    
    // MARK: - Actions
    func addButtonAction() {
        addButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            let newLabels: [UILabel] = {
                let labels = [UILabel(), UILabel(), UILabel()]
                labels[0].text = "Company name"
                labels[1].text = "Job title"
                labels[2].text = "Duration"
                labels[0].textColor = .gray
                labels[1].textColor = .gray
                labels[2].textColor = .gray
                labels[0].font = .boldSystemFont(ofSize: 15)
                labels[1].font = .boldSystemFont(ofSize: 15)
                labels[2].font = .boldSystemFont(ofSize: 15)
                return labels
            }()

           let newTextFields: [CustomTextField] = {
                let textfields = [CustomTextField(), CustomTextField(), CustomTextField()]
                textfields[0].heightAnchor.constraint(equalToConstant: 50).isActive = true
                textfields[1].heightAnchor.constraint(equalToConstant: 50).isActive = true
                textfields[2].heightAnchor.constraint(equalToConstant: 50).isActive = true
                return textfields
            }()

            for field in newTextFields {
                switch field {
                case newTextFields[0]:
                    self.stackView.addArrangedSubview(newLabels[0])
                    self.stackView.addArrangedSubview(newTextFields[0])
                    newTextFields[0].placeholder = "Insert company name"
                    newTextFields[0].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newTextFields[0].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                    newLabels[0].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newLabels[0].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                case newTextFields[1]:
                    self.stackView.addArrangedSubview(newLabels[1])
                    self.stackView.addArrangedSubview(newTextFields[1])
                    newTextFields[1].placeholder = "Insert job title"
                    newTextFields[1].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newTextFields[1].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                    newLabels[1].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newLabels[1].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                case newTextFields[2]:
                    self.stackView.addArrangedSubview(newLabels[2])
                    self.stackView.addArrangedSubview(newTextFields[2])
                    newTextFields[2].placeholder = "Insert job duration"
                    newTextFields[2].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newTextFields[2].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                    newLabels[2].leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 20).isActive = true
                    newLabels[2].trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -20).isActive = true
                default:
                    return
                }
            }
        }), for: .touchUpInside)
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
        submitButton.addAction(UIAction(handler: { [weak self] _ in
            if let self, let vc = storyboard?.instantiateViewController(withIdentifier: "SkillsPageViewController") as? SkillsPageViewController {
                if isTextFieldEmpty() {
                    Alerts.emptyTextFieldAlert(vc: self)
                } else {
                    
                    // MARK: Data management and passing to the next page
                    self.personCv.experience![0] = self.textFields[0].text!
                    self.personCv.experience![1] = self.textFields[1].text!
                    self.personCv.experience![2] = self.textFields[2].text!
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.personCv = self.personCv
                    print(self.personCv)
                }
                
            }
        }), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        setupTextField()
        addButtonAction()
        submitButtonAction()
    }

}

extension WorkExperienceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ValidateTextField.isContainsDigits(in: string)
    }
}
