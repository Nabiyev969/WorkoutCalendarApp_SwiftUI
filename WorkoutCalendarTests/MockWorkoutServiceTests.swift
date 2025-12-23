//
//  MockWorkoutServiceTests.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation
@testable import WorkoutCalendar

final class MockWorkoutServiceTests: WorkoutServiceProtocol {

    func fetchWorkouts() -> [WorkoutEvent] {
        let calendar = Calendar.current
        let today = Date()

        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!

        return [
            WorkoutEvent(
                id: UUID(),
                date: today,
                title: "Today Run",
                type: "Running",
                duration: 30,
                distance: 5,
                heartRateData: nil
            ),
            WorkoutEvent(
                id: UUID(),
                date: yesterday,
                title: "Yesterday Walk",
                type: "Walking",
                duration: 40,
                distance: 3,
                heartRateData: nil
            ),
            WorkoutEvent(
                id: UUID(),
                date: tomorrow,
                title: "Tomorrow Cycle",
                type: "Cycling",
                duration: 60,
                distance: 20,
                heartRateData: nil
            )
        ]
    }
}
