//
//  Networkable.swift
//  BaseProj
//
//  Created by 김종권 on 2021/08/07.
//

import Moya

protocol Networkable {
    associatedtype Target: TargetType
    static func makeProvider() -> MoyaProvider<Target>
}

extension Networkable {

    static func makeProvider() -> MoyaProvider<Target> {
        /// Set access token plugin
        let authPlugin = AccessTokenPlugin { _ in
            return "access-token"
        }
        /// Set network logger plugin
        let loggerPlugin = NetworkLoggerPlugin()

        return MoyaProvider<Target>(plugins: [authPlugin, loggerPlugin])
    }

}
