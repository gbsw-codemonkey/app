//
//  UserModel.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/12/24.
//

import Foundation

struct UserModel: Decodable {
    let idx: Int
    let id: String
    let name: String
    let email: String
}
