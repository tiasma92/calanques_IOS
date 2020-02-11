//
//  DetailController.swift
//  Les Calanques
//
//  Created by Mattias on 11/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var CalanqueIV: UIImageView!
    @IBOutlet weak var nameAndDesc: UITextView!
    
    var calanqueGet: Calanque?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let calanque = calanqueGet else { return }
        CalanqueIV.image = calanque.image
        
        let mutable = NSMutableAttributedString(string: calanque.nom + "\n", attributes: [.foregroundColor: UIColor.red, .font: UIFont.boldSystemFont(ofSize: 20)])
        mutable.append(NSAttributedString(string: calanque.desc, attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.darkGray]))
        nameAndDesc.attributedText = mutable

        // Do any additional setup after loading the view.
    }
    

}
