import CoreFoundation
import Foundation

struct FinanceResponse: Codable {
    let quoteResponse: QuoteResponse
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let symbol: String
    let regularMarketPrice: Double
    let regularMarketOpen: Double
    let shortName: String
}

class DecoderBank{
    
    func app(){
        
        

        print("Welcome")
        
        while true {
            let opt = readLine()
            switch opt{
            case "1":
                let runLoop = CFRunLoopGetCurrent()
                let headers = [
                    "x-api-key" : "bIyEkCuO7A4AUpgQ3QCj746X9zpzSUKV6BH3ckn2"
                ]
                
                var components = URLComponents(string: "https://yfapi.net/v6/finance/quote")!
                
                components.queryItems = [
                    URLQueryItem(name: "x-api-key", value: "bIyEkCuO7A4AUpgQ3QCj746X9zpzSUKV6BH3ckn2"),
                    URLQueryItem(name: "symbols", value: "AAPL,ADBE"),
                    URLQueryItem(name: "region", value: "US"),
                    URLQueryItem(name: "lang", value: "en")
                ]
                
                var request = URLRequest(url: components.url!)
                request.allHTTPHeaderFields = headers
                request.httpMethod = "GET"
                
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data,response,error) in
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(FinanceResponse.self, from: data)
                            print("Name\t\t  Actual Price\t Market Open")
                            
                            for i in 0...1 {
                                print("\(response.quoteResponse.result[i].shortName) \t  \(response.quoteResponse.result[i].regularMarketPrice)\t \t \(response.quoteResponse.result[i].regularMarketOpen)")
                                
                            }
                            
//                            print("\(response.quoteResponse.result[0].shortName) \t  \(response.quoteResponse.result[0].regularMarketPrice)\t \t \(response.quoteResponse.result[0].regularMarketOpen)")
                            
                            
                            CFRunLoopStop(runLoop)
                        }
                        catch {
                            print(error)
                        }
                    }
                })
                task.resume()
                CFRunLoopRun()

            case "2":
                print("2")
            default:
                break
        }
        
        
            
        
            }
}


}
