//
//  BaseService.swift
//
//  Created by Marium Hassan on 09.08.22.
//


import Foundation
import Alamofire

protocol BaseServiceProtocol {
    /// Makes an HTTP request and Decodes the JSON response
    func execute<T:Codable>(action:String, completionHandler responseBlock: @escaping (Result<BaseResponse<T>,Error>?) -> Void)
}

final class BaseService: BaseServiceProtocol {
    
    var parameters = [String:String]()
    var requestHeaders = ["Authorization" :  "HP1JvDn9kjDyzaKpiBFipH3fGpAgAarB" ]
    var baseUrl:String = "https://api.nytimes.com/svc/mostpopular/v2/"
    
    func execute<T:Codable>(action:String, completionHandler responseBlock: @escaping (Result<BaseResponse<T>,Error>?) -> Void) {
        
        let headers = HTTPHeaders(requestHeaders)
        let requestString = "\(baseUrl)\(action)"
        let method = HTTPMethod.get
        let encoding:ParameterEncoding = URLEncoding.default
        parameters["api-key"] = (headers["Authorization"] ?? "")
        AF.request(requestString,
                   method:method,
                   parameters: parameters,
                   encoding:encoding,
                   headers: headers).responseJSON(completionHandler: { response in
            switch(response.result){
            case .success(let JSON):
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: JSON, options: []) else {
                    
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJSONData) else {
                    return
                }
                let datObj = BaseResponse(data: responseObj)
                responseBlock(.success(datObj))
                
            case .failure(let error):
                responseBlock(.failure(error))
                
            default:
                responseBlock(nil)
                break
            }
        })
        
    }
}


struct BaseResponse<T:Codable>:Codable{
    var data:T?
}
