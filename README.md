WorkoutCalendar is a lightweight iOS calendar application built with SwiftUI that displays workout events using mock server data.
The app demonstrates clean architecture, modern SwiftUI navigation, and testable business logic.

Tech Stack: Swift, 
            SwiftUI, 
            MVVM + Coordinator, 
            Combine, 
            XCTest(Unit)

Requirements: iOS 16.6

Features:	Monthly calendar view,
          Navigate between months, 
          Highlight(today, selected day, days with workouts), 
          Workout list for selected day, 
          Workout details screen(type, duration, distance), 
          Heart rate chart built with SwiftUI, 
          Navigation handled via Coordinator, 
          Mock data layer simulating server responses.

Unit tests cover: Unit tests cover calendar logic, workout filtering, JSON parsing, and navigation logic.
