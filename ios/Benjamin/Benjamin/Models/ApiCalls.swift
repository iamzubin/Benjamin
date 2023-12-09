import Foundation

struct WalletBalances: Decodable {
    let walletBalances: [String: String]
}

func getTokenBalances(for userAddress: String, completion: @escaping (Result<WalletBalances, Error>) -> Void) {
    // Construct the URL
    let urlString = "http://localhost:3000/getTokenBalancesForWallet?userAddress=\(userAddress)"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        return
    }

    // Create a URL session
    let session = URLSession.shared

    // Create a data task to make the request
    let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }

        // Check if the response status code indicates success
        if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
            do {
                // Decode the response JSON
                let decoder = JSONDecoder()
                let walletBalances = try decoder.decode(WalletBalances.self, from: data!)
                completion(.success(walletBalances))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "YourAppDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Status Code"])))
        }
    }

    // Start the data task
    task.resume()
}

