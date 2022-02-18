//
//  APIUrls.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import Foundation

func getURL(_ endpoint: String) -> String{
    return BASE_URL + endpoint
}


var BASE_URL                    = "https://fakestoreapi.com/"

var API_GET_PRODUCT_LIST        = "products"

var API_GET_PRODUCT_DETAILS     = "products/%@"
