//
//  AccountViewController.swift
//  test2024
//
//  Created by Jeremy Wang on 2/6/24.
//

import UIKit

class BudgetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var tuitionTextField: UITextField!
    
    
    @IBOutlet weak var scholarshipTextField: UITextField!
    
    @IBOutlet weak var honorSwitch: UISwitch!
    
    @IBOutlet weak var gradeLevelTextField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        honorSwitch.isOn = false
        balanceLabel.isHidden = true
        
        //Hide keyboard
        // Set text field delegates
            nameTextField.delegate = self
            tuitionTextField.delegate = self
            scholarshipTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    
    @IBAction func calculateButton(_ sender: UIButton) {
        /*
        let name = nameTextField.text!
        let tuition = Double(tuitionTextField.text!)
        
        let scholarship = Double(scholarshipTextField.text!)
        
        let balance = tuition! - scholarship!
        
        balanceLabel.text = "\(name), your balance is \(balance.formatted(.currency(code: "USD")))"
        */
        
         
        // Safely unwrap the 'name' using optional binding
        if let name = nameTextField.text, !name.isEmpty, let gradeLevel = gradeLevelTextField.text, !gradeLevel.isEmpty {
            // Attempt to convert tuition and scholarship text fields to Double using optional binding
            if let tuition = Double(tuitionTextField.text ?? ""), let scholarship = Double(scholarshipTextField.text ?? "") {
                // Calculate balance
                var balance = tuition - scholarship
                
                // Check for honor studeent status
                if honorSwitch.isOn {
                    balance = balance * (1 - 0.1)
                }
                
                //Add logic to handle gradeLevel
                let gradeLevel = gradeLevelTextField.text?.lowercased() // Convert to lower case to make the switch case-insensitive

                    // Apply discount based on the grade level
                    switch gradeLevel {
                    case "senior":
                        balance *= 0.95 // Reduce balance by 5%
                    case "junior":
                        balance *= 0.97 // Reduce balance by 3%
                    case "sophomore":
                        balance *= 0.98 // Reduce balance by 2%
                    case "freshman":
                        balance *= 1.00 // No reduction
                    default:
                        // Handle invalid input or empty string
                        print("Invalid grade level entered or no discount applicable.")
                    }

                
                // Update the balance label with the formatted balance
                if balance > 10000 {
                    balanceLabel.text = "\(name), your balance is \(balance.formatted(.currency(code: "USD"))) \n Do you wish to apply for financial assistance?"
                }else{
                    balanceLabel.text = "\(name), your balance is \(balance.formatted(.currency(code: "USD")))"
                }
            } else {
                // Handle the case where either tuition or scholarship couldn't be converted to Double
                balanceLabel.text = "Please enter valid numbers for tuition and scholarship."
            }
        } else {
            // Handle the case where 'name' is nil
            balanceLabel.text = "Please enter your name and grade level"
        }
        balanceLabel.isHidden = false
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
  
}


