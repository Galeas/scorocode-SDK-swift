//
//  SCMessage.swift
//  SC
//
//  Created by Aleksandr Konakov on 28/04/16.
//  Copyright © 2016 Aleksandr Konakov. All rights reserved.
//

import Foundation

public struct SCMessage {
    
    public static func sendEmail(query: SCQuery, subject: String, text: String, callback: (Bool, SCError?, Int?) -> Void) {
        
        SCAPI.sharedInstance.sendEmail(query, subject: subject, text: text, callback: callback)
    }
    
    public static func sendPush(query: SCQuery, subject: String, text: String, callback: (Bool, SCError?, Int?) -> Void) {
        
        SCAPI.sharedInstance.sendPush(query, subject: subject, text: text, callback: callback)
    }
    
    public static func sendSms(query: SCQuery, subject: String, text: String, callback: (Bool, SCError?, Int?) -> Void) {
        
        SCAPI.sharedInstance.sendSms(query, subject: subject, text: text, callback: callback)
    }
}