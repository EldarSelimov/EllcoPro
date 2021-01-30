//
//  TicketModel.swift
//  EllcoProject
//
//  Created by Eldar on 26.01.2021.
//

import Foundation

struct TicketModel: Codable {
    let name: String
    let description: String
    let sender: SenderModel
    let status: StatusModel
    let currentPage: Int?
}

struct SenderModel: Codable {
    let id: Int
    let username: String
}

struct StatusModel: Codable {
    let description: String
    let tooltip: String
}
