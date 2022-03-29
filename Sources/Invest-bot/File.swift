import CoreFoundation
import Foundation


struct FinanceResponse: Codable {
    let quoteResponse: QuoteResponse
    
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
}

struct RecommendedFinances: Codable{
    let finance: Finance
    
    struct Finance: Codable{
        let result: [Result]
    }
    
    
    struct Result: Codable{
        let recommendedSymbols: [RecommendedSymbols]
    }
    
    struct RecommendedSymbols: Codable{
        let symbol: String
        let score: Double
        
    }
    
}





class DecoderBank{
    
    func app(){
        
        

        
        print("""
        ===============================================================
            Welcome InvestBot whats your action today?
        
            1.Select 1 to visualize investings
        
            2.Select 2 to visualize top 5 actual actions based by score
        
            3.Press any other button to shutdown the application
        ===============================================================
        """)
        
        while true {
            let opt = readLine()
            switch opt{
            case "1":
                print(
"""
//Examples of stocks you can choose//
//AAPL MSFT GOOG AMZN TSLA NVDA FB//
""")
                print("Choose one stock")
                let action = readLine()
                let runLoop = CFRunLoopGetCurrent()
                let headers = [
                    "x-api-key" : "xLHIOi80FB8PjsuuCVZDka9gK7mZ3Qur2Cyyhl3k"
                ]
                
                var components = URLComponents(string: "https://yfapi.net/v6/finance/quote")!
                
                components.queryItems = [
                    URLQueryItem(name: "x-api-key", value: "xLHIOi80FB8PjsuuCVZDka9gK7mZ3Qur2Cyyhl3k"),
                    URLQueryItem(name: "symbols", value: "\(action!)"),
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
                            print("Symbol\t Actual Price\t Market Open\t Name")
                            
                            for result in response.quoteResponse.result {
                                print("\(result.symbol) \t \(result.regularMarketPrice)\t\t\(result.regularMarketOpen)\t\t\t \(result.shortName)")
                                
                            }
                            
                            
                            CFRunLoopStop(runLoop)
                        }
                        catch {
                            print(error)
                        }
                    }
                })
                print("===================================================")
                task.resume()
                CFRunLoopRun()
                return app()
            case "2":
                let runLoop = CFRunLoopGetCurrent()
                let headers = [
                    "x-api-key" : "xLHIOi80FB8PjsuuCVZDka9gK7mZ3Qur2Cyyhl3k"
                ]
                
                var components = URLComponents(string:"https://yfapi.net/v6/finance/recommendationsbysymbol/AAPL")!
                
                components.queryItems = [
                    URLQueryItem(name: "x-api-key", value: "xLHIOi80FB8PjsuuCVZDka9gK7mZ3Qur2Cyyhl3k"),
                    URLQueryItem(name: "symbol", value: "AAPL"),
                ]
                
                var request = URLRequest(url: components.url!)
                request.allHTTPHeaderFields = headers
                request.httpMethod = "GET"
                
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data,response,error) in
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(RecommendedFinances.self, from: data)
                            print("Symbol\t  Score")
                            
                            for result in response.finance.result.first!.recommendedSymbols {
                                print("\(result.symbol)\t \(result.score)")
                                
                            }
                            
                            
                            CFRunLoopStop(runLoop)
                        }
                        catch {
                            print(error)
                        }
                    }
                })
                print("===================================================")
                task.resume()
                CFRunLoopRun()
                return app()
                
            default:
                print("Exit")
                break
        }
        
        
            
        
            }
}


}
