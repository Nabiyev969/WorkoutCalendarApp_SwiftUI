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
        VStack(spacing: 6) {
            Text(dayNumber())
                .font(.subheadline)
                .fontWeight(isToday ? .semibold : .regular)
                .foregroundColor(textColor)
                .frame(width: 36, height: 36)
                .background(
                    Circle()
                        .fill(backgroundColor)
                )

            if hasWorkout {
                Circle()
                    .fill(Color.red)
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return Color.accentColor
        } else if isToday {
            return Color.accentColor.opacity(0.2)
        } else {
            return Color.clear
        }
    }
    
    private var textColor: Color {
        isSelected ? .white : .primary
    }

    private func dayNumber() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}
