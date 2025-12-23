//
//  WorkoutMetadata.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation

struct WorkoutMetadataResponse: Codable {
    let workouts: [String: WorkoutMetadata]
}

struct WorkoutMetadata: Codable, Hashable {
    let workoutKey: String
    let workoutActivityType: String
    let workoutStartDate: String
    let distance: String
    let duration: String
    let comment: String?
}
