//
//  HeartRateChartView.swift
//  WorkoutCalendar
//
//  Created by Nabiyev Anar on 22.12.25.
//

import SwiftUI

struct HeartRateChartView: View {

    let data: [Int]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard data.count > 1 else { return }

                let width = geometry.size.width
                let height = geometry.size.height

                let maxValue = data.max() ?? 1
                let minValue = data.min() ?? 0
                let range = max(maxValue - minValue, 1)

                let stepX = width / CGFloat(data.count - 1)

                for index in data.indices {
                    let x = CGFloat(index) * stepX
                    let y = height - (CGFloat(data[index] - minValue) / CGFloat(range)) * height

                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.red, lineWidth: 2)
        }
    }
}
