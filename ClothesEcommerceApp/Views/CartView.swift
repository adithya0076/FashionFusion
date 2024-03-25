import SwiftUI

struct CartView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1 Content")
                .tabItem {
                    Image(systemName: "house")
                    Text("Tab 1")
                }
                .tag(0)
            
            Text("Tab 2 Content")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Tab 2")
                }
                .tag(1)
            
            Text("Tab 3 Content")
                .tabItem {
                    Image(systemName: "person")
                    Text("Tab 3")
                }
                .tag(2)
        }
        .accentColor(.blue) // Change the color of the selected tab item
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
