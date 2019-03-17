//
//  ObjectTableViewController.swift
//  FlappyBird
//
//  Created by 杜李 on 2019/1/12.
//

import UIKit

class ObjectTableViewController: UITableViewController ,UITextFieldDelegate {
    var num = 5
    var objects = [Object]()
    
    @IBOutlet weak var startBarButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        objects = []
        initData()
    }
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        let controller = segue.destination as! GameViewController
        
        controller.objects = objects
        
    }
    @IBAction func addObject(_ sender: UIBarButtonItem) {
        num = num+1
        initData()
        if (!overflow()){
            loadView()
            
        } else {
            num = num-1
            initData()
            dialog()
        }
        
        
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return num
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        update()
        if (!overflow()){
            textField.resignFirstResponder()
            startBarButton.isEnabled = true
            addBarButton.isEnabled = true
            
        } else {
            dialog()
        }
        
        
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        addBarButton.isEnabled = false
        startBarButton.isEnabled = false
        
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            objects.remove(at: indexPath.row)
            num = num-1
            tableView.deleteRows(at: [indexPath], with: .fade)
            if (!overflow()){
                addBarButton.isEnabled = true
                startBarButton.isEnabled = true
            }
            loadView()
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ObjectTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ObjectTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.nameText.delegate = self
        cell.numText.delegate = self
        cell.loadText.delegate = self
        cell.masterText.delegate = self
        cell.naturalenemyText.delegate = self
        cell.competitorText.delegate = self
        cell.preydatorText.delegate  = self
        cell.boatingSwitch.addTarget(self, action: #selector(setOnOrOff(set:)), for: UIControlEvents.valueChanged)
        cell.crossSwitch.addTarget(self, action: #selector(setOnOrOff(set:)), for: UIControlEvents.valueChanged)
        
        cell.nameText.text = objects[indexPath.row].name
        cell.numText.text = String(objects[indexPath.row].num)
        cell.loadText.text = String(objects[indexPath.row].load)
        cell.naturalenemyText.text = objects[indexPath.row].naturalenemy
        cell.masterText.text = objects[indexPath.row].master
        cell.competitorText.text = objects[indexPath.row].competitor
        cell.preydatorText.text = objects[indexPath.row].predator
        cell.boatingSwitch.isOn = objects[indexPath.row].boating
        cell.crossSwitch.isOn = objects[indexPath.row].cross
        if (indexPath.row>0){
            cell.loadText.isEnabled = false
        } else {
            cell.loadText.isEnabled = true
        }
        
        
        
        return cell
    }
    func initData(){
        for n in 0..<num{
            if n>=objects.count{
                let name = "person"
                let number = 1
                let load = 2
                let master = ""
                let predator = ""
                let naturalenemy = ""
                let competitor = ""
                let boating = true
                let cross = true
                guard let object = Object(name: name,num: number,load: load,master: master,predator: predator,naturalenemy: naturalenemy,competitor: competitor,boating: boating,cross:cross) else {
                    fatalError("Unable to instantiate object")
                }
                objects += [object]
            }
            
            
        }
        
    }
    
    func setOnOrOff(set:UISwitch){
        update()
    }
    func dialog(){
        var sum = 0
        for i in 0..<objects.count{
            sum = sum*(objects[i].num+1)+objects[i].num
        }
        let msg = "ERROR:too many animals.\nSpecies:"+String(objects.count)+"\nSum of animals"+String(sum)
        print(msg)
        let alertController = UIAlertController(title: "提示", message: msg, preferredStyle:.alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default) { (UIAlertAction) in
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func overflow()->Bool{
        var sum = 0
        for i in 0..<objects.count{
            sum = sum*(objects[i].num+1)+objects[i].num
        }
        if (2*sum>1024*1024){
            return true
        } else{
            return false
            
        }
        
    }
    func update(){
        
        var indexPaths: [IndexPath]
        var cell:ObjectTableViewCell
        
        indexPaths = tableView.indexPathsForVisibleRows!
        for indexPath in indexPaths{
            cell  = tableView.cellForRow(at: indexPath) as! ObjectTableViewCell
            let name = cell.nameText.text ?? ""
            let num = Int(cell.numText.text!) ?? 3
            let load = Int(cell.loadText.text!) ?? 2
            let master = cell.masterText.text ?? ""
            let predator = cell.preydatorText.text ?? ""
            let naturalenemy = cell.naturalenemyText.text ?? ""
            let competitor = cell.competitorText.text ?? ""
            let boating = cell.boatingSwitch.isOn
            let cross = cell.crossSwitch.isOn
            guard let object = Object(name: name,num: num,load: load,master: master,predator: predator,naturalenemy: naturalenemy,competitor: competitor,boating: boating,cross:cross) else {
                fatalError("Unable to instantiate object")
            }
            objects[indexPath.row] = object
        }
        
    }
    

}
