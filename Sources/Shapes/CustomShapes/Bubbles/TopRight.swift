import SwiftUI

public struct BubbleTopRight: Shape {

    var cornerRadius: CGFloat = 0.0
    var tail: (width: CGFloat, height: CGFloat) = (6, 17)
    
    public func path(in rect: CGRect) -> Path {
        Path { path in

            let rectDime = min(rect.height, rect.width)
            let pathRadius = cornerRadius >= rectDime / 2 ? rectDime / 2 : cornerRadius
            let pathTail: (width: CGFloat, height: CGFloat) = (tail.width, tail.height > rect.height ? rect.height : tail.height)
            
            // init point
            path.move(to: CGPoint(x: rect.width/2, y: rect.height))
            
            // bottom line:
            path.addLine(to: .init(x: rect.width - pathRadius,
                                   y: rect.height))
            
            // calculating the apex:
            let delta = rect.height - pathTail.height
            
            if delta > pathRadius {
                // add round corner on bottom right:
                path.addQuadCurve(to: CGPoint(x: rect.width,
                                              y: rect.height - pathRadius),
                                  control: CGPoint(x: rect.width,
                                                   y: rect.height))
                
                // right line:
                path.addLine(to: .init(x: rect.width,
                                       y: (pathTail.width > 0 ? pathTail.height : pathRadius)))
                
            } else {
                path.addQuadCurve(to: CGPoint(x: rect.width,
                                              y: rect.height - delta),
                                  control: CGPoint(x: rect.width,
                                                   y: rect.height))
            }
            
            // tail:
            if pathTail.width > 0 {
                path.addCurve(to: CGPoint(x: rect.width + pathTail.width,
                                          y: rect.minY),
                              control1: CGPoint(x: rect.width,
                                                y: rect.minY),
                              control2: CGPoint(x: pathTail.width > 0 ? rect.width + 2 * pathTail.width : rect.width,
                                                y: rect.minY))
                
                path.addQuadCurve(to: CGPoint(x: rect.width - pathRadius / 3,
                                              y: pathTail.width > 0 ? pathRadius / (3 * tan (45.0)) : rect.minY),
                                  control: CGPoint(x: rect.width,
                                                   y: rect.minY))
            }
            
            //add round corner top right:
            path.addQuadCurve(to: CGPoint(x: rect.width - pathRadius,
                                          y: rect.minY),
                              control: CGPoint(x: pathTail.width > 0 ? rect.width - pathRadius / 2 : rect.width,
                                               y: rect.minY))
            
            // top line
            path.addLine(to: .init(x: pathRadius,
                                   y: rect.minY))
            
            //add round corner top left:
            path.addQuadCurve(to: CGPoint(x: rect.minX,
                                          y: pathRadius),
                              control: CGPoint(x: rect.minX,
                                               y: rect.minY))
            
            //left line
            path.addLine(to: .init(x: rect.minX,
                                   y: rect.height - pathRadius))
            
            //add round corner top left:
            path.addQuadCurve(to: CGPoint(x: pathRadius,
                                          y: rect.height),
                              control: CGPoint(x: rect.minX,
                                               y: rect.height))
            
            path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        }
    }
}

struct BubbleTopRight_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hi!\nHow ur doing?")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    BubbleTopRight(cornerRadius: 0, tail: (width: 10, height: 15))
                        .stroke(.gray, lineWidth: 2)
                )
            
            HStack(alignment: .bottom) {
                Text("Hi!")
                Text("18:21")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .offset(y: 4)
            }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    BubbleTopRight(cornerRadius: 17, tail: (width: 6, height: 10))
                        .stroke(.gray, lineWidth: 1)
                )
            Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus")
                .padding(12)
                .background(
                    BubbleTopRight(cornerRadius: 0, tail: (width: 10, height: 15))
                        .stroke(.gray, lineWidth: 1)
                )
            
            Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.")
                .padding(12)
                .background(
                    BubbleTopRight(cornerRadius: 17, tail: (width: 6, height: 10))
                        .stroke(.gray, lineWidth: 1)
                )
        }
        .padding(20)
    }
}
