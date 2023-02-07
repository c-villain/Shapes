import SwiftUI
import Shapes

protocol BubbleConfig {
    var cornerRadius: CGFloat { get }
    var tailWidth: CGFloat { get }
    var tailHeight: CGFloat { get }
    var strokeColor: Color { get }
    var strokeWidth: CGFloat { get }
    var fillColor: Color { get }
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
    var tailPosition: TailPosition { get }
}

class Config: BubbleConfig {
    
    var cornerRadius: CGFloat
    
    var tailWidth: CGFloat
    
    var tailHeight: CGFloat
    
    var strokeColor: Color
    
    var strokeWidth: CGFloat
    
    var fillColor: Color
    
    var foregroundColor: Color
    
    var backgroundColor: Color
    
    var tailPosition: TailPosition
    
    init(radius: CGFloat, tailWidth: CGFloat, tailHeight: CGFloat, strokeColor: Color, strokeWidth: CGFloat, fillColor: Color, foregroundColor: Color, backgroundColor: Color, tailPosition: TailPosition){
        self.cornerRadius = radius
        self.tailWidth = tailWidth
        self.tailHeight = tailHeight
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.fillColor = fillColor
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.tailPosition = tailPosition
    }
}

struct Chat: View {
    
    let chatConfig: BubbleConfig
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Group {
                        Text("Hi! What's the package with shapes for sms? 🤔")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("That you've recommended recently✌🏻")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("👋")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                        
                        Text("Shapes by Alex Kraev!")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                        
                        Text("Yeap, n1 😊")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("Don't forget to ⭐️ it!")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                        
                        Text("no pb!🫡")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("Thx!")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                        
                    }
                    Group {
                        Text("What's up?")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                        Text("Working on new project!")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("Definitely tired on the previous one...😩")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .received(chatConfig)
                        
                        Text("Hope u enjoy it!")
                            .foregroundColor(chatConfig.foregroundColor)
                            .padding(16)
                            .sended(chatConfig)
                    }
                }
                .padding(24)
                .rotationEffect(.radians(.pi))
                .scaleEffect(CGSize(width: -1, height: 1))
            }
            .padding(.top, 40)
            .padding(.bottom, 1)
            .rotationEffect(.radians(.pi))
            .scaleEffect(CGSize(width: -1, height: 1))
        }
        .background(chatConfig.backgroundColor)
        .navigationBarTitle(Text("Chat"), displayMode: .inline)
        .expandViewOutOfSafeArea(.bottom)
    }
}

extension View {
    func received(_ config: BubbleConfig) -> some View {
        self.bubble(.received,
                    cornerRadius: config.cornerRadius,
                    tail: (config.tailWidth, config.tailHeight),
                    tailPosition: config.tailPosition,
                    withStroke: config.strokeColor,
                    lineWidth: config.strokeWidth,
                    fill: .gray.opacity(0.8)
        )
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
    
    func sended(_ config: BubbleConfig) -> some View {
        self.bubble(.send,
                    cornerRadius: config.cornerRadius,
                    tail: (config.tailWidth, config.tailHeight),
                    tailPosition: config.tailPosition,
                    withStroke: config.strokeColor,
                    lineWidth: config.strokeWidth,
                    fill: config.fillColor
        )
        .frame(maxWidth: .infinity,
               alignment: .trailing)
    }
}

struct Chat_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Chat(chatConfig: Config(radius: 17,
                                tailWidth: 6,
                                tailHeight: 17,
                                strokeColor: .black,
                                strokeWidth: 2,
                                fillColor: .yellow,
                                foregroundColor: .black,
                                backgroundColor: .green.opacity(0.2),
                                tailPosition: .bottom))
        .expandViewOutOfSafeArea(.all)
    }
}
