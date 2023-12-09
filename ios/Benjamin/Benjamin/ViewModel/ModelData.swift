import Foundation

class ModelData: ObservableObject {
    // A class that holds the data for the investments
    @Published var investments: [Investment] = [
        Investment(id: 1, name: "Bitcoin", symbol: "BTC", change: 2.34, hold: 0.2, price: 38263, logo: "https://cryptologos.cc/logos/bitcoin-btc-logo.png"),
        Investment(id: 2, name: "Ethereum", symbol: "ETH", change: -1.56, hold: 1.3, price: 1983, logo: "https://cryptologos.cc/logos/ethereum-eth-logo.png?v=029"),
        Investment(id: 3, name: "Solana", symbol: "SOL", change: 0.78, hold: 16, price: 64, logo: "https://cryptologos.cc/logos/solana-sol-logo.png?v=029")
    ]
}
