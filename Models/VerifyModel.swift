//
//  VerifyModel.swift
//  CreativeLens
//
//  Created by Boseok Son on 7/12/24.
//

import Foundation

struct VerifyResponse: Decodable {
    let status: Bool
    let msg: String
    let user: UserModel
}
