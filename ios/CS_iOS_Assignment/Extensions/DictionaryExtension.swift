//
//  DictionaryExtension.swift
//  CS_iOS_Assignment
//
//  Created by Gregory Casamento on 6/10/21.
//  Copyright © 2021 Backbase. All rights reserved.
//

import Foundation
    
extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
