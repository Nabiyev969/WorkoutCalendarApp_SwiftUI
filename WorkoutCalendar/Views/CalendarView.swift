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
                    coordinator.showWorkoutDetails(workout)
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(workout.title ?? "")
                            .font(.headline)
                        
                        Text("\(workout.type ?? "") • \(workout.duration ?? 0) min • \(workout.distance ?? 0, specifier: "%.1f") km")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: WorkoutEvent.self) { workout in
            WorkoutDetailsView(workout: workout)
        }
    }
}

#Preview {
    CalendarView()
}
