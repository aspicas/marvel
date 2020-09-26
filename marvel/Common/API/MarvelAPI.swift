//
//  MarvelAPI.swift
//  marvel
//
//  Created by David Garcia on 19/09/2020.
//

import Moya

public enum MarvelAPI {
    static private let publicKey: String = "aac3982a64c66c01a86fadce995cb1dc"
    static private let privateKey: String = "f21e5f8afe5f1896b461f2fb58ba50117744d49f"
    case getCaracters(limit: Int, offset: Int)
}

let marvelAPI = MoyaProvider<MarvelAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

extension MarvelAPI: TargetType {
    public var baseURL: URL { return URL(string: "http://gateway.marvel.com/v1/public")! }
    
    public var path: String {
        switch self {
        case .getCaracters:
            return "/characters"
        }
    }
    
    public var method: Method {
        switch self {
        case .getCaracters:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getCaracters:
            return stubbedResponse(R.file.charactersJson.name)
        }
        return Data()
    }
    
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        
        let hash = (ts + MarvelAPI.privateKey + MarvelAPI.publicKey).md5
        
        let authParams = ["apikey" : MarvelAPI.publicKey, "ts" : ts, "hash" : hash]
        
        switch self {
        case .getCaracters(let limit, let offset):
            return .requestParameters(
                parameters: authParams.merging(["limit" : "\(limit)", "offset" : "\(offset)"]) { (_, new) in new },
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    private func stubbedResponse(_ file: String?) -> Data! {
        if let bundlePath = Bundle.main.path(forResource: file, ofType: "json"),
           let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
        return Data()
    }
    
}
