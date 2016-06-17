//
//  UCAddLocationIntendHandler.swift
//  CarFinder
//
//  Created by nvovap on 6/17/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import Foundation
import Intents
//import UnicornCore

class UCAddLocationIntendHandler: NSObject, INSendMessageIntentHandling {
    
    func handle(sendMessage intent: INSendMessageIntent, completion: (INSendMessageIntentResponse) -> Void) {
        
        if intent.recipients != nil && intent.content != nil {
            
            print("Siri handle")
            print("Content = \(intent.content)")
            print("Recipients = \(intent.recipients)")
            
            completion(INSendMessageIntentResponse(code: .success, userActivity: nil))
        } else {
            completion(INSendMessageIntentResponse(code: .failure, userActivity: nil))
        }
        
    }
    
    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: ([INPersonResolutionResult]) -> Void) {
        if let recipients = intent.recipients {
         //   var resulutionResults = [INPersonResolutionResult]()
            
            print("Siri Recipients")
            print("Recipients = \(intent.recipients)")

            
            for recipient in recipients {
                print(recipient.displayName)
            }
            
            completion([INPersonResolutionResult.unsupported(with: INIntentResolutionResultUnsupportedReason.none)])
        } else {
            completion([INPersonResolutionResult.needsValue()])
        }
    }
    
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: (INStringResolutionResult) -> Void) {
        if let text = intent.content where !text.isEmpty {
            print("Siri Content")
            print("Text resolve text = \(text)")
            completion(INStringResolutionResult.success(with: text))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func confirm(sendMessage intent: INSendMessageIntent, completion: (INSendMessageIntentResponse) -> Void) {
        print("Siri Confirm")
        completion(INSendMessageIntentResponse.init(code: INSendMessageIntentResponseCode.failureRequiringAppLaunch, userActivity: nil))
    }
    
}
