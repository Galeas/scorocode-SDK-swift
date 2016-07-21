//
//  SCQuery.swift
//  SC
//
//  Created by Aleksandr Konakov on 28/04/16.
//  Copyright © 2016 Aleksandr Konakov. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct SCQuery {
    
    private let _collection: String
    public var collection: String {
        return _collection
    }
    
    private var _userQuery: [String: AnyObject]?
    public var userQuery: [String: AnyObject]? {
        return _userQuery
    }
    
    private var _operators: [String: SCOperator]?
    public var operators: [String: SCOperator]? {
        return _operators
    }
    
    private var _andOr: SCOperator?
    public var andOr: SCOperator? {
        return _andOr
    }
    
    private var _limit: Int?
    public var limit: Int? {
        return _limit
    }
    
    private var _skip: Int?
    public var skip: Int? {
        return _skip
    }
    
    private var _sort: [String: Int]?
    public var sort: [String: Int]? {
        return _sort
    }
    
    private var _fields: [String]?
    public var fields: [String]? {
        return _fields
    }
        
    public init(collection: String) {
        self._collection = collection
    }
    
    // Поиск документов, на основе сформированного условия выборки. Возвращает ошибку или массив документов.
    public func find(callback: (Bool, SCError?, [String: AnyObject]?) -> Void) {

        SCAPI.sharedInstance.find(self, callback: callback)
    }
    
    // Подсчет количества документов в коллекции согласно условию выборки.
    public func count(callback: (Bool, SCError?, Int?) -> Void) {
        
        SCAPI.sharedInstance.count(self, callback: callback)
    }
    
    // Обновляет документы соответствующие условию выборки.
    public func update(update: SCUpdate, callback: (Bool, SCError?, [String: AnyObject]?) -> Void) {
        
        SCAPI.sharedInstance.update(self, update: update, callback: callback)
    }
    
    // Удаляет документы соответствующие условию выборки.
    public func remove(callback: (Bool, SCError?, [String: AnyObject]?) -> Void) {
        
        SCAPI.sharedInstance.remove(self, callback: callback)
    }
    
    // Устанавливает лимит выборки (параметр limit протокола).
    public mutating func limit(limit: Int) {
        _limit = limit
    }
    
    // Метод для установки количества пропускаемых документов (параметр skip протокола).
    public mutating func skip(skip: Int) {
        _skip = skip
    }
    
    // Метод для рассчета skip, соответствующего номеру страницы на основе установленного значения limit.
    public mutating func page(page: Int) {
        guard page > 0 else { return }
        if let limit = _limit {
            _skip = (page - 1) * limit
        } else {
            _skip = 0
        }
    }
    
    // Установка пользовательского условия выборки
    public mutating func raw(json: String) {
        
        if let dataFromString = json.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            _userQuery = json.dictionaryObject
        }
    }
    
    // Очистка условий выборки
    public mutating func reset() {
        _operators = nil
        _userQuery = nil
        _sort = nil
        _fields = nil
        _andOr = nil
    }
    
    // Сортировка по полю по возрастанию (параметр sort протокола)
    public mutating func ascending(name: String) {
        if _sort == nil {
            _sort = [String: Int]()
        }
        _sort![name] = 1
    }
    
    // Сортировка по полю по убыванию (параметр sort протокола)
    public mutating func descending(name: String) {
        if _sort == nil {
            _sort = [String: Int]()
        }
        _sort![name] = -1
    }
    
    // Установка списка возвращаемых полей (параметр fields протокола)
    public mutating func fields(names: [String]) {
        _fields = names
    }
    
    public mutating func addOperator(name: String, oper: SCOperator) {
        if _operators == nil {
            _operators = [String: SCOperator]()
        }
        _operators![name] = oper
    }
    
    public mutating func equalTo(name: String, _ value: SCValue) {
        let op = SCOperator.EqualTo(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func notEqualTo(name: String, _ value: SCValue) {
        let op = SCOperator.NotEqualTo(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func containedIn(name: String, _ value: SCArray) {
        let op = SCOperator.ContainedIn(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func containsAll(name: String, _ value: SCArray) {
        let op = SCOperator.ContainsAll(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func notContainedIn(name: String, _ value: SCArray) {
        let op = SCOperator.NotContainedIn(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func greaterThan(name: String, _ value: SCValue) {
        let op = SCOperator.GreaterThan(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func greaterThanOrEqualTo(name: String, _ value: SCValue) {
        let op = SCOperator.GreaterThanOrEqualTo(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func lessThan(name: String, _ value: SCValue) {
        let op = SCOperator.LessThan(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func lessThanOrEqualTo(name: String, _ value: SCValue) {
        let op = SCOperator.LessThanOrEqualTo(name, value)
        addOperator(name, oper: op)
    }
    
    public mutating func exists(name: String) {
        let op = SCOperator.Exists(name)
        addOperator(name, oper: op)
    }
    
    public mutating func doesNotExist(name: String) {
        let op = SCOperator.DoesNotExist(name)
        addOperator(name, oper: op)
    }
    
    public mutating func contains(name: String, _ pattern: String) {
        let op = SCOperator.Contains(name, pattern, "")
        addOperator(name, oper: op)
    }
    
    public mutating func startsWith(name: String, _ pattern: String) {
        let op = SCOperator.StartsWith(name, pattern, "")
        addOperator(name, oper: op)
    }
    
    public mutating func endsWith(name: String, _ pattern: String) {
        let op = SCOperator.EndsWith(name, pattern, "")
        addOperator(name, oper: op)
    }
    
    public mutating func and(operators: [SCOperator]) {
        let op = SCOperator.And(operators)
        _andOr = op
    }
    
    public mutating func or(operators: [SCOperator]) {
        let op = SCOperator.Or(operators)
        _andOr = op
    }
    
}