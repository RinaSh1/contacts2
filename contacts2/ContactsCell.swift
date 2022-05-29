//
//  ContactsCell.swift
//  contacts2
//
//  Created by Rina Shabani on 29.5.22.
//


import UIKit

class ContactCell : UITableViewCell
{
    var link: ViewController?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    //    backgroundColor = .red
        let starButton = UIButton(type: .system)
        starButton.setImage(UIImage(named: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    @objc private  func handleMarkAsFavorite(){
       // print("MArking as favorite")
        link?.someMethodIWantToCall(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      
    }
}
