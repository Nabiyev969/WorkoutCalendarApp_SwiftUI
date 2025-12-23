//
//  MockWorkoutDetailsService.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation

final class MockWorkoutDetailsService {
    
    func fetchMetadata(workoutKey: String) -> WorkoutMetadata? {
        guard
            let url = Bundle.main.url(forResource: "metadata", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(WorkoutMetadataResponse.self, from: data)
        else { return nil }
        
        return response.workouts[workoutKey]
    }
    
    func fetchDiagramData(workoutKey: String) -> [WorkoutDiagramPoint] {
        guard
            let url = Bundle.main.url(forResource: "diagram_data", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(WorkoutDiagramRoot.self, from: data),
            let workout = response.workouts[workoutKey]
        else {
            return []
        }
        
        return workout.data
    }
}
