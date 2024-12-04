import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TransactionViewModel()
    @State private var newTitle: String = ""
    @State private var newAmount: String = ""
    @State private var selectedType: TransactionType = .income

    var body: some View {
        NavigationView {
            VStack {
                // Gider/Gelir Ekleme Alanı
                VStack(alignment: .leading) {
                    Text("Add Transaction")
                        .font(.headline)

                    TextField("Title", text: $newTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Amount", text: $newAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)

                    Picker("Type", selection: $selectedType) {
                        Text("Income").tag(TransactionType.income)
                        Text("Expense").tag(TransactionType.expense)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Button(action: {
                        if let amount = Double(newAmount), !newTitle.isEmpty {
                            viewModel.addTransaction(title: newTitle, amount: amount, type: selectedType)
                            newTitle = ""
                            newAmount = ""
                        }
                    }) {
                        Text("Add")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                // Gider/Gelir Listesi
                List {
                    ForEach(viewModel.transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.title)
                                    .font(.headline)
                                Text(transaction.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("\(transaction.type.rawValue): \(transaction.amount, specifier: "%.2f")")
                                .foregroundColor(transaction.type == .income ? .green : .red)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTransaction)
                }

                // Toplamlar
                VStack {
                    Text("Total Income: \(viewModel.totalIncome(), specifier: "%.2f")")
                        .foregroundColor(.green)
                    Text("Total Expense: \(viewModel.totalExpense(), specifier: "%.2f")")
                        .foregroundColor(.red)
                    Text("Net Balance: \(viewModel.netBalance(), specifier: "%.2f")")
                        .font(.headline)
                }
                .padding()
            }
            .navigationTitle("Expense Tracker")
        }
    }
}
