import CoreFoundation
import Foundation

class DecoderBank{
    
//    struct Get: Codable{
//        let symbol: String
//    }
    
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
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data,response,error) in if let data = data {
                do{
                    let object = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(object)
//                    let res = try JSONDecoder().decode([Get].self, from:data)
//                    print("PRIMEIRO: \(res)")

                    CFRunLoopStop(runLoop)
                }
//            catch let error{
//                    print(error)
//                }
            }
        })
        task.resume()
        CFRunLoopRun()
    }
}


