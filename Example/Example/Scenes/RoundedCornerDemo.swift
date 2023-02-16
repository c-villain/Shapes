import SwiftUI
import Shapes

struct RoundedDemo: View {
    
    @State var topLeft: CGFloat = 20
    @State var topRight: CGFloat = 20
    @State var bottomLeft: CGFloat = 20
    @State var bottomRight: CGFloat = 20
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("Corner radius modifier")
                    .foregroundColor(.white)
                    .padding(24)
                    .background (
                        Color.blue
                            .cornerRadius(topLeft, corners: .topLeft)
                            .cornerRadius(topRight, corners: .topRight)
                            .cornerRadius(bottomLeft, corners: .bottomLeft)
                            .cornerRadius(bottomRight, corners: .bottomRight)
                    )
                
                VStack {
                    HStack {
                        Text("Top left: \(Int(topLeft))")
                        Slider(value: $topLeft, in: 0...100)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Top right: \(Int(topRight))")
                        Slider(value: $topRight, in: 0...100)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Bottom left: \(Int(bottomLeft))")
                        Slider(value: $bottomLeft, in: 0...100)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Bottom right: \(Int(bottomRight))")
                        Slider(value: $bottomRight, in: 0...100)
                            .accentColor(.yellow)
                    }
                }
            }
            .padding(24)
        }
    }
}

public struct RoundedDemo_Previews: PreviewProvider {
    public static var previews: some View {
        RoundedDemo()
    }
}
