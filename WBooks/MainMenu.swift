//
//  MainMenu.swift
//  WBooks
//
//  Created by Gaston Maspero on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var books: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = createArray()
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = books[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCustomCell") as? CustomCell else {
            print("Error")
            return CustomCell()
        }
        cell.setText(text: text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func createArray() ->[String]{
        var books: [String] = []
        books.append("Books 1")
        books.append("Books 2")
        books.append("Books 3")
        books.append("Books 4")
        books.append("Books 5")
        books.append("Books 6")
        books.append("Books 7")
        books.append("Books 8")
        
        return books
        
    }

}
