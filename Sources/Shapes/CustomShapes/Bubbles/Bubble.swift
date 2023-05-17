import SwiftUI

public enum MessageType {
    case send
    case received
}

public enum TailPosition {
    case bottom
    case top
}

public struct Bubble: Shape {
    
    var type: MessageType
    var cornerRadius: CGFloat
    
    var tail: (width: CGFloat, height: CGFloat)
    var tailPosition: TailPosition
    
    public init(
        type: MessageType = .send,
        cornerRadius: CGFloat = 0.0,
        tail: (width: CGFloat, height: CGFloat) = (6, 17),
        tailPosition: TailPosition = .bottom
    ) {
        self.type = type
        self.cornerRadius = cornerRadius
        self.tail = tail
        self.tailPosition = tailPosition
    }
    
    public func path(in rect: CGRect) -> Path {
        switch (type, tailPosition) {
        case (.send, .bottom):
            return BubbleBottomRight.init(cornerRadius: cornerRadius, tail: tail)
                .path(in: rect)
        case (.send, .top):
            return BubbleTopRight.init(cornerRadius: cornerRadius, tail: tail)
                .path(in: rect)
        case (.received, .bottom):
            return RotatedShape.init(shape: BubbleTopRight.init(cornerRadius: cornerRadius, tail: tail),
                                     angle: Angle.init(degrees: 180.0))
                .path(in: rect)
        case (.received, .top):
            return RotatedShape.init(shape: BubbleBottomRight.init(cornerRadius: cornerRadius, tail: tail),
                                     angle: Angle.init(degrees: 180.0))
                .path(in: rect)
        }
    }
}


public struct Bubble_Previews: PreviewProvider {
    public static var previews: some View {

        VStack {
            Text("Hi!")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Bubble.init(type: .send,
                                cornerRadius: 20,
                                tail: (width: 6, height: 15))
                    .stroke(.gray, lineWidth: 2)
                )
                .frame(maxWidth: .infinity,
                       alignment: .trailing)
            
            Text("Wassup!")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)

                .background(
                    Bubble.init(type: .received,
                                cornerRadius: 20,
                                tail: (width: 6, height: 15))
                    .stroke(.gray, lineWidth: 2)
                )
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }
        .padding(20)
    }
}
