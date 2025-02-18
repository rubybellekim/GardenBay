//
//  CheckoutView.swift
//  GardenBay
//
//  Created by Ruby Kim on 2025-02-13.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @ObservedObject var addressList: AddressList
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var httpRequestSent = false
    @State private var showingError = false
    @State private var errorAlert = ""
    @State private var isOrderConfirmed = false
    
    @Binding var path: NavigationPath  // Binding to modify the navigation path
    
        
    var body: some View {
        
        ScrollView {
            VStack {
                VStack {
                    Text("Checkout for")
                        .font(Themes.bodyFont)
                        .multilineTextAlignment(.center)
                    
                    Text("\(order.name)")
                        .font(Themes.bodyFont)
                        .foregroundStyle(Themes.primary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                AsyncImage(url: URL(string: "https://adeleraeflorist.com/cdn/shop/products/lily-flower-bouquet-delivery-vancouver-adelerae__57833_2048x_crop_center.jpg?v=1674694835"), scale: 5) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .cornerRadius(15.0)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "CAD"))")
                    .font(Themes.titleFont)
                    .padding()
                
                Text("Address: \(order.streetAddress), \(order.city), \(order.zip)")
                    .font(Themes.bodyFont)
                    .padding()
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                        httpRequestSent = true
                    }
                }
                .padding(.top, 30)
                .buttonStyle(Buttons())
                
                Button("Back To Main Page") {
//                    path.removeLast(path.count)
                    path = NavigationPath()
//                    ContentView()
                }
                .font(Themes.bodyFont)
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {
                addressList.addOrder(order)
                isOrderConfirmed = true
                //                    path.removeLast(path.count)
                //                    path = NavigationPath()
                
            }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Something went wrong.", isPresented: $showingError) {
            Button("Cancel") {
            }
        } message: {
            Text(errorAlert)
        }
        .sheet(isPresented: $isOrderConfirmed) {
            OrderCompleteView(path: $path)
        }
        .tint(Color(Themes.primary)) // Use a custom color from Assets
    }
    
        func placeOrder() async {
            guard let encoded = try? JSONEncoder().encode(order) else {
                print("Failed to encode order")
                return
            }
            
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST" //quoted this out when check internet connection error
            
            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                confirmationMessage = "Your order for '\(Order.types[decodedOrder.type].uppercased())' is on its way!"
                showingConfirmation = true
                httpRequestSent = true
                
            } catch {
                showingError = true
                errorAlert = "Try to check your internet connection."
                print("Check out failed: \(error.localizedDescription)")
            }
        }
    }




#Preview {
    CheckoutView(order: Order(), addressList: AddressList(), path: .constant(NavigationPath()))
}

