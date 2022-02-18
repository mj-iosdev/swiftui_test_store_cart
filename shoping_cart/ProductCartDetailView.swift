//
//  ProductCartDetailView.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import SwiftUI

struct ProductCartDetailView: View {
    
    @Environment(\.presentationMode) var presentation
    var size = UIScreen.main.bounds.width/2
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var productListArray = [ProductListModelClass]()
    
    func cartCountUpdated()  {
        self.productListArray = LocalStorageManager.shared.getCartData()
    }
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Button {
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.black)
                            .frame(width: 15, height: 25, alignment: .center)
                    }
                    Spacer()
                    Text("Cart")
                        .fontWeight(.heavy)
                    Spacer()
                    HStack(){}
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                }
                Spacer()
                if self.productListArray.count > 0 {
                    ScrollView{
                        LazyVGrid(columns: gridItemLayout, spacing: 0){
                            ForEach(productListArray) { productData in
                                NavigationLink(
                                    destination: ProductDetailView(product_id: productData.id)){
                                    ProductListCell(productData: productData,isCartView: true, cartCountUpdated: self.cartCountUpdated)
                                }
                            }
                        }
                    }
                } else {
                    Text("NO PRODUCT IN YOUR CART")
                    Spacer()
                }
            }
            .onAppear(perform: {
                self.productListArray = LocalStorageManager.shared.getCartData()
            })
            .navigationBarTitle("") //this must be empty
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProductCartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCartDetailView()
    }
}
