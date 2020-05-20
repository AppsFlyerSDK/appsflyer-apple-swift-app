//
//  NetworkingManager.swift
//  mopicker-sample-app
//
//  Created by Ivan Obodovskyi on 27.04.2020.
//  Copyright © 2020 Ivan Obodovskyi. All rights reserved.
//

import Alamofire

class NetworkingManager {
    
    public static let shared = NetworkingManager()

    private init() {}
    
    //TODO: - Refactor dis, handle errors
    public func requestAPIData<T: Codable>(_ urlString: String, model: T.Type, onSuccess: @escaping (T)->Void){
        guard let url = URL(string: urlString) else { return }
        _ = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { (data) in
            switch data.result {
            case .success(let data):
                do {
                    let obj = try JSONDecoder().decode(model, from: data)
                    onSuccess(obj)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print("Hello, I am your error ", err.localizedDescription)
            }
        }
    }
    
    public func requestImageData(_ urlString: String, completionHandler: @escaping (Data) ->Void) {
        guard let url = URL(string: urlString) else { return }
        _ = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { (data) in
            switch data.result {
            case .success(let imageData):
                completionHandler(imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

