import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            HomeViewBase()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SearchView(searchTerm: "")
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeViewBase: View {
    @ObservedObject var viewModel = ProductsViewModel()
    
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    var body: some View {
        ZStack {
            ScrollView{
                VStack(alignment:.leading){
                    AppBarView()
                    
                    Text("Find the best clothes!")
                        .font(.custom("", size: 30))
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    SearchBar()
                    
                    ScrollView {
                        LazyVGrid(columns: self.columns,spacing: 25) {
                            ForEach(viewModel.products) { product in
                                ProductTileView(product: product)
                            }
                        }
                        .padding([.horizontal,.top])
                    }
                    .navigationBarTitle("Products")
                    .onAppear {
                        viewModel.fetchProducts()
                    }
                    
                    
                }
                
            }
        }
    }
}

// Product Tile View
struct ProductTileView: View {
    @State var show = false
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                show.toggle()
            } label: {
                AnimatedImage(url: URL(string: product.image))
                    .resizable()
                    .frame(width: 150,height: 150)
                    .cornerRadius(15)
            }
            
            Text(product.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("$\(product.price)")
                .foregroundColor(.secondary)
        }
        .frame(width: 150,height: 200)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .sheet(isPresented: $show, content: {
            
            ProductDetailView(product: product)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct AppBarView: View {
    @State private var isCartViewActive = false
    @State var goTOCart = false
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
            
            Button(action: {
                goTOCart = true
            }) {
                Image(systemName: "cart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
            .frame(width: 30, height: 30)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            
            NavigationLink(destination: CartView(), isActive: $goTOCart){
                EmptyView()
            }
        }
        .padding(.horizontal)
        
    }
}

struct SearchBar: View {
    @State private var searchText: String = ""
    @State private var isTyping = false
    @State private var isSearchActive = false
    private let searchDelay = 5.0 // Adjust the delay as needed
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search clothings", text: $searchText)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onChange(of: searchText) { newValue in
                        isTyping = true
                        delaySearch()
                    }
                
                if isTyping {
                    Button(action: {
                        isSearchActive = true
                        isTyping = false
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .frame(width: 55, height: 55)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            NavigationLink(
                destination: SearchView(searchTerm: searchText),
                isActive: $isSearchActive,
                label: { EmptyView() }
            )
            .hidden()
        }
    }
    
    private func delaySearch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + searchDelay) {
            if isTyping {
                isSearchActive = true
                isTyping = false
            }
        }
    }
}


