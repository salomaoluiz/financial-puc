//
//  ContentView.swift
//  financial-puc
//
//  Created by Salomão Luiz de Araújo Neto on 25/09/23.
//

import SwiftUI
import CoreData

struct HomeView: View {

    var body: some View {
        NavigationView {
            VStack {
                // First Card (Transactions)
                NavigationLink(destination: TransactionsView()) { // Implement navigation here
                    CardView(title: "Transactions", color: .blue)
                }
                .buttonStyle(PlainButtonStyle()) // Make the card tappable

                // Second Card (Categories)
                NavigationLink(destination: CategoryView()) { // Implement navigation here
                    CardView(title: "Categories", color: .green)
                }
                .buttonStyle(PlainButtonStyle()) // Make the card tappable
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1).ignoresSafeArea())

        }
    }
}

struct CardView: View {
    let title: String
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(width: 200, height: 100)
                .shadow(radius: 5)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
