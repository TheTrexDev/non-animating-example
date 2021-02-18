//
//  non_animating_exampleApp.swift
//  non animating example
//
//  Created by James Warren on 19/2/21.
//

import SwiftUI

@main
struct non_animating_exampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
