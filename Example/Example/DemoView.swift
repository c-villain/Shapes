import SwiftUI

struct DemoView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    BubbleDemo()
                }, label: {
                    Text("Bubbles")
                })
                
                NavigationLink(destination: {
                    WavedTabView()
                }, label: {
                    Text("Waved tab view")
                })
                
                NavigationLink(destination: {
                    RoundedDemo()
                }, label: {
                    Text("Rounded corners")
                })
                
                NavigationLink(destination: {
                    DiamondDemo()
                }, label: {
                    Text("Diamond")
                })
            }
            .navigationBarTitle(Text("Menu"))
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoView()
    }
}
