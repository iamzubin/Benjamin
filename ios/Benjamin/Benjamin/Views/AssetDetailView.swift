import SwiftUI

struct AssetDetailView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HeaderAssetView()
                DetailsView()
            }
        }
    }
}

struct DetailsView: View {
    @State private var selectedOption = 0
    let options = ["Overview", "Transactions"]

    var body: some View {
        VStack {
            Picker(selection: $selectedOption, label: Text("")) {
                ForEach(options.indices, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)

            if selectedOption == 0 {
                Overview()
            } else {
                TransactionsView()

            }
        }
        .padding()
    }
}

struct TransactionsView: View {
    var body: some View {
        VStack {
            HStack {
                Text("2 Dec")
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()
            
            ForEach(0...2, id: \.self) { i in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.secondary.opacity(0.15))
                    
                    HStack {
                        Image("bitcoin")
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Buy BTC")
                                .foregroundStyle(Color("ourBlack"))
                                .font(.system(size: 16))
                            
                            Text("0.052612 tokens $12.2")
                                .foregroundStyle(.gray)
                                .font(.footnote)

                            
                            Text("11:21 am")
                                .foregroundStyle(.gray)
                                .font(.footnote)

                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("-$100.00")
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                    
                }
            }
        }
    }
}

struct Overview: View {
    var body: some View {
        VStack {
            ChartView()
            InvestmentView()
        }
    }
}

struct ListRowView: View {
    var title: String
    var description: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
            Spacer()
            Text(description)
                .font(.system(size: 14))
        }
    }
}

struct InvestmentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Investment")
                    .padding(.top, 5)
                    .font(.headline)
                Spacer()
            }

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: 90)

                VStack(spacing: 25) {
                    ListRowView(title: "Number of Shares", description: "1.3982")
                    ListRowView(title: "Value", description: "$300.54")
                }
                .padding()
                .padding(.horizontal, 2)
            }

            HStack {
                Text("Stats")
                    .padding(.top, 5)
                    .font(.headline)
                Spacer()
            }

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: 300)

                VStack(spacing: 25) {
                    ListRowView(title: "Circulation Supply", description: "$300.54")
                    ListRowView(title: "Max Supply", description: "$300.54")
                    ListRowView(title: "Total Supply", description: "$12B")
                    ListRowView(title: "Market Cap", description: "$1.3B")
                    ListRowView(title: "Fully Diluted Market Cap", description: "$1.3B")
                    ListRowView(title: "All time high", description: "$2")
                    ListRowView(title: "All time low", description: "$600")
                }
                .padding()
                .padding(.horizontal, 2)
            }
        }
    }
}

struct ChartTitle: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("$143")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }

            HStack(spacing: 3) {
                Text("-$198.45")
                Text("•")
                Text("17%")
                    .foregroundStyle(.red)
                Text("•")
                Text("Past 1 day")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
        }
    }
}

struct ChartView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.secondarySystemBackground))
                .frame(height: 300)

            VStack {
                ChartTitle()
                Spacer()
                AssetChartView(data: [3, 8, 14, 3, 0, 11, 6, 16, 18, 16, 14, 12, 13])
                    .frame(height: 150)
                    .padding(.top, 30)
                    .padding(.bottom)
            }
            .padding()
        }
    }
}

struct BuySellButton: View {
    var color: Color
    var text: String
    var icon: String
    var iconColor: Color
    var textColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(color)
                .frame(width: 80, height: 40)

            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 14))
                    .fontWeight(.medium)

                Text(text)
                    .foregroundStyle(textColor)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
            }
            .padding()
        }
    }
}

struct HeaderAssetView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Coinbase")
                    .font(.title)
                    .fontWeight(.bold)

                Text("COIN • Crypto Exchange")
                    .font(.headline)
                    .fontWeight(.regular)

                Text("Capital at risk")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .padding(.top, -2)

                HStack {
                    Button(action: { print("Tapped buy!") }) {
                        BuySellButton(color: Color(.blue), text: "Buy", icon: "plus", iconColor: .white, textColor: .white)
                    }

                    Button(action: { print("Tapped buy!") }) {
                        BuySellButton(color: .blue.opacity(0.20), text: "Sell", icon: "minus", iconColor: .blue, textColor: .blue)
                    }
                }
            }

            Spacer()

            VStack() {
                Image("bitcoin")
                    .resizable()
                    .frame(width: 60, height: 60)
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#if DEBUG
struct AssetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailView()
    }
}
#endif
