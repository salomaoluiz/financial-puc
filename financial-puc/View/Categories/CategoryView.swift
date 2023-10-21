//
//  CategoryView.swift
//  financial-puc
//
//  Created by Salomão Luiz de Araújo Neto on 25/09/23.
//

import SwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()

    var body: some View {
           NavigationView {
               VStack {
                   // Input field for category name
                   TextField("Category Name", text: $viewModel.categoryName)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding()

                   // Selector for Expense or Income
                   Picker("Category Type", selection: $viewModel.categoryType) {
                       Text("Expense").tag(CategoryType.expense)
                       Text("Income").tag(CategoryType.income)
                   }
                   .pickerStyle(SegmentedPickerStyle())
                   .padding()

                   Spacer()

                   Button("Save") {
                       viewModel.saveCategory()
                   }
                   Spacer(minLength: 16)

                   List {
                       Section(header: Text("Expenses")) {
                           ForEach(viewModel.categories.filter { $0.type == CategoryType.expense } ) { category in
                               HStack {
                                   Text(category.name)
                               }
                           }
                           
                           .onDelete(perform: { indexSet in
                               withAnimation {
                                   for index in indexSet {
                                       viewModel.deleteCategory(category: viewModel.categories[index])
                                   }
                               }
                           })

                       }
                       Section(header: Text("Incomes")) {
                           ForEach(viewModel.categories.filter { $0.type == CategoryType.income } ) { category in
                               Text(category.name).tag(category.type == CategoryType.income)
                           } .onDelete(perform: { indexSet in
                               withAnimation {
                                   for index in indexSet {
                                       viewModel.deleteCategory(category: viewModel.categories[index])
                                   }
                               }
                           }
                        )
                       }
                   }

                   }
               }.navigationTitle("Categories")

           }

}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
