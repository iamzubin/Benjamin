import SwiftUI

struct SmoothLineChartView: View {
    let data: [Double]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // Calculate the horizontal step and vertical scale
                let xStep = width / CGFloat(data.count - 1)
                let yScale = height / CGFloat((data.max() ?? 1) - (data.min() ?? 0))

                // Start drawing from the first data point
                if let firstDataPoint = data.first {
                    path.move(to: CGPoint(x: 0, y: height - CGFloat(firstDataPoint) * yScale))
                }

                // Draw lines with smooth curves
                for index in 1..<data.count {
                    let x = CGFloat(index) * xStep
                    let y = height - CGFloat(data[index]) * yScale
                    let prevX = CGFloat(index - 1) * xStep
                    let prevY = height - CGFloat(data[index - 1]) * yScale

                    let control1 = CGPoint(x: prevX + xStep / 2, y: prevY)
                    let control2 = CGPoint(x: prevX + xStep / 2, y: y)

                    path.addCurve(to: CGPoint(x: x, y: y), control1: control1, control2: control2)
                }
            }
            .stroke(lineColor(), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }

    private func lineColor() -> Color {
        if let firstDataPoint = data.first, firstDataPoint >= 0 {
            return .green
        } else {
            return .red
        }
    }
}

struct SmoothLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        SmoothLineChartView(data: [3, -5, 8, -3, 12])
            .frame(width: 300, height: 200)
            .padding()
    }
}
