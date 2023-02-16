import SwiftUI

public struct Diamond: Shape {
    
    var top: CGPoint = .init(x: 0, y: 0)
    var bottom: CGPoint = .init(x: 0, y: 0)
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            // get the center of the rect
            let center = CGPoint(x: rect.midX, y: rect.midY)
            // get the starting of our drawing the right side of our diamond
            let startingPoint = CGPoint(x: rect.maxX, y: center.y)
            // move our start of drawing to the beggining point
            path.move(to: startingPoint)
            // distance / 2 is our height
            // create all our points
            let secondPoint = CGPoint(x: center.x + bottom.x, y: rect.maxY + bottom.y)
            let thirdPoint = CGPoint(x: rect.minX , y: center.y)
            let fourthPoint = CGPoint(x: center.x + top.x, y: rect.minY + top.y)
            path.addLine(to: secondPoint)
            path.addLine(to: thirdPoint)
            path.addLine(to: fourthPoint)
            path.addLine(to: startingPoint)
        }
    }
}

public struct Diamond_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 40) {
            Text("Diamond")
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(
                    Diamond()
                        .stroke(.blue, lineWidth: 2)
                )
            
            Diamond()
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)
        }
    }
}
