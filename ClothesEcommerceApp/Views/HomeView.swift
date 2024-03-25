import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            ScrollView{
                VStack(alignment:.leading){
                    AppBarView()
                    
                    Text("Find the best clothes!")
                        .font(.custom("", size: 30))
                        .padding(.horizontal)
                        .padding(.vertical)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AppBarView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image("profile")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(50)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
            }
            .frame(width: 30, height: 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image("logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 84)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "cart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
            .frame(width: 30, height: 30)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
        }
        .padding(.horizontal)
    }
}



struct TabViewBar: View {
    var body: some View {
        TabView {
            HomeView()
                .badge(10)
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            CartView()
                .tabItem(){
                    Image(systemName: "cart")
                    Text("Cart")
                }
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
    }
}
