//
//  UserData.swift
//  diveCompanionSnapKit
//
//  Created by Mikołaj Linczewski on 26/05/2021.
//

import Foundation
import Firebase

struct Userdata: Codable {
    let username: String?
    let email: String?
    let password: String?
}

extension DocumentSnapshot {
  func decoded<Type: Decodable>() throws -> Type {
    let jsonData = try JSONSerialization.data(withJSONObject: data() ?? [:], options: [])
    let object = try JSONDecoder().decode(Type.self, from: jsonData)
    return object
  }
}
extension QuerySnapshot {
    func decoded<Type: Decodable>() throws -> [Type] {
      var objects: [Type] = []
      for doc in documents {
        do {
          let object: Type = try doc.decoded()
          objects.append(object)
        } catch {
          print(error)
        }
      }
      return objects
    }
}
extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}







Message Karol Zmyslowski:slack_call: On a call












