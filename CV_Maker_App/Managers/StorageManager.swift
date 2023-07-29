//
//  StorageManager.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 28.07.23.
//

import Foundation

protocol StorageManagerProtocol {
    var allUserDefaulsData: [String: Any] { get }
    
    func setStructure(_ object: PersonsCv, forKey key: String)
    func setDictionary(_ object: Dictionary<String, String>, forKey key: String)
    func getPersonCvStructure(forKey key: String) -> PersonsCv?
    func getDictionary(forKey key: String) -> Dictionary<String, String>?
    func removeStruct(forKey key: String)
}

final class StorageManager {
    
    private let userDefaults = UserDefaults.standard
    private let allData = UserDefaults.standard.dictionaryRepresentation()
    
    private func store(object: Any, key: String) {
        switch object {
        case let newObject as PersonsCv:
            userDefaults.set(try? JSONEncoder().encode(newObject), forKey: key)
        case let dict as Dictionary<String, String>:
            userDefaults.set(dict, forKey: key)
        default:
            return
        }
    }
    
    private func restore(forKey key: String) -> Any? {
        let data = try? JSONDecoder().decode(PersonsCv.self,
                                            from: userDefaults.object(forKey: key) as! Data)
        return data
    }
    
    private func restoreDictionary(forKey key: String) -> Any? {
         userDefaults.object(forKey: key)
    }
    
    private func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

extension StorageManager: StorageManagerProtocol {
    
    var allUserDefaulsData: [String : Any] {
        return allData
    }
    
    func getDictionary(forKey key: String) -> Dictionary<String, String>? {
        restoreDictionary(forKey: key) as? Dictionary<String, String>
    }
    
    func setDictionary(_ object: Dictionary<String, String>, forKey key: String) {
        store(object: object, key: key)
    }
    
    func setStructure(_ object: PersonsCv, forKey key: String) {
        store(object: object, key: key)
    }
    
    func getPersonCvStructure(forKey key: String) -> PersonsCv? {
        restore(forKey: key) as? PersonsCv
    }
    
    func removeStruct(forKey key: String) {
        remove(forKey: key)
    }
}
