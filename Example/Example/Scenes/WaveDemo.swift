import SwiftUI
import Shapes

enum TabType: Int {
    case person = 0
    case search = 1
    case chat = 2
    case phone = 3
    case settings = 4
}

struct Tab: Identifiable, Equatable {
    let id: Int
    let type: TabType
    let imageName: String
    let color: Color
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

/**
 This extension is needed because of deprecating edgesignoringsafearea for iOS 13.0–15.2
 https://developer.apple.com/documentation/swiftui/menu/edgesignoringsafearea(_:)
 */
public extension View {
    @ViewBuilder
    func expandViewOutOfSafeArea(_ edges: Edge.Set = .all) -> some View {
        if #available(iOS 14, *) {
            self.ignoresSafeArea(edges: edges)
        } else {
            self.edgesIgnoringSafeArea(edges) // deprecated for iOS 13.0–15.2, look upper
        }
    }
}

struct WavedTabView: View {
    
    @State var tabs: [Tab] = [.init(id: 1, type: .person, imageName: "person", color: Color.yellow.opacity(0.6)),
                              .init(id: 2, type: .search, imageName: "magnifyingglass", color: Color.orange.opacity(0.6)),
                              .init(id: 3, type: .chat, imageName: "bubble.left", color: Color.pink.opacity(0.6)),
                              .init(id: 4, type: .phone, imageName: "phone", color: Color.green.opacity(0.6))]
    
    
    @State var selectedTab: TabType = .person
    
    @State var waveX: CGFloat = 0
    
    //Constants:
    
    @State var waveLength: CGFloat = 120
    @State var waveHeight: CGFloat = 25
    @State var tabBarHeight: CGFloat = 50
    @State var hPaddingIn: CGFloat = 35 // horizontal padding inside tab view
    @State var cornerRadius: CGFloat = 0
    @State var hPaddingOut: CGFloat = 0 // horizontal padding outside tab view
    @State var offset: CGFloat = 10
    @State var selectedOffset: CGFloat = -15
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Color.yellow
                    .opacity(0.3)
                    .expandViewOutOfSafeArea()
                    .tag(TabType.person)
                
                Color.orange
                    .opacity(0.3)
                    .expandViewOutOfSafeArea()
                    .tag(TabType.search)
                
                Color.pink
                    .opacity(0.3)
                    .expandViewOutOfSafeArea()
                    .tag(TabType.chat)
                
                Color.green
                    .opacity(0.3)
                    .expandViewOutOfSafeArea()
                    .tag(TabType.phone)
            }
            .zIndex(0)
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Wave length: \(Int(waveLength))")
                        Slider(value: $waveLength, in: 80...(UIDevice.isIPad ? 200 : 140))
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Wave height: \(Int(waveHeight))")
                        Slider(value: $waveHeight, in: -50...50)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Tab bar height: \(Int(tabBarHeight))")
                        Slider(value: $tabBarHeight, in: 10...90)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Padding inside tab view: \(Int(hPaddingIn))")
                        Slider(value: $hPaddingIn, in: 14...(UIDevice.isIPad ? 100 : 35))
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Padding outside tab view: \(Int(hPaddingOut))")
                        Slider(value: $hPaddingOut, in: 0...(UIDevice.isIPad ? 100 : 20))
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Corner radius for tab view: \(Int(cornerRadius))")
                        Slider(value: $cornerRadius, in: 0...40)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Buttons offset: \(Int(offset))")
                        Slider(value: $offset, in: -40...40)
                            .accentColor(.yellow)
                    }
                    
                    HStack {
                        Text("Selected button offset: \(Int(selectedOffset))")
                        Slider(value: $selectedOffset, in: -40...40)
                            .accentColor(.yellow)
                    }
                    
                    Button("Refresh values to defaults") {
                        waveLength = 120
                        waveHeight = 25
                        tabBarHeight = 50
                        hPaddingIn = 35
                        cornerRadius = 0
                        hPaddingOut = 0
                        offset = 10
                        selectedOffset = -15
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .padding(8)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                }
                .padding()
                .frame(maxHeight: .infinity)
            }
            .zIndex(1)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.id) { tab in
                    GeometryReader { proxy in
                        Button(action: {
                            withAnimation(.linear) {
                                selectedTab = tab.type
                                waveX = proxy.frame(in: .global).midX - hPaddingOut
                            }
                        }, label: {
                            ZStack {
                                Circle()
                                    .fill( selectedTab == tab.type ? tab.color : .clear)
                                    .frame(width: 50.0, height: 50.0)
                                    .zIndex(1)
                                Image(systemName: tab.imageName)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(width: 25.0, height: 25.0)
                                    .zIndex(2)
                            }
                        })
                        .frame(height: 50.0)
                        .frame(idealWidth: 50.0)
                        .offset(x: 0, y: selectedTab == tab.type ? selectedOffset : 0)
                        .onAppear {
                            guard selectedTab == tab.type else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                waveX = proxy.frame(in: .global).midX - hPaddingOut
                            }
                        }
                    }
                    .frame(width: 50.0, height: 50.0)
                    if tab != tabs.last { Spacer() }
                }
                .offset(y: offset)
            }
            .frame(height: tabBarHeight)
            .padding(.horizontal, hPaddingIn)
            .padding(.vertical, 24)
            .background(
                Color.black.opacity(0.8)
                    .waved(corner: cornerRadius,
                           height: waveHeight,
                           startX: waveX,
                           length: waveLength)
            )
            .padding(.bottom, 51)
            .padding(.horizontal, hPaddingOut)
            .zIndex(2)
        }
        .expandViewOutOfSafeArea(.bottom)
    }
}

struct WavedTabView_Previews: PreviewProvider {
    static var previews: some View {
        WavedTabView()
    }
}
