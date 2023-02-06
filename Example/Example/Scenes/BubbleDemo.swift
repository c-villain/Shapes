import SwiftUI
import Shapes

struct BubbleDemo: View {
    
    @State var text: String = "Custom bubble"
    
    @State var type: MessageType = .send
    @State var cornerRadius: CGFloat = 17
    @State var tailWidth: CGFloat = 6
    @State var tailHeight: CGFloat = 17
    @State var tailPosition: TailPosition = .bottom
    @State var strokeColor: Color = .black
    @State var strokeWidth: CGFloat = 2
    @State var fillColor: Color = .yellow
    @State var foregroundColor: Color = .black
    @State var backgroundColor: Color = .green.opacity(0.2)
    
    @State var goToChatDemo: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Text(text)
                    .foregroundColor(foregroundColor)
                    .padding(16)
                    .bubble(type,
                            cornerRadius: cornerRadius,
                            tail: (tailWidth, tailHeight),
                            tailPosition: tailPosition,
                            withStroke: strokeColor,
                            lineWidth: strokeWidth,
                            fill: fillColor
                    )
                
                VStack(spacing: 8) {
                    Group {
                        Picker("Type", selection: $type) {
                            Text("Send").tag(MessageType.send)
                            Text("Received").tag(MessageType.received)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        HStack {
                            Text("Corner radius: \(Int(cornerRadius))")
                            Slider(value: $cornerRadius, in: 0...40)
                                .accentColor(.yellow)
                        }
                        
                        HStack {
                            Text("Tail width: \(Int(tailWidth))")
                            Slider(value: $tailWidth, in: 0...40)
                                .accentColor(.yellow)
                        }
                        
                        HStack {
                            Text("Tail height: \(Int(tailHeight))")
                            Slider(value: $tailHeight, in: 0...100)
                                .accentColor(.yellow)
                        }
                        
                        Picker("Position", selection: $tailPosition) {
                            Text("Top").tag(TailPosition.top)
                            Text("Bottom").tag(TailPosition.bottom)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
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
                        
                        if #available(iOS 14.0, *) {
                            ColorPicker("Background color", selection: $backgroundColor)
                        }
                    }

                    if #available(iOS 14.0, *) {
                        VStack(spacing: 8) {
                            Text("Enter the text:")
                            ZStack {
                                TextEditor(text: $text)
                                Text(text).opacity(0)
                                    .padding(8)
                            }
                            .shadow(radius: 1.0)
                        }
                    }
                    
                    NavigationLink(
                        destination: Chat(
                            chatConfig: Config(radius: cornerRadius,
                                               tailWidth: tailWidth,
                                               tailHeight: tailHeight,
                                               strokeColor: strokeColor,
                                               strokeWidth: strokeWidth,
                                               fillColor: fillColor,
                                               foregroundColor: foregroundColor,
                                               backgroundColor: backgroundColor,
                                               tailPosition: tailPosition)),
                        tag: 1,
                        selection: $goToChatDemo) {
                            Button(action: {
                                goToChatDemo = 1
                            }) {
                            Text("View in chat demo!")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(16)
                                .background(Color.orange.opacity(0.5))
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(backgroundColor)
        .navigationBarTitle(Text("Customize bubble"), displayMode: .inline)
        .expandViewOutOfSafeArea(.bottom)
    }
}
