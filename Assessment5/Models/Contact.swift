//
//  Contact.swift
//  Assessment5
//
//  Created by Drew Seeholzer on 7/12/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    //Properties
    var name: String
    var phoneNumber: String
    var email: String
    // Cloudkit
    let ckRecordID: CKRecord.ID
    
    init(name: String, phoneNumber: String, email: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Constants.NameKey] as? String,
        let phoneNumber = ckRecord[Constants.PhoneKey] as? String,
        let email = ckRecord[Constants.EmailKey] as? String else { return nil }
        
        self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init (contact: Contact) {
        self.init(recordType: Constants.ContactRecordType, recordID: contact.ckRecordID)
        self.setValue(contact.name, forKey: Constants.NameKey)
        self.setValue(contact.phoneNumber, forKey: Constants.PhoneKey)
        self.setValue(contact.email, forKey: Constants.EmailKey)
    }
    
}

// Keys
struct Constants {
    static let ContactRecordType = "Contact"
    static let NameKey = "Name"
    static let PhoneKey = "PhoneNumber"
    static let EmailKey = "Email"
}
