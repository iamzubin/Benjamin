import Foundation
import Combine

class HomeViewModel: ObservableObject {
    // Properties representing the data needed for the home view
    @Published var userAddress: String = ""
    @Published var walletBalances: [String: String] = [:]

    // Function to fetch token balances for the given user address
    func fetchTokenBalances(for userAddress: String) {

        // Perform the API request to get token balances (use the getTokenBalances function from the previous example)
        getTokenBalances(for: userAddress) { result in
            switch result {
            case .success(let walletBalances):
                // Update the view model's data
                self.walletBalances = walletBalances.walletBalances

            case .failure(let error):
                // Handle the error, e.g., display an error message
                print("Error fetching token balances: \(error)")
            }
        }
    }
}
