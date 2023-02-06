import SwiftUI

public struct Edges: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let topLeft: Edges = .init(rawValue: 1 << 0)
    public static let topRight: Edges = .init(rawValue: 1 << 1)
    public static let bottomLeft: Edges = .init(rawValue: 1 << 2)
    public static let bottomRight: Edges = .init(rawValue: 1 << 3)
    
    public static let all: Edges = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    public static let tops: Edges = [.topLeft, .topRight]
    public static let bottoms: Edges = [.bottomLeft, .bottomRight]
    
    public static let lefts: Edges = [.topLeft, .bottomLeft]
    public static let rights: Edges = [.topRight, .bottomRight]
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: Edges) -> some View {
        
        let topLeft: CGFloat = ( corners.contains(.topLeft)
                                 || corners.contains(.lefts)
                                 || corners.contains(.all)
                                 || corners.contains(.tops) ) ? radius : 0
        
        let topRight: CGFloat = ( corners.contains(.topRight)
                                  || corners.contains(.rights)
                                  || corners.contains(.all)
                                  || corners.contains(.tops) ) ? radius : 0
        
        let bottomLeft: CGFloat = ( corners.contains(.bottomLeft)
                                    || corners.contains(.lefts)
                                    || corners.contains(.all)
                                    || corners.contains(.bottoms) ) ? radius : 0
        
        let bottomRight: CGFloat = ( corners.contains(.bottomRight)
                                     || corners.contains(.rights)
                                     || corners.contains(.all)
                                     || corners.contains(.bottoms)) ? radius : 0
        
        return clipShape( RoundedRectangle.init(topLeft: topLeft,
                                                topRight: topRight,
                                                bottomLeft: bottomLeft,
                                                bottomRight: bottomRight) )
    }
    
    func cornerRadius(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> some View {
        return clipShape( RoundedRectangle.init(topLeft: topLeft,
                                                topRight: topRight,
                                                bottomLeft: bottomLeft,
                                                bottomRight: bottomRight) )
    }
}

public struct CornerRadiusModifier_Previews: PreviewProvider {
    public static var previews: some View {
        VStack(spacing: 20) {
            VStack(spacing: 0) {
                Text("Corner radius modifier")
                    .foregroundColor(.black)
                    .padding(16)
                
                    .background (
                        Color.orange
                            .cornerRadius(20, corners: .tops)
                    )
                
                Text("Corner radius modifier")
                    .foregroundColor(.black)
                    .padding(16)
                    .background (
                        Color.purple
                            .cornerRadius(40, corners: .bottoms)
                    )
            }
            
            Text("Corner radius modifier")
                .foregroundColor(.black)
                .padding(16)
                .background (
                    Color.orange
                        .cornerRadius(20, corners: .lefts)
                )
            
            Text("Corner radius modifier")
                .foregroundColor(.black)
                .padding(16)
                .background (
                    Color.purple
                        .cornerRadius(200, corners: .topLeft)
                        .cornerRadius(200, corners: .bottomLeft)
                )
        }
    }
}
