//
//  AppCoordinator.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func showWorkoutDetails(_ workoutKey: String) {
        path.append(workoutKey)
    }
}
