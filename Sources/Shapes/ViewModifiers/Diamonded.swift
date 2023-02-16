import SwiftUI

public extension Diamond {
    func custom<S: ShapeStyle,
                F: ShapeStyle> (
                    withStroke strokeContent: S = Color.primary,
                    lineWidth: CGFloat = 2,
                    fill fillContent: F = Color.blue) -> some View {
                        Diamond.init(top: top,
                                     bottom: bottom)
                        .stroke(strokeContent, lineWidth: lineWidth)
                        .background(fill(fillContent))
                    }
}

public extension View {
    func diamond<S: ShapeStyle,
                F: ShapeStyle>(top: CGPoint = .init(x: 0, y: 0),
                               bottom: CGPoint = .init(x: 0, y: 0),
                               withStroke strokeContent: S = Color.primary,
                               lineWidth: CGFloat = 2,
                               fill fillContent: F = Color.blue) -> some View {
        return self.background(
            Diamond.init(top: top,
                         bottom: bottom)
            .custom(withStroke: strokeContent,
                    lineWidth: lineWidth,
                    fill: fillContent)
        )
    }
}

public struct DiamondedModifier_Previews: PreviewProvider {
    public static var previews: some View {
        
        Text("Diamonded modifier")
            .foregroundColor(.black)
            .padding(16)
            .diamond(withStroke: Color.orange,
                       fill: .blue)
    }
}
