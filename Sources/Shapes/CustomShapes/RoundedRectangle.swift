import SwiftUI

public struct RoundedRectangle: Shape {

    // corner radiuses:
    var topLeft: CGFloat
    var topRight: CGFloat
    var bottomLeft: CGFloat
    var bottomRight: CGFloat

    public init(
        topLeft: CGFloat = 0,
        topRight: CGFloat = 0,
        bottomLeft: CGFloat = 0,
        bottomRight: CGFloat = 0
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    public func path(in rect: CGRect) -> Path {

        Path { path in

            // init point
            path.move(to: CGPoint(x: rect.width/2,
                                  y: rect.minY))

            // 1/2 top line:
            path.addLine(to: CGPoint.init(x: rect.width - topRight,
                                          y: rect.minY))

            //add round corner on top right:
            path.addQuadCurve(to: CGPoint.init(x:rect.width,
                                               y: topRight),
                              control: CGPoint.init(x: rect.width,
                                                    y: rect.minY))

            // right line:
            path.addLine(to: CGPoint.init(x: rect.width,
                                   y: rect.height - bottomRight))

            //add round corner bottom right:
            path.addQuadCurve(to: CGPoint.init(x: rect.width - bottomRight,
                                          y: rect.height),
                              control: CGPoint.init(x: rect.width,
                                                    y: rect.height))

            // bottom line
            path.addLine(to: CGPoint.init(x: bottomLeft, y: rect.height))

            //add round corner bottom left:
            path.addQuadCurve(to: CGPoint(x: rect.minX,
                                          y: rect.height - bottomLeft),
                              control: CGPoint.init(x: rect.minX,
                                                    y: rect.height))

            //left line
            path.addLine(to: CGPoint.init(x: rect.minX,
                                          y: topLeft))

            //add round corner top left:
            path.addQuadCurve(to: CGPoint(x: topLeft,
                                          y: rect.minY),
                              control: CGPoint(x: rect.minX,
                                               y: rect.minY))

            // 1/2 top line:
            path.addLine(to: CGPoint.init(x: rect.width/2,
                                          y: rect.minY))
        }
    }

}

public struct RoundedRectangle_Previews: PreviewProvider {
    public static var previews: some View {
        VStack {
            RoundedRectangle(topLeft: 0, topRight: 16, bottomLeft: 16, bottomRight: 16)
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)

            RoundedRectangle(topLeft: 0, topRight: 0, bottomLeft: 16, bottomRight: 16)
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)

            RoundedRectangle(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 16)
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)

            RoundedRectangle(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 16)
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)

            RoundedRectangle(topLeft: 16, topRight: 0, bottomLeft: 0, bottomRight: 16)
                .stroke(.gray, lineWidth: 1)
                .frame(width: 100, height: 50)
        }
    }
}
