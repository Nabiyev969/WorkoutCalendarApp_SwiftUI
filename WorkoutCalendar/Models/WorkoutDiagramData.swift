//
//  WorkoutDiagramData.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation

struct WorkoutDiagramRoot: Codable {
    let workouts: [String: WorkoutDiagramWorkout]
}

struct WorkoutDiagramWorkout: Codable {
    let data: [WorkoutDiagramPoint]
}

struct WorkoutDiagramPoint: Codable, Hashable {
    let time_numeric: Int
    let heartRate: Int
    let speed_kmh: Double
}
