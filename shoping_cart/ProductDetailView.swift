//
//  ProductDetailView.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var productData = ProductListModelClass()
    @State var product_id: Int
    @State var cartCount: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
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
                    Text("Product Details")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(
                        destination: ProductCartDetailView()){
                        ZStack{
                            Image(systemName: "cart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.black)
                                .frame(width: 25, height: 25, alignment: .center)
                                .overlay(BadgeView(count: cartCount))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                        }
                    }
                    
                    
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                Spacer()
                
                if productData.id != 0 {
                    VStack{
                        ScrollView{
                            if productData.image != ""{
                                WebImage(url: URL(string: productData.image))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (UIScreen.main.bounds.width), height: UIScreen.main.bounds.height/1.8)
                                    .clipped()
                            } else {
                                
                            }
                            VStack(alignment: .leading){
                                Text(productData.title)
                                    .fontWeight(.heavy)
                                    .padding(EdgeInsets(top: 5, leading: 3, bottom: 3, trailing: 3))
                                    .lineLimit(nil)
                                Text(productData.description)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(EdgeInsets(top: 2, leading: 3, bottom: 3, trailing: 3))
                                Text("₹ \(productData.price, specifier: "%.1f")")
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 2, leading: 3, bottom: 3, trailing: 3))
                                
                                HStack(spacing: 5){
                                    HStack(spacing: 2){
                                        Text("\(productData.rating.rate, specifier: "%.1f")")
                                            .fontWeight(.semibold)
                                        Image(systemName: "star.fill")
                                    }
                                    .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                                    
                                    Text("(\(productData.rating.count))")
                                        .foregroundColor(Color.gray)
                                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 5))
                                }
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5))
                        }
                        HStack(spacing: 0){
                            Button {
                                LocalStorageManager.shared.storeProductData(data: self.productData)
                                cartCount = LocalStorageManager.shared.getCartTotal()
                            } label: {
                                Text("ADD TO CART")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                            }
                            .frame(width: UIScreen.main.bounds.width/2, height: 50)
                            .background(Color.white)

                            Button {
                                
                            } label: {
                                Text("ORDER IT")
                                    .fontWeight(.heavy)
                            }
                            .frame(width: UIScreen.main.bounds.width/2, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                        }
                        .shadow(radius: 5)
                        
                    }
                    
                } else {
                    Text("LOADING PRODUCT")
                    Spacer()
                }
                
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            self.getProductDetailAPICall(id: product_id)
            cartCount = LocalStorageManager.shared.getCartTotal()
        })
    }
    
    //MARK: - API Integrations
    
    func getProductDetailAPICall(id: Int){
        
        ApiManager.shared.getAPICall(url: String(format: getURL(API_GET_PRODUCT_DETAILS), arguments: ["\(id)"]) , headersRequired: false, params: ["":""]) { response, isInternetAvailable in
            if isInternetAvailable {
                switch response!.result {
                case .success(let JSON):
                    if let responseDict = JSON as? NSDictionary {
                        self.productData = ProductListModelClass.parseProductListData(dict: responseDict)
                    }
                case .failure(let error):
                    print("API Error: ",error)
                }
            } else {
                
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product_id: 1)
    }
}
