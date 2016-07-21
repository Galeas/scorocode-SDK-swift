//
//  SCUpdate.swift
//  SC
//
//  Created by Aleksandr Konakov on 09/05/16.
//  Copyright © 2016 Aleksandr Konakov. All rights reserved.
//

import Foundation

public struct SCUpdate {
    
    private var _operators = [SCUpdateOperator]()
    public var operators: [SCUpdateOperator] {
        return _operators
    }

    public mutating func addOperator(oper: SCUpdateOperator) {
        _operators.append(oper)
    }

    public mutating func set(dic: [String: SCValue]) {
        let op = SCUpdateOperator.Set(dic)
        addOperator(op)
    }

    
    public mutating func push(name: String, _ value: SCValue) {
        let op = SCUpdateOperator.Push(name: name, value: value, each: false)
        addOperator(op)
    }
    
    public mutating func pushEach(name: String, _ value: SCValue) {
        guard value is SCArray else {
            print("Wrong value type - should be SCArray")
            return
        }
        
        let op = SCUpdateOperator.Push(name: name, value: value, each: true)
        addOperator(op)
    }
    
    public mutating func pull(name: String, _ value: SCPullable) {
        let op = SCUpdateOperator.Pull(name, value)
        addOperator(op)
    }

    public mutating func pullAll(name: String, _ value: SCValue) {
        guard value is SCArray else {
            print("Wrong value type - should be SCArray")
            return
        }
        
        let op = SCUpdateOperator.PullAll(name, value)
        addOperator(op)
    }
    
    public mutating func addToSet(name: String, _ value: SCValue) {
        let op = SCUpdateOperator.AddToSet(name: name, value: value, each: false)
        addOperator(op)
    }
    
    public mutating func addToSetEach(name: String, _ value: SCValue) {
        let op = SCUpdateOperator.AddToSet(name: name, value: value, each: true)
        addOperator(op)
    }
    
    public mutating func pop(name: String, _ value: Int) {
        guard value == 1 || value == -1 else {
            print("Wrong value")
            return
        }
        let op = SCUpdateOperator.Pop(name, value)
        addOperator(op)
    }
    
    public mutating func inc(name: String, _ value: SCValue) {
        guard value is SCDouble || value is SCInt else {
            print("Wrong value type")
            return
        }
        let op = SCUpdateOperator.Inc(name, value)
        addOperator(op)
    }
    
    public mutating func currentDate(name: String, typeSpec: String) {
        guard typeSpec == "date" || typeSpec == "timestamp" else {
            print("Wrong type specification")
            return
        }
        let op = SCUpdateOperator.CurrentDate(name, typeSpec)
        addOperator(op)
    }

    public mutating func mul(name: String, _ value: SCValue) {
        guard value is SCDouble || value is SCInt else {
            print("Wrong value type")
            return
        }
        let op = SCUpdateOperator.Mul(name, value)
        addOperator(op)
    }

    public mutating func min(name: String, _ value: SCValue) {
        let op = SCUpdateOperator.Min(name, value)
        addOperator(op)
    }
    
    public mutating func max(name: String, _ value: SCValue) {
        let op = SCUpdateOperator.Max(name, value)
        addOperator(op)
    }
    
}