import SwiftUI

public struct Wave: Shape {
    
    var corner: CGFloat // for corner radius
    var height: CGFloat // height of wave
    
    //for wave:
    var startX: CGFloat
    var length: CGFloat
    
    public init(
        corner: CGFloat = 0,
        height: CGFloat = 25,
        startX: CGFloat = 180,
        length: CGFloat = 120
    ) {
        self.corner = corner
        self.height = height
        self.startX = startX
        self.length = length
    }
    
    public var animatableData: CGFloat {
        get { startX }
        set { startX = newValue }
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // points:
        let startPoint: CGFloat = (startX - (length / 2) <= corner) ? corner : startX - (length / 2)
        let midPoint: CGFloat = startX
        
        let apex1: CGFloat = midPoint - (length / 4)
        let apex2: CGFloat = midPoint + (length / 4)
        
        // init point
        path.move(to: .init(x: corner, y: height))
        
        // line to wave start
        path.addLine(to: .init(x: startPoint, y: height))
        
        // add wave on top:
        
        path.addCurve(to: CGPoint(x: midPoint,
                                  y: rect.minY),
                      control1: CGPoint(x: apex1,
                                        y: height),
                      control2: CGPoint(x: apex1, y: rect.minY))
        
        let finalPoint: CGFloat
        if midPoint + (length / 2) >= (rect.width - corner) {
            finalPoint  = rect.width - corner
        } else {
            finalPoint = midPoint + (length / 2)
        }

        path.addCurve(to: CGPoint(x: finalPoint,
                                  y: height),
                      control1: CGPoint(x: apex2,
                                        y: rect.minY),
                      control2: CGPoint(x: apex2,
                                        y: height))

        // line from end wave to end
        path.addLine(to: .init(x: rect.width - corner,
                               y: height))
        
        //add round corner on top right:
        path.addQuadCurve(to: CGPoint(x:rect.width,
                                      y: height + corner),
                          control: CGPoint(x: rect.width,
                                           y: height))
        
        // right line:
        path.addLine(to: .init(x: rect.width,
                               y: rect.height - corner))
        
        //add round corner bottom right:
        path.addQuadCurve(to: CGPoint(x: rect.width - corner,
                                      y: rect.height),
                          control: CGPoint(x: rect.width,
                                           y: rect.height))
        
        // bottom line
        path.addLine(to: .init(x: corner,
                               y: rect.height))
        
        //add round corner bottom left:
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.height - corner),
                          control: CGPoint(x: rect.minX,
                                           y: rect.height))
        
        //left line
        path.addLine(to: .init(x: rect.minX,
                               y: height + corner))

        //add round corner top left:
        path.addQuadCurve(to: CGPoint(x: corner,
                                      y: height),
                          control: CGPoint(x: rect.minX,
                                           y: height))

        return path
    }
}

public struct Wave_Previews: PreviewProvider {
    public static var previews: some View {
        Color.black.opacity(0.8)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .clipShape(Wave())
    }
}
