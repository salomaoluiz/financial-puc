import SwiftUI

struct TransactionComponent: View {
    let transaction: TransactionStruct
    let onNavigate: () -> Void
    var body: some View {
        Button(action: {
            onNavigate()
        }) {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.description)
                    .font(.headline)
                
                Text("Value: \(transaction.value)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Date: \(formattedDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Category: \(transaction.categoryName)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                
                
            }
            
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
    
        }
            .cornerRadius(10)
            .shadow(radius: 2)
        }.buttonStyle(PlainButtonStyle())
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: transaction.date)
    }
}

struct TransactionComponent_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTransaction = TransactionStruct(
            id: UUID(),
            description: "Sample Expense",
            value: 100.0,
            date: Date(),
            categoryID: UUID(),
            categoryName: "Expense"
        )

        return TransactionComponent(transaction: sampleTransaction, onNavigate: {})
            .previewLayout(.sizeThatFits)
    }
}
