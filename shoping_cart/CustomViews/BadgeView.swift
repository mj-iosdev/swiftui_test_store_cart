//
//  BadgeView.swift
//  shoping_cart
//
//  Created by Orange on 18/02/22.
//

import SwiftUI

struct BadgeView: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if count > 0 {
                Color.clear
                Text(String(count))
                    .font(.system(size: 14))
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    // custom positioning in the top-right corner
                    .alignmentGuide(.top) { $0[.bottom] }
                    .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
                    .foregroundColor(Color.white)
            }
            
        }
    }
}
