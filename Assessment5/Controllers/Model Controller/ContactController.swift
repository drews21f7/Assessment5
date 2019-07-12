//
//  ContactController.swift
//  Assessment5
//
//  Created by Drew Seeholzer on 7/12/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    static let sharedInstance = ContactController()
    
    var contacts: [Contact] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK - CRUD
    
    func addContact(name: String, phoneNumber: String, email: String) {
        
        let newContact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        let newRecord = CKRecord(contact: newContact)
        
        privateDB.save(newRecord) { (record, error) in
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                return
            }
            
            guard let record = record,
                let contact = Contact(ckRecord: record)
                else { return }
            
            self.contacts.append(contact)
            
        }
    }
    
    func fetchAllContacts(completion: @escaping ([Contact]?) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.ContactRecordType, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error{
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { return }
            let contacts: [Contact] = records.compactMap{Contact(ckRecord: $0)}
            self.contacts = contacts
            
            completion(contacts)
            
        }
    }
    
    func updateRecord(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        
        let operation = CKModifyRecordsOperation()
        
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        
        database.add(operation)
    }
    
    func update(contact: Contact, withName name: String, phoneNumber: String, email: String) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        
        let recordToSave = CKRecord(contact: contact)
        let database = privateDB
        
        updateRecord(record: recordToSave, database: database) { (success) in
            if success {
                print ("Updated entry successfully")
            }
        }
    }
    
    
}
