import SwiftUI

public extension View {
    func waved(corner: CGFloat = 0,
               height: CGFloat = 25,
               startX: CGFloat,
               length: CGFloat = 120) -> some View {
        return clipShape(Wave.init(corner: corner,
                                   height: height,
                                   startX: startX,
                                   length: length))
    }
}
