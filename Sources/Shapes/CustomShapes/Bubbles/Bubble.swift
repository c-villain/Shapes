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
    
    var type: MessageType = .send
    var cornerRadius: CGFloat = 0.0
    
    var tail: (width: CGFloat, height: CGFloat) = (6, 17)
    var tailPosition: TailPosition = .bottom
    
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
