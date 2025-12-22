//
//  WorkoutEvent.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import Foundation

struct WorkoutEvent: Identifiable, Codable, Hashable {
    let id: UUID?
    let date: Date?
    let title: String?
    let type: String?
    let duration: Int? // minutes
    let distance: Double? // km
    let heartRateData: [Int]?
}
