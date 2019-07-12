//
//  ContactListTableViewController.swift
//  Assessment5
//
//  Created by Drew Seeholzer on 7/12/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ContactController.sharedInstance.fetchAllContacts { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactController.sharedInstance.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath) as? ContactListTableViewCell
        
        let contact = ContactController.sharedInstance.contacts[indexPath.row]
        
        cell?.contactLabel.text = contact.name
        cell?.phoneLabel.text = contact.phoneNumber
        cell?.emailLabel.text = contact.email
        
        return cell ?? UITableViewCell()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            
            let destinationVC = segue.destination as? ContactDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = ContactController.sharedInstance.contacts[indexPath.row]
            destinationVC?.contact = contact
        }

    }

}
