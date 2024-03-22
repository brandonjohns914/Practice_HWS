//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Brandon Johns on 3/20/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
