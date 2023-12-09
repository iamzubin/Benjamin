import SwiftUI

struct AssetChartView: View {
    let data: [Double]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Path
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    let xStep = width / CGFloat(data.count - 1)
                    let yScale = height / CGFloat((data.max() ?? 1) - (data.min() ?? 0))

                    if let firstDataPoint = data.first {
                        path.move(to: CGPoint(x: 0, y: height - CGFloat(firstDataPoint) * yScale))
                    }

                    for index in 1..<data.count {
                        let x = CGFloat(index) * xStep
                        let y = height - CGFloat(data[index]) * yScale
                        let prevX = CGFloat(index - 1) * xStep
                        let prevY = height - CGFloat(data[index - 1]) * yScale

                        let control1 = CGPoint(x: prevX + xStep / 2, y: prevY)
                        let control2 = CGPoint(x: prevX + xStep / 2, y: y)

                        path.addCurve(to: CGPoint(x: x, y: y), control1: control1, control2: control2)
                    }

                    // Close the path to form a loop
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                }
                .fill(LinearGradient(gradient: Gradient(colors: [lineColor().opacity(0.2), lineColor().opacity(0)]), startPoint: .top, endPoint: .bottom))

                // Line Chart Path
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    let xStep = width / CGFloat(data.count - 1)
                    let yScale = height / CGFloat((data.max() ?? 1) - (data.min() ?? 0))

                    if let firstDataPoint = data.first {
                        path.move(to: CGPoint(x: 0, y: height - CGFloat(firstDataPoint) * yScale))
                    }

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
    }

    private func lineColor() -> Color {
        if (data.first ?? 0 >= data.last ?? 0) {
            return .red
        } else {
            return .green
        }
    }
}

struct AssetChartView_Previews: PreviewProvider {
    static var previews: some View {
        AssetChartView(data: [20, 18, 14, 16, 10, 11, 12, 16, 18,  16, 14, 12, 13])
            .frame(width: 300, height: 200)
            .padding()
    }
}
