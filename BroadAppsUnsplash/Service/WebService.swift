//
//  WebService.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 11.10.2022.
//

import Foundation

class WebService{

    func getRequest(searchBarText: String, completion: @escaping (Data?, Error?)->Void) {

        let paraments = self.paraments(searchBarText: searchBarText)
        let url = self.url(params: paraments)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let requestDataTask = createRequestDataTask(from: request, completion: completion)
        requestDataTask.resume()
    }
    
    
    

    private func prepareHeader()->[String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID Pqo3TpRyrVSYbD_MWY0_HEsh2ceu5LFyR2qP2hGlKZo"
        return headers
    }

    private func paraments(searchBarText: String?) -> [String: String]{
        var params = [String: String]()
        params["query"] = searchBarText
        params["page"] = String(1)
        params["per_page"] = String(30)
        return params
    }

    private func url(params: [String: String])-> URL{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    
    
    
    func getDescriptionImage(id: String, completion: @escaping (Data?, Error?)->Void){
        guard let url = URL(string: "https://api.unsplash.com/photos/\(id)?") else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let requestDataTask = createRequestDataTask(from: request, completion: completion)
        requestDataTask.resume()
    }

    private func createRequestDataTask(from request: URLRequest, completion: @escaping (Data?, Error?)-> Void)-> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    
}
