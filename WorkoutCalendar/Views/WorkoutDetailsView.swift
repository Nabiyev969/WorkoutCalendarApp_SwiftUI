//
//  WorkoutDetailsView.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

struct WorkoutDetailsView: View {

    let workout: WorkoutEvent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text(workout.title ?? "")
                    .font(.largeTitle)
                    .bold()

                infoRow(title: "Type", value: workout.type ?? "")
                infoRow(title: "Duration", value: "\(workout.duration) min")
                infoRow(title: "Distance", value: "\(workout.distance, default: "%.1f") km")

                if let heartRate = workout.heartRateData {
                    Divider()
                    Text("Heart Rate")
                        .font(.headline)

                    HeartRateChartView(data: heartRate)
                        .frame(height: 200)
                }
            }
            .padding()
        }
        .navigationTitle("Workout Details")
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .bold()
        }
    }
}
