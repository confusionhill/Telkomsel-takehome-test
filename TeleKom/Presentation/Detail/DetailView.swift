//
//  DetailView.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import SwiftUI

struct DetailView: View {
    let product: ProductModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: product.productLogo)) { img in
                    img.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .leading)
                .padding()
                Text(product.productName)
                Text("by \(product.publisher)")
                Group {
                    VStack(alignment: .leading) {
                        Text(product.desc)
                            .padding(.bottom)
                        Text("Latest Version        : v\(product.latestVersion)")
                        Text("Rating                      : \(product.rating, specifier: "%.2f")")
                            .padding(.bottom, 70)
                    }
                }.padding()
                Spacer()
            }
           
        }
    }
}
