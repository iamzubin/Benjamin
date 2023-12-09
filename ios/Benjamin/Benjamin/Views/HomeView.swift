import SwiftUI

struct HomeView: View {
    // The data model for the list of investments
    @StateObject var modelData = ModelData()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        HeaderProfile()
                        
                        Card()
                        
                        HStack {
                            Text("Investments")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .padding(.horizontal)
                        
                        ForEach(modelData.investments) { investment in
                            NavigationLink(destination: AssetDetailView()) {
                                InvestmentRow(investment: investment)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
}

struct TaskRow: View {
    var body: some View {
        Text("Task data goes here")
    }
}

struct ProfileButton: View {
    var body: some View {
        // A button that shows the profile picture
        Button(action: {
            // TODO: Implement the action for the profile button
        }) {
            Image("profile")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
    }
}

struct NotificationButton: View {
    var body: some View {
        // A button that shows the profile picture
        Button(action: {
            // TODO: Implement the action for the profile button
        }) {
            Image(systemName: "bell.badge.fill")
                .resizable()
                .frame(width: 25, height: 27)
                .foregroundStyle(.gray.opacity(0.5), Color("bell"))
        }
    }
}

struct HeaderProfile: View {
    var body: some View {
        HStack {
            ProfileButton()
            
            VStack(alignment: .leading) {
                Text("Hello, Zubin")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Today 2 nov")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            NotificationButton()
        }
        .padding()
    }
}


struct InvestmentRow: View {
    // A view that shows the information of an investment
    var investment: Investment
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: investment.logo),
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 35, maxHeight: 35)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            VStack(alignment: .leading) {
                Text(investment.name)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                
                Text("\(investment.hold, specifier: "%.2f") \(investment.symbol)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 5)
            
            Spacer()
            
            SmoothLineChartView(data: [3, 0, 8, 0, 6])
                .frame(maxWidth: 50, maxHeight: 30)
        
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$ \(investment.price, specifier: "%.1f")")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                
                Text("\(investment.change, specifier: "%.2f")%")
                    .font(.system(size: 12))
                    .foregroundColor(investment.change > 0 ? .green : .red)
            }
        }
        .padding()
    }
}

struct Card: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)

                .fill(Color("card"))
                .frame(height: 170)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Total Balance")
                    
                    Spacer()
                    
                    Text("**** 36h8")
                }
                .foregroundStyle(Color("ourGray"))
                .font(.subheadline)
                .padding(.top, 5)
                
                
                Text("$ 43,000")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                
                Spacer()
                
                HStack {
                    Text("+5.67 %")
                        .foregroundStyle(.green)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: { print("Tapped buy!") }) {
                        ZStack {
                            BuySellButton(color: .yellow, text: "Add", icon: "dollarsign", iconColor: .brown, textColor: .brown)
                        }
                    }

                }
                
            }
            .padding()
            .padding(.horizontal, 5)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    HomeView(modelData: ModelData())
}
