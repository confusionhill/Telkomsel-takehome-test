//
//  HomeTBVC.swift
//  TeleKom
//
//  Created by terminal on 10/11/22.
//

import SwiftUI

struct HomeTBVC: View {
    let productName: String
    let iconUrl: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: iconUrl)) { img in
                    img.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .leading)

                Text(productName)
                Spacer()
            }
        }.padding()
    }
}
