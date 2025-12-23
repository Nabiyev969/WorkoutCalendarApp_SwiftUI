//
//  WorkoutCalendarXCTests.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 24.12.25.
//

import XCTest
@testable import WorkoutCalendar
internal import SwiftUI

final class CalendarViewModelTests: XCTestCase {
    
    var sut: CalendarViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CalendarViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialState() {
        
        XCTAssertNotNil(sut.currentMonth)
        XCTAssertNotNil(sut.selectedDate)
        XCTAssertFalse(sut.workouts.isEmpty, "Should load workouts from mock service")
    }
    
    func testGoToNextMonth() {

        let initialMonth = sut.currentMonth
        let calendar = Calendar.current
        
        sut.goToNextMonth()
        
        let monthDifference = calendar.dateComponents([.month], from: initialMonth, to: sut.currentMonth).month
        XCTAssertEqual(monthDifference, 1)
    }
    
    func testGoToPreviousMonth() {

        let initialMonth = sut.currentMonth
        let calendar = Calendar.current
        
        sut.goToPreviousMonth()
        
        let monthDifference = calendar.dateComponents([.month], from: initialMonth, to: sut.currentMonth).month
        XCTAssertEqual(monthDifference, -1)
    }
    
    func testDaysInMonth() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 1
        sut.currentMonth = calendar.date(from: components)!
        
        let days = sut.daysInMonth()
        
        XCTAssertEqual(days.count, 30, "November 2025 should have 30 days")
    }
    
    func testIsToday() {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        
        XCTAssertTrue(sut.isToday(today))
        XCTAssertFalse(sut.isToday(yesterday))
    }
    
    func testIsSelected() {
        let testDate = Date()
        sut.selectedDate = testDate
        let otherDate = Calendar.current.date(byAdding: .day, value: 1, to: testDate)!
        
        XCTAssertTrue(sut.isSelected(testDate))
        XCTAssertFalse(sut.isSelected(otherDate))
    }
    
    func testHasWorkout() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 25
        let dateWithWorkout = calendar.date(from: components)!
        
        components.day = 1
        let dateWithoutWorkout = calendar.date(from: components)!
        
        XCTAssertTrue(sut.hasWorkout(on: dateWithWorkout))
        XCTAssertFalse(sut.hasWorkout(on: dateWithoutWorkout))
    }
    
    func testWorkoutsForSelectedDay() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 25
        sut.selectedDate = calendar.date(from: components)!
        
        let workouts = sut.workoutsForSelectedDay()
        
        XCTAssertEqual(workouts.count, 2, "Should have 2 workouts on Nov 25, 2025")
        XCTAssertTrue(workouts.contains { $0.workoutKey == "7823456789012345" })
        XCTAssertTrue(workouts.contains { $0.workoutKey == "7823456789012346" })
    }
    
    func testMonthTitle() {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 15
        sut.currentMonth = calendar.date(from: components)!
        
        let title = sut.monthTitle()
        
        XCTAssertTrue(title.contains("2025"))
        XCTAssertTrue(title.lowercased().contains("november") || title.contains("11"))
    }
}

final class WorkoutDetailsViewModelTests: XCTestCase {
    
    var sut: WorkoutDetailsViewModel!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitWithValidWorkoutKey() {
        let workoutKey = "7823456789012345"
        
        sut = WorkoutDetailsViewModel(workoutKey: workoutKey)
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))
        
        XCTAssertNotNil(sut.metadata)
        XCTAssertEqual(sut.metadata?.workoutKey, workoutKey)
        XCTAssertEqual(sut.metadata?.workoutActivityType, "Walking/Running")
        XCTAssertFalse(sut.diagramData.isEmpty)
    }
    
    func testInitWithInvalidWorkoutKey() {
        let invalidKey = "invalid_key_12345"
        
        sut = WorkoutDetailsViewModel(workoutKey: invalidKey)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))
        
        XCTAssertNil(sut.metadata)
        XCTAssertTrue(sut.diagramData.isEmpty)
    }
    
    func testDiagramDataLoading() {
        let workoutKey = "7823456789012345"
        
        sut = WorkoutDetailsViewModel(workoutKey: workoutKey)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))
        
        XCTAssertGreaterThan(sut.diagramData.count, 0)
        
        // Verify first data point
        let firstPoint = sut.diagramData.first!
        XCTAssertEqual(firstPoint.time_numeric, 0)
        XCTAssertEqual(firstPoint.heartRate, 72)
        XCTAssertEqual(firstPoint.speed_kmh, 0.0)
    }
}

final class MockWorkoutServiceTests: XCTestCase {
    
    var sut: MockWorkoutService!
    
    override func setUp() {
        super.setUp()
        sut = MockWorkoutService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchWorkoutList() {
        let workouts = sut.fetchWorkoutList()
        
        XCTAssertEqual(workouts.count, 9, "Should load 9 workouts from JSON")
    }
    
    func testWorkoutListContainsExpectedData() {
        let workouts = sut.fetchWorkoutList()
        
        let firstWorkout = workouts.first!
        XCTAssertEqual(firstWorkout.workoutKey, "7823456789012345")
        XCTAssertEqual(firstWorkout.workoutActivityType, "Walking/Running")
        XCTAssertEqual(firstWorkout.workoutStartDate, "2025-11-25 09:30:00")
    }
    
    func testWorkoutListItemDateParsing() {
        let workouts = sut.fetchWorkoutList()
        let firstWorkout = workouts.first!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: firstWorkout.startDate)
        
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 25)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.minute, 30)
    }
}

final class MockWorkoutDetailsServiceTests: XCTestCase {
    
    var sut: MockWorkoutDetailsService!
    
    override func setUp() {
        super.setUp()
        sut = MockWorkoutDetailsService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchMetadataWithValidKey() {
        let workoutKey = "7823456789012345"
        
        let metadata = sut.fetchMetadata(workoutKey: workoutKey)
        
        XCTAssertNotNil(metadata)
        XCTAssertEqual(metadata?.workoutKey, workoutKey)
        XCTAssertEqual(metadata?.workoutActivityType, "Walking/Running")
        XCTAssertEqual(metadata?.distance, "5230.50")
        XCTAssertEqual(metadata?.duration, "2700.00")
        XCTAssertEqual(metadata?.comment, "Утренняя пробежка в парке")
    }
    
    func testFetchMetadataWithInvalidKey() {
        let invalidKey = "invalid_key"
        
        let metadata = sut.fetchMetadata(workoutKey: invalidKey)
        
        XCTAssertNil(metadata)
    }
    
    func testFetchDiagramDataWithValidKey() {
        let workoutKey = "7823456789012345"
        
        let diagramData = sut.fetchDiagramData(workoutKey: workoutKey)
        
        XCTAssertFalse(diagramData.isEmpty)
        XCTAssertEqual(diagramData.count, 21)
        
        let firstPoint = diagramData.first!
        XCTAssertEqual(firstPoint.time_numeric, 0)
        XCTAssertEqual(firstPoint.heartRate, 72)
        XCTAssertEqual(firstPoint.speed_kmh, 0.0)
    }
    
    func testFetchDiagramDataWithInvalidKey() {
        let invalidKey = "invalid_key"
        
        let diagramData = sut.fetchDiagramData(workoutKey: invalidKey)
        
        XCTAssertTrue(diagramData.isEmpty)
    }
    
    func testDiagramDataOrdering() {
        let workoutKey = "7823456789012345"
        
        let diagramData = sut.fetchDiagramData(workoutKey: workoutKey)
        
        for i in 0..<diagramData.count - 1 {
            XCTAssertLessThan(diagramData[i].time_numeric, diagramData[i + 1].time_numeric,
                            "Diagram data should be ordered by time_numeric")
        }
    }
}

final class WorkoutModelTests: XCTestCase {
    
    func testWorkoutListItemIdentifiable() {
        let item = WorkoutListItem(
            workoutKey: "123",
            workoutActivityType: "Running",
            workoutStartDate: "2025-11-25 09:30:00"
        )
        
        XCTAssertEqual(item.id, "123")
    }
    
    func testWorkoutListItemDateParsing() {
        let item = WorkoutListItem(
            workoutKey: "123",
            workoutActivityType: "Running",
            workoutStartDate: "2025-11-25 09:30:00"
        )
        
        let date = item.startDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 25)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.minute, 30)
    }
    
    func testWorkoutListItemInvalidDateParsing() {
        let item = WorkoutListItem(
            workoutKey: "123",
            workoutActivityType: "Running",
            workoutStartDate: "invalid-date"
        )
        
        let date = item.startDate
        
        XCTAssertNotNil(date)
    }
    
    func testWorkoutDiagramPointEquality() {
        let point1 = WorkoutDiagramPoint(time_numeric: 0, heartRate: 72, speed_kmh: 5.0)
        let point2 = WorkoutDiagramPoint(time_numeric: 0, heartRate: 72, speed_kmh: 5.0)
        let point3 = WorkoutDiagramPoint(time_numeric: 1, heartRate: 72, speed_kmh: 5.0)
        
        XCTAssertEqual(point1, point2)
        XCTAssertNotEqual(point1, point3)
    }
    
    func testWorkoutMetadataDecoding() throws {
        let json = """
        {
            "workoutKey": "123",
            "workoutActivityType": "Running",
            "workoutStartDate": "2025-11-25 09:30:00",
            "distance": "5000.0",
            "duration": "1800.0",
            "comment": "Great workout"
        }
        """
        let data = json.data(using: .utf8)!
        
        let metadata = try JSONDecoder().decode(WorkoutMetadata.self, from: data)
        
        XCTAssertEqual(metadata.workoutKey, "123")
        XCTAssertEqual(metadata.workoutActivityType, "Running")
        XCTAssertEqual(metadata.distance, "5000.0")
        XCTAssertEqual(metadata.duration, "1800.0")
        XCTAssertEqual(metadata.comment, "Great workout")
    }
}

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = AppCoordinator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialPathIsEmpty() {
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    func testShowWorkoutDetails() {
        let workoutKey = "7823456789012345"
        
        sut.showWorkoutDetails(workoutKey)
        
        XCTAssertEqual(sut.path.count, 1)
    }
    
    func testMultipleNavigations() {
        sut.showWorkoutDetails("key1")
        sut.showWorkoutDetails("key2")
        
        XCTAssertEqual(sut.path.count, 2)
    }
}
