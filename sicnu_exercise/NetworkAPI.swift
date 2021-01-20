//
//  HScrollViewController.swift
//  sicnu_exercise
//  网络连接接口
//  Created by apple on 2021/1/18.
//

import Foundation

class NetworkAPI {
    static func recommendWeiboList(completion: @escaping (Result<WeiboList, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "UserListData_recommend_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<WeiboList, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func hotWeiboList(completion: @escaping (Result<WeiboList, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "UserListData_hot_1.json", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<WeiboList, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func createWeibo(text: String, completion: @escaping (Result<Weibo, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "createpost", parameters: ["text": text]) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<Weibo, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
            return .failure(error)
        }
        return .success(decodedData)
    }
}
