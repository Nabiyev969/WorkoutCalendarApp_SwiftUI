//
//  MockWorkoutService.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import Foundation

struct WorkoutListResponse: Codable {
    let data: [WorkoutListItem]
}

final class MockWorkoutService {

    func fetchWorkoutList() -> [WorkoutListItem] {
        guard
            let url = Bundle.main.url(forResource: "list_workouts", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(WorkoutListResponse.self, from: data)
        else {
            return []
        }

        return response.data
    }
}
