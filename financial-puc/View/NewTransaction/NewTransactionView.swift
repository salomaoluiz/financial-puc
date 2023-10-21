//
//  NewTransactionView.swift
//  financial-puc
//
//  Created by Salomão Luiz de Araújo Neto on 25/09/23.
//

import SwiftUI

struct NewTransactionView: View {
    @State var id: UUID? = nil
    @State var description = ""
    @State var valueString = ""
    @State var date = Date()
    @State var selectedCategory: Category?
    @State var isEditing: Bool = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var transactionViewModel = TransactionViewModel()
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Description", text: $description)
                    TextField("Value", text: $valueString)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    
                    Picker("Category", selection: $selectedCategory) {
                        Text("Select").tag(nil as Category?).frame(width: 400)
                        ForEach(categories, id: \.self) { category in
                            HStack {
                                Text(category.name ?? "")
                                if category.type == CategoryType.expense.rawValue {
                                    Image(systemName: "arrow.down.circle.fill")
                                    
                                } else {
                                    Image(systemName: "arrow.up.circle.fill")
                                    
                                }
                            }
                            .tag(category as Category?)
                        }
                    }
                }
                Section {
                    Button(action: {
                        if (isEditing == true) {
                            editTransaction()
                        }else {
                            saveTransaction()
                        }
                    }) {
                        Text("Save Transaction")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            
        }
        .navigationBarTitle( isEditing ? "Edit Transaction" : "New Transaction")
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func isValidTransaction () -> Bool {
        guard Double(valueString) != nil else {
            showAlert(message: "The value field is invalid")
            return false
        }
        guard selectedCategory != nil else {
            showAlert(message: "Select a category")
            return false
        }
        guard description != "" else {
            showAlert(message: "Add a description")
            return false
        }
        
        return true
        
    }
    
        private func editTransaction() {
            if(!isValidTransaction()) {return}
            guard id != nil else {
                showAlert(message: "The ID is unavailable")
                return
            }
            
            let newTransaction = TransactionStruct(
                id: id!,
                description: description,
                value: Double(valueString) ?? 0,
                date: date,
                categoryID: selectedCategory?.id ?? UUID(),
                categoryName: selectedCategory?.name ?? ""
            )
            
            transactionViewModel.editTransaction(transaction: newTransaction)
            
            presentationMode.wrappedValue.dismiss()
        }
    
        private func saveTransaction() {
            
            
            let newTransaction = TransactionStruct(
                id: UUID(),
                description: description,
                value: Double(valueString) ?? 0,
                date: date,
                categoryID: selectedCategory?.id ?? UUID(),
                categoryName: selectedCategory?.name ?? ""
            )

            transactionViewModel.saveTransaction(transaction: newTransaction)
            
            presentationMode.wrappedValue.dismiss()
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        isShowingAlert = true
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
