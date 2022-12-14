//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by User on 17/11/22.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private var toolBar: UIToolbar?
    private let doneButton = UIBarButtonItem(title: "done".localized, style: .plain, target: self, action: #selector(doneButtonTapped))
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var insertAgeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var agePickerView: UIPickerView!
    @IBAction func onSubmitButtonTap(_ sender: Any) {
        guard let text = insertAgeTextField.text, !text.isEmpty else {
            insertAgeTextField.layer.borderColor = UIColor.red.cgColor
            insertAgeTextField.layer.borderWidth = 1
            return
            }
        viewModel.saveUser(age: text)
        coordinator.navigateToMoviesList()
    }
   
    private let ageList: [Int] = Array<Int>((1...120))
    private var selectedAge: Int?
    private let coordinator: AppCoordinator
    
    init(viewModel: LoginViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePickerView.delegate = self
        agePickerView.dataSource = self
        insertAgeTextField.delegate = self
        insertAgeTextField.inputView = agePickerView
        agePickerView.isHidden = true
        agePickerView.clipsToBounds = false
        toolBar = UIToolbar()
        if let toolBar = toolBar {
            toolBar.isHidden = true
            toolBar.barStyle = .default
            toolBar.sizeToFit()
            toolBar.setItems([doneButton], animated: true)
            toolBar.isUserInteractionEnabled = true
            view.addSubview(toolBar)
        }
        titleLabel.text = "login".localized
        promptLabel.text = "insert_your_age".localized
        insertAgeTextField.placeholder = "age_here".localized
        submitButton.setTitle("submit".localized, for: .normal)
        setUpAccessibilityLabels()
    }
    
    @objc func doneButtonTapped() {
        guard let selectedAge = selectedAge else {
            return
        }
        insertAgeTextField.text = String(selectedAge)
        insertAgeTextField.resignFirstResponder()
        agePickerView.isHidden = true
        toolBar?.isHidden = true
        insertAgeTextField.layer.borderWidth = 0
    }
    
    private func setUpAccessibilityLabels() {
        submitButton.accessibilityLabel = "Submit"
        insertAgeTextField.accessibilityLabel = "Age here"
        agePickerView.accessibilityLabel = "Age picker"
        doneButton.accessibilityLabel = "Done"
        toolBar?.accessibilityLabel = "Tool bar"
    }
}

extension LoginViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ageList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(ageList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAge = ageList[row]
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        agePickerView.isHidden = false
        toolBar?.frame = CGRect(x: agePickerView.frame.minX, y: agePickerView.frame.minY, width: agePickerView.frame.width, height: 50)
        toolBar?.isHidden = false
        return false
    }
}
