import SwiftUI

public extension Shape {
    func style<S: ShapeStyle, F: ShapeStyle>(
        withStroke strokeContent: S,
        lineWidth: CGFloat = 1,
        fill fillContent: F ) -> some View {
            self
                .stroke(strokeContent, lineWidth: lineWidth)
                .background(fill(fillContent))
        }
}


public extension Bubble {
    func custom<S: ShapeStyle,
                F: ShapeStyle> (
                    withStroke strokeContent: S = Color.primary,
                    lineWidth: CGFloat = 2,
                    fill fillContent: F = Color.blue) -> some View {
                        Bubble.init(type: type,
                                    cornerRadius: cornerRadius,
                                    tail: tail,
                                    tailPosition: tailPosition)
                        .stroke(strokeContent, lineWidth: lineWidth)
                        .background(fill(fillContent))
                    }
}

public extension View {
    func bubble<S: ShapeStyle,
                F: ShapeStyle>(_ type: MessageType = .send,
                               cornerRadius: CGFloat = 17,
                               tail: (width: CGFloat, height: CGFloat) = (6, 17),
                               tailPosition: TailPosition = .bottom,
                               withStroke strokeContent: S = Color.primary,
                               lineWidth: CGFloat = 2,
                               fill fillContent: F = Color.blue) -> some View {
        return self.background(
            Bubble.init(type: type,
                        cornerRadius: cornerRadius,
                        tail: tail,
                        tailPosition: tailPosition)
            .custom(withStroke: strokeContent,
                    lineWidth: lineWidth,
                    fill: fillContent)
        )
    }
}

struct BubbleModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("Custom bubble ✌🏻 \nLeading")
                .foregroundColor(.white)
                .padding(16)
                .bubble(.received,
                        withStroke: .clear,
                        lineWidth: 2,
                        fill: .black.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Custom bubble ✌🏻\nTrailing")
                .foregroundColor(.white)
                .padding(16)
                .bubble(.send,
                        withStroke: .clear,
                        lineWidth: 2,
                        fill: LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.9), .blue.opacity(0.6)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(20)
    }
}
