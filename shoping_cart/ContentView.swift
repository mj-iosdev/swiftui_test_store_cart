//
//  ContentView.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import SwiftUI

struct ContentView: View {
    
    var size = UIScreen.main.bounds.width/2
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var productListArray = [ProductListModelClass]()
    @State var cartCount: Int = 0
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    HStack(){}
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    Spacer()
                    Text("Products")
                        .fontWeight(.heavy)
                    Spacer()
                    NavigationLink(
                        destination: ProductCartDetailView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    ){
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
                Spacer()
                if self.productListArray.count > 0 {
                    ScrollView{
                        LazyVGrid(columns: gridItemLayout, spacing: 0){
                            ForEach(productListArray) { productData in
                                NavigationLink(
                                    destination: ProductDetailView(product_id: productData.id)){
                                    ProductListCell(productData: productData)
                                }
                            }
                        }
                    }
                } else {
                    Text("LOADING PRODUCTS")
                    Spacer()
                }
            }
            .onAppear(perform: {
                cartCount = LocalStorageManager.shared.getCartTotal()
                getProductListAPICall()
            })
            .navigationBarHidden(true)
            .navigationTitle("")
            
        }
    }
    
    //MARK: - API Integrations
    
    func getProductListAPICall(){
        
        ApiManager.shared.getAPICall(url: getURL(API_GET_PRODUCT_LIST), headersRequired: false, params: ["":""]) { response, isInternetAvailable in
            if isInternetAvailable {
                switch response!.result {
                case .success(let JSON):
                    if let responseArray = JSON as? NSArray {
                        self.productListArray = ProductListModelClass.parseProductListArray(dataArray: responseArray)
                    }
                case .failure(let error):
                    print("API Error: ",error)
                }
            } else {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
