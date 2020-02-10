//
//  CalanqueCell.swift
//  Les Calanques
//
//  Created by Mattias on 10/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit

class CalanqueCell: UITableViewCell {

    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var CalanqueIV: ImageCircle!
    @IBOutlet weak var nameLabel: UILabel!
    
    var calanque: Calanque!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(_ calanque: Calanque){
        self.calanque = calanque
        ContainerView.layer.cornerRadius = 20
        ContainerView.backgroundColor = UIColor.lightGray
        nameLabel.text = self.calanque.nom
        CalanqueIV.image = self.calanque.image
        
    }

}
