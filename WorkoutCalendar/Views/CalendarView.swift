//
//  CalendarView.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject private var viewModel = CalendarViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Button(action: {
                    withAnimation {
                        viewModel.goToPreviousMonth()
                    }
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(viewModel.monthTitle())
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.goToNextMonth()
                    }
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.daysInMonth(), id: \.self) { date in
                    DayView(
                        date: date,
                        isSelected: viewModel.isSelected(date),
                        isToday: viewModel.isToday(date),
                        hasWorkout: viewModel.hasWorkout(on: date)
                    )
                    .onTapGesture {
                        viewModel.selectedDate = date
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            List(viewModel.workoutsForSelectedDay()) { workout in
                Button {
                    coordinator.showWorkoutDetails(workout.workoutKey)
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(workout.workoutActivityType)
                            .font(.headline)
                        
                        Text(workout.startDate.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: String.self) { key in
            WorkoutDetailsView(workoutKey: key)
        }
    }
}

#Preview {
    CalendarView()
}
