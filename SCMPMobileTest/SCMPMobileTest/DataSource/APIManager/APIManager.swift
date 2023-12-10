//
//  APIManager.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingError
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed:
            return "Request failed"
        case .invalidData:
            return "Invalid data"
        case .decodingError:
            return "Decoding error"
        case .custom(let errorMessage):
            return errorMessage
        }
    }
}

class APIManager {
    static let shared = APIManager()
    
    init() {}
    
    func login(email: String, password: String, completion: @escaping(Result<String, APIError>)-> Void) {
        guard let url = URL(string: APIInfo.login.path) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password)
        ]
        
        request.httpBody = components.percentEncodedQuery?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let token = json?["token"] as? String{
                        completion(.success(token))
                    }else {
                        completion(.failure(APIError.decodingError))
                    }
                }catch {
                    completion(.failure(APIError.decodingError))
                }
            }else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let errorMessage = json?["error"] as? String {
                        completion(.failure(APIError.custom(errorMessage)))
                    } else {
                        completion(.failure(APIError.requestFailed))
                    }
                }catch {
                    completion(.failure(APIError.decodingError))
                }
            }
        }.resume()
    }
    
    func getStaffList(pageNumber: String, completion: @escaping(Result<StaffListResponse, APIError>) -> Void) {
        guard let url = URL(string: APIInfo.getStaffList.path + pageNumber) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let staffList = try decoder.decode(StaffListResponse.self, from: data)
                    completion(.success(staffList))
                }catch {
                    completion(.failure(APIError.decodingError))
                }
            }else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let errorMessage = json?["error"] as? String {
                        completion(.failure(APIError.custom(errorMessage)))
                    } else {
                        completion(.failure(APIError.requestFailed))
                    }
                }catch {
                    completion(.failure(APIError.decodingError))
                }
            }
        }.resume()
    }
    
}

class MockAPIManager: APIManager {
    var loginCalled = false
    var getStaffListCalled = false
    var shouldSuccess = true
    var mockError: APIError?
    var mockToken: String?
    var mockStaffList: StaffListResponse?
    
    override init() {
        super.init()
    }
    
    override func login(email: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        loginCalled = true
        
        if shouldSuccess {
            completion(.success(mockToken ?? ""))
        }else {
            completion(.failure(mockError ?? .custom("custom error")))
        }
    }
    
    override func getStaffList(pageNumber: String, completion: @escaping (Result<StaffListResponse, APIError>) -> Void) {
            if shouldSuccess {
                // 模擬取得 StaffList 成功
                if let mockStaffList = mockStaffList {
                    completion(.success(mockStaffList))
                } else {
                    // 如果沒有設定 mockStaffList，你可能需要自己建立一個合適的 StaffListResponse
                    completion(.failure(.custom("")))
                }
            } else {
                // 模擬取得 StaffList 失敗
                completion(.failure(mockError ?? .custom("")))
            }
        }

}
