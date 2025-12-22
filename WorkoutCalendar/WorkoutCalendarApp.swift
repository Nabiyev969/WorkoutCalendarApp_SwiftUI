//
//  WorkoutCalendarApp.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

@main
struct WorkoutCalendarApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                CalendarView()
                    .environmentObject(coordinator)
            }
        }
    }
}
