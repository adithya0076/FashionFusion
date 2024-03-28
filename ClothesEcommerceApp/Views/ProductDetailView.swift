import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @State private var quantity = 1
    @State var selectedSize: String = "M"
    @State var goTOCart = false
    let sizes = ["S", "M", "L"]
    @State private var showAlert = false

    let product: Product
    
    var body: some View {
        
        var totalPrice: Double {
            if let priceValue = Double(product.price) {
                return priceValue * Double(quantity)
            } else {
                return 0
            }
        }
        
        VStack{
            
            ZStack{
                ScrollView{
                    Color(.white)
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(alignment: .leading){
                        AnimatedImage(url: URL(string: product.image))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(40)
                            .frame(width: 400,height: 400)
                            .clipped()
                            
                    VStack(alignment: .leading){
                        Text(product.category)
                            .opacity(0.5)
                            .font(.subheadline)
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Colour : "+product.color)
                        
            
                    }
                    .padding()
                    .background(Color.white)
 
                    HStack{
                        Text("Size : ")
                        HStack(spacing: 10) {
                            ForEach(sizes, id: \.self) { size in
                                Button(action: {
                                    selectedSize = size
                                    print(selectedSize)
                                }) {
                                    Text(size)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(selectedSize == size ? .white : .black)
                                        .padding(.all, 10)
                                        .background(selectedSize == size ? Color.orange : Color.white)
                                        .cornerRadius(8)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.orange, lineWidth: selectedSize != size ? 2 : 0)
                                        )
                                        .font(.subheadline)
                                }
                                
                            }
                        }
                        
                    }.padding(.horizontal, 50)
    
                        
                    HStack{
                        Text("Qty : ")
                        HStack(spacing: 10) {
                            HStack{
                                
                                Button(action: {
                                    if quantity > 1 {
                                            quantity -= 1
                                    }
                                    
                                }){
                                    Image(systemName: "minus")
                                        .padding(.all,8)
                                }
                                .frame(width: 30,height: 30)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                                .foregroundStyle(.orange)
                                
                                
                                Text("\(quantity)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                
                                Button(action: {
                                    quantity += 1
                                }){
                                    Image(systemName: "plus")
                                        .padding(.all,8)
                                }
                                .frame(width: 30,height: 30)
                                .background(Color(.orange))
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                                
                                    
                            }.padding(.horizontal)
                        }
                        
                    }.padding(.horizontal, 50)
                    VStack {
                        Text("LKR \(totalPrice, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                    }.padding(.horizontal, 50)
                    Spacer()
                    Spacer()
                    
                   

                    VStack(alignment: .leading){
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom,10)
                        Text(product.description)
                            .italic()
                            .opacity(0.8)
                            .font(.subheadline)
                    }.padding(.horizontal)
                            .padding(.vertical)
                        
                }
                
                .padding(.top, -20)
                .padding(.bottom,100)

            }
            HStack {
                HStack {}
                Spacer()
                
                Button(action: {
                    goTOCart = true
                    let newItem = CartItem(cartId: UUID(),pid: product.id, name: product.name, price: totalPrice, quantity: quantity, imageURL: product.image,size: selectedSize,eachPrice: product.price)
                        cartItems.append(newItem)
                        showAlert = true
                }, label: {
                    Text("Add to Cart")
                })
                .padding()
                .padding(.horizontal, 100)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Success"), message: Text("Item added to cart successfully"), dismissButton: .default(Text("OK")))
                }
                Spacer()
                HStack {}
            }
            .background(Color.white)
            .frame(maxHeight: .infinity,alignment: .bottom)
        }
    }
    .navigationBarTitleDisplayMode(.inline)
    .onChange(of: goTOCart) { newValue in
            if newValue {
                quantity = 1
                selectedSize = "M"
                goTOCart = false
            }
        }
    }
    
  
}


