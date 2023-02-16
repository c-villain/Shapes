import SwiftUI
import Shapes

struct DiamondDemo: View {
    
    // Top point:
    @State var topX: CGFloat = 0
    @State var topY: CGFloat = 0
    
    // Bottom point:
    @State var bottomX: CGFloat = 0
    @State var bottomY: CGFloat = 0
    
    @State var strokeColor: Color = .black
    @State var strokeWidth: CGFloat = 2
    @State var fillColor: Color = .yellow
    
    @State var foregroundColor: Color = .black
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                
                Text("Diamond modifier")
                    .foregroundColor(foregroundColor)
                    .padding(24)
                    .diamond(top: .init(x: topX, y: topY),
                               bottom: .init(x: bottomX, y: bottomY),
                               withStroke: strokeColor,
                               lineWidth: strokeWidth,
                               fill: fillColor)
                
                VStack {
                    
                    Text("Top point")
                    
                    HStack {
                        Text("x-offset: \(Int(topX))")
                        Slider(value: $topX, in: -100...100)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("y-offset: \(Int(topY))")
                        Slider(value: $topY, in: -100...100)
                            .accentColor(.yellow)
                    }
                    
                    Text("Bottom point:")
                    
                    HStack {
                        Text("x-offset: \(Int(bottomX))")
                        Slider(value: $bottomX, in: -100...100)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("y-offset: \(Int(bottomY))")
                        Slider(value: $bottomY, in: -100...100)
                            .accentColor(.yellow)
                    }
                    
                    if #available(iOS 14.0, *) {
                        ColorPicker("Border color", selection: $strokeColor)
                    }
                    
                    HStack {
                        Text("Border width: \(Int(strokeWidth))")
                        Slider(value: $strokeWidth, in: 0...20)
                            .accentColor(.yellow)
                    }
                    
                    if #available(iOS 14.0, *) {
                        ColorPicker("Fill color", selection: $fillColor)
                    }
                    
                    if #available(iOS 14.0, *) {
                        ColorPicker("Foreground color", selection: $foregroundColor)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

public struct DiamondDemo_Previews: PreviewProvider {
    public static var previews: some View {
        DiamondDemo()
    }
}
