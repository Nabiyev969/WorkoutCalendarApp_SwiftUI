//
//  WorkoutDetailsView.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

struct WorkoutDetailsView: View {

    @StateObject private var viewModel: WorkoutDetailsViewModel

        init(workoutKey: String) {
            _viewModel = StateObject(
                wrappedValue: WorkoutDetailsViewModel(workoutKey: workoutKey)
            )
        }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                if let meta = viewModel.metadata {
                    Text(meta.workoutActivityType)
                        .font(.largeTitle)
                        .bold()

                    infoRow(title: "Distance", value: "\(meta.distance) m")
                    infoRow(title: "Duration", value: "\(Int(Double(meta.duration) ?? 0) / 60) min")

                    if let comment = meta.comment {
                        Divider()
                        Text(comment)
                            .foregroundColor(.secondary)
                    }
                }

                if !viewModel.diagramData.isEmpty {
                    Divider()
                    Text("Heart Rate")
                        .font(.headline)

                    HeartRateChartView(
                        data: viewModel.diagramData.map { $0.heartRate }
                    )
                    .frame(height: 200)
                }
            }
            .padding()
        }
        .navigationTitle("Workout Details")
        .navigationBarTitleDisplayMode(.inline)
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
