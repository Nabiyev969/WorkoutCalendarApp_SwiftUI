//
//  MockWorkoutService.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import Foundation

protocol WorkoutServiceProtocol {
    func fetchWorkouts() -> [WorkoutEvent]
}

final class MockWorkoutService: WorkoutServiceProtocol {
    
    func fetchWorkouts() -> [WorkoutEvent] {
        return [
            WorkoutEvent(
                id: UUID(), date: Date(), title: "Morning Run", type: "Running", duration: 45, distance: 7.2, heartRateData: [120, 125, 130, 128, 135]
            )
        ]
    }
}
