
import SwiftUI

struct Tab: View {
    @EnvironmentObject var session: SessionModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            InvestView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Invest")
                }
            
            Button(action: {session.logout()}, label: {Text("Logout")})

                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            
        }
    }
}

#Preview {
    Tab()
}
