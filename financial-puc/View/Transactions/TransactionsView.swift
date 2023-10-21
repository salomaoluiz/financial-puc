//
//  TransactionsView.swift
//  financial-puc
//
//  Created by Salomão Luiz de Araújo Neto on 25/09/23.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject private var viewModel = TransactionViewModel()
    @State private var selectedTransaction: TransactionStruct?
    @State private var selectedCategory: Category?
    @State private var isEditingTransaction = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.transactions) { transaction in
                    TransactionComponent(transaction: transaction) {
                        navigateToNewTransactionView(transaction: transaction)

                    }
                }.onDelete(perform: { indexSet in
                    withAnimation {
                        for index in indexSet {
                            viewModel.deleteTransaction(transaction: viewModel.transactions[index])
                        }
                    }
                })
                
            }.onAppear {
                viewModel.fetchTransactions()
            }
                
                  

              } .navigationBarItems(
                trailing: NavigationLink(
                    destination: NewTransactionView(
                      id: selectedTransaction?.id ?? nil,
                      description: selectedTransaction?.description ?? "",
                      valueString: selectedTransaction != nil ? String(selectedTransaction!.value) : "",
                      date: selectedTransaction?.date ?? Date(),
                      selectedCategory: selectedCategory,
                      isEditing: isEditingTransaction),
                    isActive: $isEditingTransaction
                    ) {
                  Image(systemName: "plus")
              })
          }
    
    private func navigateToNewTransactionView(transaction: TransactionStruct) {
        self.selectedTransaction = transaction
        
        self.selectedCategory = viewModel.categoryViewModel.fetchCategoriesById(id: transaction.categoryID)
        self.isEditingTransaction = true
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
