//
//  post.swift
//  SpotifySignInExample
//
//  Created by Edward Smith on 3/4/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import Foundation



struct ToDoResponseModel: Codable {
    var userId: Int
    var id: Int?
    var title: String
    var completed: Bool
}

let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
guard let requestUrl = url else { fatalError() }
var request = URLRequest(url: requestUrl)
request.httpMethod = "POST"
// Set HTTP Request Header
request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
let newTodoItem = ToDoResponseModel(userId: 300, title: "Urgent task 2", completed: true)
let jsonData = try JSONEncoder().encode(newTodoItem)
request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
            print("Error took place \(error)")
            return
        }
        guard let data = data else {return}
        do{
            let todoItemModel = try JSONDecoder().decode(ToDoResponseModel.self, from: data)
            print("Response data:\n \(todoItemModel)")
            print("todoItemModel Title: \(todoItemModel.title)")
            print("todoItemModel id: \(todoItemModel.id ?? 0)")
        }catch let jsonErr{
            print(jsonErr)
       }
 
}
task.resume()
