//
//  CalendarViewModelTests.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 23.12.25.
//

import XCTest
@testable import WorkoutCalendar

final class CalendarViewModelTests: XCTestCase {

    var viewModel: CalendarViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CalendarViewModel(service: MockWorkoutServiceTests())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testWorkoutsForSelectedDay_ReturnsOnlySelectedDayWorkouts() {
        
        let today = Date()
        viewModel.selectedDate = today

        let workouts = viewModel.workoutsForSelectedDay()

        XCTAssertEqual(workouts.count, 1)
        XCTAssertEqual(workouts.first?.title, "Today Run")
    }

    func testGoToNextMonth_IncreasesMonth() {
        
        let currentMonth = viewModel.currentMonth

        viewModel.goToNextMonth()

        let calendar = Calendar.current
        let diff = calendar.dateComponents([.month], from: currentMonth, to: viewModel.currentMonth).month
        XCTAssertEqual(diff, 1)
    }

    func testGoToPreviousMonth_DecreasesMonth() {
        
        let currentMonth = viewModel.currentMonth

        viewModel.goToPreviousMonth()

        let calendar = Calendar.current
        let diff = calendar.dateComponents([.month], from: viewModel.currentMonth, to: currentMonth).month
        XCTAssertEqual(diff, 1)
    }
}
