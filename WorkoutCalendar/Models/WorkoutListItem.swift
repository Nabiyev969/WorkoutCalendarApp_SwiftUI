//
//  WorkoutListItem.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation

struct WorkoutListItem: Identifiable, Codable, Hashable {
    let workoutKey: String
    let workoutActivityType: String
    let workoutStartDate: String

    var id: String { workoutKey }

    var startDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: workoutStartDate) ?? Date()
    }
}
