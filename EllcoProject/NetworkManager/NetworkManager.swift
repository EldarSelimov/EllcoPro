//
//  NetworkManager.swift
//  EllcoProject
//
//  Created by Eldar on 26.01.2021.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let hostURL =  "https://lk.ellco.ru:8000/bug_tracker/"
    
   
    func getTickets(succes: @escaping ([TicketModel]) -> Void, onError: @escaping (String) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Application": "application/json",
            "X-AUTH-TOKEN": "38fa0880d113c79d8e0196481d4f4562576b5348de1ab9619696d3449de5"
        ]
        AF
            .request(hostURL, method: .get, parameters: nil, headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let dict = value as? [String: Any],
                       let dictArray = dict["bug_trackers"] as? [[String: Any]] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: dictArray, options: .fragmentsAllowed)
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode([TicketModel].self, from: data)
                            DispatchQueue.main.async {
                                succes(result)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                onError(error.localizedDescription)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            onError("Ошибка парсинга данных")
                        }
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        onError(error.localizedDescription)
                    }
                }
            }
    }
    
}
