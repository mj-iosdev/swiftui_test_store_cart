//
//  ProductModelClass.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import Foundation

class ProductListModelClass: Identifiable {
    
    var id          : Int = 0
    var title       : String = "Test"
    var price       : Double = 0
    var description : String = "test Desc"
    var category    : String = ""
    var image       : String = ""
    var rating      = RatingModelClass()
    var cartCount   = 0
    
    init() {}
    
    public class func parseProductListData(dict: NSDictionary) -> ProductListModelClass{
        
        let obj             = ProductListModelClass()
        obj.id              = dict.value(forKey: "id") as? Int ?? 0
        obj.title           = dict.value(forKey: "title") as? String ?? ""
        obj.price           = dict.value(forKey: "price") as? Double ?? 0
        obj.description     = dict.value(forKey: "description") as? String ?? ""
        obj.category        = dict.value(forKey: "category") as? String ?? ""
        obj.image           = dict.value(forKey: "image") as? String ?? ""
        let objRating       = dict.value(forKey: "rating") as? NSDictionary ?? NSDictionary()
        obj.rating          = RatingModelClass.parseRatingData(dict: objRating)
        obj.cartCount       = dict.value(forKey: "cartCount") as? Int ?? 0

        return obj
    }
    
    public class func parseProductListArray(dataArray: NSArray) -> [ProductListModelClass]{
        var objProductArray = [ProductListModelClass]()
        for i in dataArray {
            let dict = i as! NSDictionary
            let obj = parseProductListData(dict: dict)
            objProductArray.append(obj)
        }
        return objProductArray
    }
}

class RatingModelClass {
    var rate    : Double = 0
    var count   : Int = 0
    
    init() {    }
    
    public class func parseRatingData(dict: NSDictionary) -> RatingModelClass {
        let obj             = RatingModelClass()
        obj.rate            = dict.value(forKey: "rate") as? Double ?? 0
        obj.count           = dict.value(forKey: "count") as? Int ?? 0
        return obj
    }
}
