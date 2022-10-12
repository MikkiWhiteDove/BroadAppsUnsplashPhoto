//
//  DataFetcher.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 11.10.2022.
//

import Foundation


class DataFetcher {

    var webService = WebService()

    func fetchDataDescription(id: String, completion: @escaping (ItemDescription?)-> ()){
        webService.getDescriptionImage(id: id) { (data, error) in
            if let error = error {
                print("Error: ", error.localizedDescription)
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: ItemDescription.self, from: data)
            completion(decode)
        }
    }
    
    
    
    
    func fetchImage(searchTerm: String, completion: @escaping (SearchResult?) -> ()){
        webService.getRequest(searchBarText: searchTerm) { (data, error) in
            if let error = error {
                print("Error:  \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResult.self, from: data)
            completion(decode)
        }

    }

    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch {
            print("Catch Error: ", error.localizedDescription)
            return nil
        }
    }
}
