//
//  InvestView.swift
//  Benjamin
//
//  Created by Sangeeta Papinwar on 09/12/23.
//

import SwiftUI

struct InvestView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                TopMarketCapView()
            }
            .navigationTitle("Discover")
        }
    }
}

struct TopMarketCapView: View {
    let data = (1...12).map { "Item \($0)" }

       let columns = [
           GridItem(.adaptive(minimum: 80)),
           GridItem(.adaptive(minimum: 80)),
           GridItem(.adaptive(minimum: 80)),
           GridItem(.adaptive(minimum: 80))
       ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Top coins by market cap")
                    .font(.subheadline)
                
                Spacer()
                
                Text("See all")
                    .foregroundStyle(.blue)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.secondary.opacity(0.1))
                
                LazyVGrid(columns: columns, spacing: 20) {
                   ForEach(data, id: \.self) { item in
                       VStack {
                           Image("bitcoin")
                               .resizable()
                               .frame(width: 55, height: 55)
                           
                           Text("BTC")
                               .padding(.top, 2)
                               .font(.system(size: 14))
                           
                           Text("▲ 13.2 %")
                               .foregroundStyle(.green)
                               .font(.system(size: 12))

                       }
                   }
               }
                .padding()
            }
            .padding(.horizontal)
        }
    }
    
}

#Preview {
    InvestView()
}
