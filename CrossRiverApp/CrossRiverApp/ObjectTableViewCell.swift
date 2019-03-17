//
//  ObjectTableViewCell.swift
//  FlappyBird
//
//  Created by 杜李 on 2019/1/12.
//

import UIKit

class ObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numText: UITextField!
    @IBOutlet weak var masterText: UITextField!
    @IBOutlet weak var loadText: UITextField!
    @IBOutlet weak var preydatorText: UITextField!
    @IBOutlet weak var naturalenemyText: UITextField!
    @IBOutlet weak var competitorText: UITextField!
    @IBOutlet weak var boatingSwitch: UISwitch!
    @IBOutlet weak var crossSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
