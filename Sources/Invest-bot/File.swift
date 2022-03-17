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
        let runLoop = CFRunLoopGetCurrent()
        
        //        var url = URL(string: "https://yfapi.net/v6/finance/quote")!
        //
        //        var querystring = [
        //            "symbols":"AMD",
        //            "region":"US",
        //            "lang":"en"
        //        ]
        
        let headers = [
            "x-api-key" : "DJcbbxcuNt96LScWh0zuw4Z3DsrrwsG41H0aDOnh"
        ]
        
        var components = URLComponents(string: "https://yfapi.net/v6/finance/quote")!
        
        components.queryItems = [
            URLQueryItem(name: "x-api-key", value: "DJcbbxcuNt96LScWh0zuw4Z3DsrrwsG41H0aDOnh"),
            URLQueryItem(name: "symbols", value: "AAPL"),
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
                    print("Name\t\t     Actual Price\t Market Open")
                    print("\(response.quoteResponse.result[0].shortName)\t \t \(response.quoteResponse.result[0].regularMarketPrice)\t \t \t \(response.quoteResponse.result[0].regularMarketOpen)")
                    
                    
                    CFRunLoopStop(runLoop)
                }
                catch {
                    print(error)
                }
            }
        })
        task.resume()
        CFRunLoopRun()
    }
}


