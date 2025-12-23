//
//  WorkoutDetailsViewModel.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import Foundation
import Combine

final class WorkoutDetailsViewModel: ObservableObject {

    @Published var metadata: WorkoutMetadata?
    @Published var diagramData: [WorkoutDiagramPoint] = []

    private let service = MockWorkoutDetailsService()
    private let workoutKey: String

    init(workoutKey: String) {
        self.workoutKey = workoutKey
        load()
    }

    private func load() {
        metadata = service.fetchMetadata(workoutKey: workoutKey)
        diagramData = service.fetchDiagramData(workoutKey: workoutKey)
    }
}
