//
//  ContentView.swift
//  lesson3
//
//  Created by Jack Xia on 04/09/2023.
//

import SwiftUI

// Privileges
enum UserLevel {
    case user
    case admin
    case employee
}



struct ProductListView: View {
    let userlvl: UserLevel
    let isAdmin: Bool
    
    // Initialize an array of type Product
    init(products: [Product], isAdmin: Bool, userlvl: UserLevel) {
        self.products = products
        self.isAdmin = isAdmin
        self.userlvl = userlvl
        self.isPresentingAddProductView = false
    }
    
    
    
    // Field needs to be self instantiated
    // @State is annotation for wiring to update the status for mutating objects
    // @@State is a short hand for
    //@Published
    //@ObservedObject
    @State var products: [Product]
    
    
    
    // self init as false
    @State var isPresentingAddProductView: Bool
    
    
    // Textfield attributes
    @State var newProductName: String = ""
    
    var body: some View {
        
        NavigationStack {
            List{
                // \.self is required if using a List to generate items
                // ForEach(products, id:  \.self){product in
                ForEach(products) { product in
                    
                    // Navigate to items
                    NavigationLink {
                        ProductDTView(product: product)
                        
                        // label is expecting view builder so we refactored the code as method
                    } label: {
                        ListItemView(product: product)
                        
                    } // label
                    
                } // foreach
                
                if isAdmin {
                    Button("Legg til produkt") {
                        let newProduct = Product.init(name: "Sokker", description: "small, yellow", price: 99)
                        let newProduct2 = Product.init(name: "test", description: "test", price: 100)
                        
                        products.append(newProduct)
                        products.append(newProduct2)
                        
                        
                        
                        isPresentingAddProductView = true
                    } // button
                } else {
                    // not admin
                    Text("Not admin")
                } // ifelse
            } // list
            .sheet(isPresented: $isPresentingAddProductView) {
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        Text("Legg til nytt produkt")
                            .font(.title)
                            .padding(30)
                        
                        
                        Spacer()
                    } // title Hstack
                    
                    // binding with $ and the value will be bound to the variable
                    TextField("Produktnavn", text: $newProductName)
                    
                    
                    Spacer()
                }
                
            }
        } // navStack
    } // body
}


// Preview has admin access to show Button logic
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(products: Product.demoProducts, isAdmin: true, userlvl: UserLevel.admin)
    }
}



// ListItemView
struct ListItemView : View {
    // Field
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("\(product.name)")
            Text(product.description)
                .foregroundColor(.gray)
        }
        .padding()
        .foregroundColor(.brown)
    }
}