//
//  ContactDetailViewController.swift
//  Assessment5
//
//  Created by Drew Seeholzer on 7/12/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var contact: Contact?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneTextField.text = contact.phoneNumber
        emailTextField.text = contact.email

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = phoneTextField.text,
            let email = emailTextField.text
            else { return }
        if let contact = contact {
            ContactController.sharedInstance.update(contact: contact, withName: name, phoneNumber: phoneNumber, email: email)
        } else {
            ContactController.sharedInstance.addContact(name: name, phoneNumber: phoneNumber, email: email)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
