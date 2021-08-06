//
//  ResponseData.swift
//  BaseProj
//
//  Created by 김종권 on 2021/08/07.
//

import Foundation
import Moya

struct ResponseData<Model: Codable> {
    struct CommonResponse: Codable {
        let responseCode: Int
        let message: String
        let result: Model?
    }

    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                /// decode: json to struct
                let commonResponse = try JSONDecoder().decode(CommonResponse.self, from: response.data)

                guard commonResponse.responseCode < 300 else {
                    let serviceError = ServiceError.invalidResponse(responseCode: commonResponse.responseCode,
                                                                    message: commonResponse.message)
                    return .failure(serviceError)
                }

                return .success(commonResponse.result)
            } catch {
                return .failure(error)
            }

        case .failure(let error):
            return .failure(error)
        }
    }

    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
