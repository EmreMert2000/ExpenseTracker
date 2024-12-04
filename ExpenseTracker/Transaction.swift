import Foundation

enum TransactionType: String, Codable {
    case income = "Income"
    case expense = "Expense"
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var type: TransactionType
    var date: Date

    init(title: String, amount: Double, type: TransactionType, date: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.type = type
        self.date = date
    }
}//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Emre Mert on 4.12.2024.
//

