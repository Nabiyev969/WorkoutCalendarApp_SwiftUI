//
//  DayView.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

struct DayView: View {

    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let hasWorkout: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text(dayNumber())
                .font(.body)
                .fontWeight(isToday ? .bold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill(isSelected ? Color.blue : Color.clear)
                )

            if hasWorkout {
                Circle()
                    .fill(Color.red)
                    .frame(width: 6, height: 6)
            }
        }
    }

    private func dayNumber() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
