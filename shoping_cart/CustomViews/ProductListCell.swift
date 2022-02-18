//
//  ProductListCell.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListCell: View {
    var productData: ProductListModelClass
    var isCartView = false
    var cartCountUpdated :  (() -> Void)?

    var body: some View {
        ZStack(alignment: .center){
            VStack(alignment: .center, spacing: 0){
                if productData.image != ""{
                    WebImage(url: URL(string: productData.image))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (UIScreen.main.bounds.width/2), height: UIScreen.main.bounds.height/3.7)
                        .clipped()
                } else {
                    
                }
                VStack(alignment: .leading){
                    Text(productData.title)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .padding(EdgeInsets(top: 5, leading: 3, bottom: 3, trailing: 3))
                    Text(productData.description)
                        .lineLimit(1)
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
                
                if isCartView {
                    HStack {
                        Button {
                            productData.cartCount += 1
                            LocalStorageManager.shared.updateCardData(data: productData)
                            self.cartCountUpdated!()
                        } label: {
                            Text("+")
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                        .frame(width: (UIScreen.main.bounds.width/2)/3, height: 50)
                        .background(Color.white)
                        
                        Text("\(productData.cartCount)")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .frame(width: (UIScreen.main.bounds.width/2)/3, height: 50)
                        
                        Button {
                            productData.cartCount -= 1
                            LocalStorageManager.shared.updateCardData(data: productData)
                            self.cartCountUpdated!()
                        } label: {
                            Text("-")
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        }
                        .frame(width: (UIScreen.main.bounds.width/2)/3, height: 50)
                        .background(Color.white)
                    }
                }
                
            }
            .border(Color.gray)
        }
    }
}

struct ProductListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductListCell(productData: ProductListModelClass(), cartCountUpdated: nil)
    }
}
