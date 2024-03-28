import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @State private var totalPrice = 0.00
    @State private var subTotal = 0.0
    @State private var shippingCost = 0.0
    @State private var totalWithShipping = 0.0
    @State private var showAlert = false
    @State private var promo: String = ""
    var body: some View {
        VStack(alignment: .center) {
            Text("Shopping Cart")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(width: 360) // Adjust width as needed
        }
        NavigationView {
            List {
                ForEach(cartItems, id: \.cartId) { item in
                    HStack {
                        AnimatedImage(url: URL(string: item.imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 60)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                                .font(.system(size: 12))
                            
                            Text("LKR \(String(format: "%.2f", item.price))")
                                .font(.system(size: 12))
                            HStack{
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text("\(item.quantity)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    )
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text("\(item.size)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    )
                            }
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
            VStack(alignment: .center) {
                
                    Text("Payment")
                        .font(.title2)
                        .fontWeight(.bold)
                HStack{
            
                    Text("COD")
                        .font(.headline)
                        .font(.system(size: 12))
                        .padding(10)
                }.frame(maxWidth: .infinity)
                    .padding(.trailing, 8)
                    .background(Color.gray)
                    .cornerRadius(10)
                    
                TextField("Promo Code", text: $promo)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 2)
                    )
                   
               
                    Text("Total")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("LKR \(String(format: "%.2f", totalWithShipping))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                
              
            }
            .padding(.bottom, 60)
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
