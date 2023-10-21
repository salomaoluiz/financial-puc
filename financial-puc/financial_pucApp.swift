//
//  financial_pucApp.swift
//  financial-puc
//
//  Created by Salomão Luiz de Araújo Neto on 25/09/23.
//

import SwiftUI

@main
struct financial_pucApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
