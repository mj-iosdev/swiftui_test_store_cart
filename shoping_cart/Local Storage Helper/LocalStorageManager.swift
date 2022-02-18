//
//  LocalStorageManager.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import Foundation

let StorageManager = LocalStorageManager.shared

var kCART_DATA = "CART_DATA"

class LocalStorageManager: NSObject {
    
    static let shared = LocalStorageManager()

    func storeProductData(data: ProductListModelClass) {
        if let cartData =  (UserDefaults.standard.value(forKey: kCART_DATA) as? String) {
            var productFound = false
            if(!cartData.isEmpty) {
                do {
                    var cardDataArray = ProductListModelClass.parseProductListArray(dataArray: ( try! JSONSerializer.toArray(cartData) ))
                                    
                    for item in cardDataArray {
                        if(data.id == item.id) {
                            productFound = true
                            item.cartCount = item.cartCount + 1
                            break
                        }
                    }
                    
                    if(!productFound) {
                        data.cartCount = 1
                        cardDataArray.append(data)
                    }
                    
                    let json = JSONSerializer.toJson(cardDataArray)
                    UserDefaults.standard.setValue(json, forKey: kCART_DATA)
                } catch  {
                    print(error)
                }
            }
            else {
                self.storeFirstProduct(data: data)
            }
            
        } else {
            self.storeFirstProduct(data: data)
        }
        
    }
    
    func storeFirstProduct(data: ProductListModelClass) {
        data.cartCount = 1
        let json = JSONSerializer.toJson([data])
        UserDefaults.standard.setValue(json, forKey: kCART_DATA)

    }
    
    func updateCardData(data: ProductListModelClass) {
        if let cartData =  (UserDefaults.standard.value(forKey: kCART_DATA) as? String) {
            do {
                var cardDataArray = ProductListModelClass.parseProductListArray(dataArray: ( try! JSONSerializer.toArray(cartData) ))
                var index = 0
                for item in cardDataArray {
                    
                    if(data.id == item.id) {
                        if(data.cartCount == 0) {
                            cardDataArray.remove(at: index)
                        } else {
                            item.cartCount = data.cartCount
                        }
                        break
                    }
                    index += 1
                }
                
                                
                let json = JSONSerializer.toJson(cardDataArray)
                UserDefaults.standard.setValue(json, forKey: kCART_DATA)
            } catch  {
                print(error)
            }
            
        } else {
            data.cartCount = 1
            let json = JSONSerializer.toJson([data])
            UserDefaults.standard.setValue(json, forKey: kCART_DATA)
        }
    }
    
    func getCartData() -> [ProductListModelClass]{
        if let cartData =  (UserDefaults.standard.value(forKey: kCART_DATA) as? String) {
            if(!cartData.isEmpty ) {
                let cardDataArray = ProductListModelClass.parseProductListArray(dataArray: ( try! JSONSerializer.toArray(cartData) ))
                return cardDataArray
            } else {
                return [ProductListModelClass]()
            }
        } else {
            return [ProductListModelClass]()
        }
    }
    
    func getCartTotal() -> Int {
        var totalCount = 0
        if let cartData =  (UserDefaults.standard.value(forKey: kCART_DATA) as? String) {
            if(!cartData.isEmpty ) {
                let cardDataArray = ProductListModelClass.parseProductListArray(dataArray: ( try! JSONSerializer.toArray(cartData) ))
                
                for item in cardDataArray {
                    totalCount += item.cartCount
                }
                return totalCount

            }
            return 0

        } else {
            return 0
        }
    }
}
