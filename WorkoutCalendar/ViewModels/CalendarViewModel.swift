//
//  CalendarViewModel.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import Foundation
import Combine

final class CalendarViewModel: ObservableObject {
    
    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date = Date()
    @Published var workouts: [WorkoutEvent] = []
    
    private let service: WorkoutServiceProtocol
    private let calendar = Calendar.current
    
    init(service: WorkoutServiceProtocol = MockWorkoutService()) {
        self.service = service
        self.workouts = service.fetchWorkouts()
    }
    
    func goToNextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
    }
    
    func goToPreviousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
    }

    func daysInMonth() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let monthDays = calendar.range(of: .day, in: .month, for: currentMonth)
        else { return [] }

        return monthDays.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: monthInterval.start)
        }
    }
    
    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
    func isSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    func hasWorkout(on date: Date) -> Bool {
        workouts.contains {
            calendar.isDate($0.date ?? Date(), inSameDayAs: date)
        }
    }
    
    func workoutsForSelectedDay() -> [WorkoutEvent] {
        workouts.filter {
            calendar.isDate($0.date ?? Date(), inSameDayAs: selectedDate)
        }
    }
    
    func monthTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: currentMonth)
    }
}
