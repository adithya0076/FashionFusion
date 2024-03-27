import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @State private var totalPrice = 0.00
    @State private var subTotal = 0.0
    @State private var shippingCost = 0.0
    @State private var totalWithShipping = 0.0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Shopping Cart")
                .font(.system(size: 44))
                .fontWeight(.bold)
                .frame(width: 360, alignment: .leading)
        }
        NavigationView {
            List {
                ForEach(cartItems, id: \.cartId) { item in
                    HStack {
                        AnimatedImage(url: URL(string: item.imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text("Price: \(String(format: "%.2f", item.price))")
                            Text("Quantity: \(item.quantity)")
                            Text("Size: \(item.size)")
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 8)
                        .background(Color.white)
                    }
                    .background(Color.white)
                    .padding(.vertical, 5)
                }
                .onDelete(perform: deleteItem)
            }
            .background(Color.white)
        }
        .background(Color.white)
        Divider()
        
        ZStack {
            VStack {
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text("LKR \(String(format: "%.2f", subTotal))")
                        .italic()
                }
                .padding()
                
                HStack {
                    Text("Shipping")
                    Spacer()
                    Text("LKR \(String(format: "%.2f", shippingCost))")
                        .italic()
                }
                .padding()
                
                HStack {
                    Text("Total")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("LKR \(String(format: "%.2f", totalWithShipping))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                .padding()
            }
            .padding(.bottom, 50)
            .padding(.horizontal, 12)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Buy Now")
                    }
                    .padding()
                    .padding(.horizontal, 100)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Success"), message: Text("Purchase Successful"), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                }
                .background(Color.white)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .onAppear(perform: calculateTotalPrice)
    }
    
    private func calculateTotalPrice() {
        subTotal = 0.0
        for item in cartItems {
            let itemPrice = Double(item.price)
            subTotal += itemPrice * Double(item.quantity)
        }
        
        shippingCost = subTotal > 0 ? 300.0 : 0.0 // Shipping cost is 300 if subtotal > 0, else 0
        totalWithShipping = subTotal + shippingCost
    }
    
    private func deleteItem(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
        calculateTotalPrice()
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
