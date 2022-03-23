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
        let result: Result
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
                                Welcome
            1.Select 1 to visualize investings
        
            2.Select 2 to visualize top 5 actual actions based by score
        
            3.Press any other button to shotdown the application
        """)
        
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
                    URLQueryItem(name: "symbols", value: "AAPL,ADBE,ABNB,AMZN,AMD,FB"),
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
                                print("\(result.symbol) \t \(result.regularMarketPrice)\t\t\t\(result.regularMarketOpen)\t\t\t \(result.shortName)")
                                
                            }
                            
                            
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
                let runLoop = CFRunLoopGetCurrent()
                let headers = [
                    "x-api-key" : "bIyEkCuO7A4AUpgQ3QCj746X9zpzSUKV6BH3ckn2"
                ]
                
                var components = URLComponents(string:"https://yfapi.net/v6/finance/recommendationsbysymbol/AAPL")!
                
                components.queryItems = [
                    URLQueryItem(name: "x-api-key", value: "bIyEkCuO7A4AUpgQ3QCj746X9zpzSUKV6BH3ckn2"),
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
                            
                            for result in response.finance.result.recommendedSymbols{
                                print("\(result.symbol)\t \(result.score)")
                                
                            }
                            
                            
                            CFRunLoopStop(runLoop)
                        }
                        catch {
                            print(error)
                        }
                    }
                })
                task.resume()
                CFRunLoopRun()
            default:
                break
        }
        
        
            
        
            }
}


}
