import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private let transactionsKey = "transactions"

    init() {
        loadTransactions()
    }

    // Verileri Kaydet
    func saveTransactions() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encoded, forKey: transactionsKey)
        }
    }

    // Verileri Yükle
    func loadTransactions() {
        if let savedData = UserDefaults.standard.data(forKey: transactionsKey),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: savedData) {
            transactions = decoded
        }
    }

    // Yeni Gider/Gelir Ekle
    func addTransaction(title: String, amount: Double, type: TransactionType) {
        let newTransaction = Transaction(title: title, amount: amount, type: type)
        transactions.append(newTransaction)
        saveTransactions()
    }

    // Gider/Gelir Sil
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
        saveTransactions()
    }

    // Toplam Gelir
    func totalIncome() -> Double {
        transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }

    // Toplam Gider
    func totalExpense() -> Double {
        transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }

    // Net Bakiye
    func netBalance() -> Double {
        totalIncome() - totalExpense()
    }
}
//  TransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Emre Mert on 4.12.2024.
//

