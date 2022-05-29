//
//  ViewController.swift
//  contacts2
//
//  Created by Rina Shabani on 28.5.22.
//



import UIKit
//to get the list thats why we change UIViewController to UITableViewController
class ViewController: UITableViewController  {
    
    let cellId = "cellId456"
    //https://www.letsbuildthatapp.com/course_video?id=1852
    //https://www.letsbuildthatapp.com/course_video?id=1502
    //The idea of this function is to somehow to be called from the contact cell
    func someMethodIWantToCall(cell: UITableViewCell) {
        print("igk")
        
        //we are going to figure out which name you are clicking on
   
        let indexPathTapped =  tableView.indexPath(for: cell)
       // print(indexPathTapped)
        let name =  twoDimensionalArray[indexPathTapped!.section].names[indexPathTapped!.row]
       print(name)
    }
    
    //each row need to contain a name
//    let names = [
  //      "Amy", "Bill", "Zack", "Steve", "Jack", "ana"
   // ]
    
   // let cNames = [
        //"Carl", "cepe", "CEfl", "Cfdl"
    //]
    var twoDimensionalArray = [
        //use Struct to define names
        ExpandableNames(isExpanded: true, names: ["Amyyy", "Biyll", "Zack", "Steve", "Jack", "ana"]),
        ExpandableNames(isExpanded: true, names: [ "Carl", "cop", "CEfl", "Cfdl", "Carl"])
       
     //  ExpandableNames(isExpanded: true, names: [contact(name: "Patrick", hasFavorited: false)] ),
    
    ]
    
    //toggle slides to the right and left
    var showIndexPaths = false
    
    @objc func handleShowIndexPath () {
        
      //  print("Attempting reload animiamtions of indexPAth......")
       
   //3 Build all the index paths we want to reload
       var indexPathsToReload = [IndexPath]()
       //4.Reload Everything/
       for section in twoDimensionalArray.indices {
           for row in twoDimensionalArray[section].names.indices {
               print(section, row)
               let indexPath = IndexPath(row: row, section: section)
               indexPathsToReload.append(indexPath)
           }
       }
       
       //2.Reload the first section
       //.get index path for first section
      // for index in twoDimensionalArray[0].indices {
           //get index path for first section
        //   let indexPath = IndexPath(row: index, section: 0)
          // indexPathsToReload.append(indexPath)
       //}
       //1Get index path for first row. let indexPath = IndexPath(row: 0, section: 0), tableView.reloadRows(at: [indexPath], with: .left)
      
       //to go to the right then to the left when we reload
       showIndexPaths = !showIndexPaths
       let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
       
       tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }

       override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPAth", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //dequeu require to register the cell
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    //provide a devider to distungish te sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let button = UIButton (type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //when we tab the button
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        
        button.tag = section
       
        return button
        
     
    }
    //we write [button: UIbutton] in parameter because of button.tag
    @objc func handleExpandClose(button: UIButton) {
        print ("Trying to expand and close section....")
        
        //to make more easire, because then we need to write section[0],[1]
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        //1we get section from 0...5 and row from 0..5
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        //every time when i close the button
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal )
        
        //insert row if secton is opened and delete row if section is closed
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: .fade)
    
        }
        else{
            tableView.insertRows(at: indexPaths, with: .fade)
        }
      
        //we'll try to close the section first by deleting the rows
       // twoDimensionalArray[section].removeAll()
        
    
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
    //number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count //it means we have 3 section
    }
      
    //provide row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        //how many rows i need to return
        if !twoDimensionalArray[section].isExpanded
        {
            return 0
        }
        return twoDimensionalArray[section].names.count
    }
    
    //provide cells foer each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //This method dequeues an existing cell if one is available or creates a new one
        //e definon klasen e cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell //cast this cell in contact cell
        cell.link = self //all the cells have the link
       
        //access the index path row
       // let name = self.names[indexPath.row]
    //    let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]
       //vid4 we change let=name to contact
        //let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = name
        
        if showIndexPaths {
        //for each row showes section and num of row
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row\(indexPath.row)"
        }
        return cell
    }

}



