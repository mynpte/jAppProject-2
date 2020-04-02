//
//  Datetimepicker.swift
//  jAppProject
//
//  Created by Mild on 31/3/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit

class Datetimepicker: UIViewController {
    
    
    @IBOutlet weak var lbdate: UILabel!
    @IBOutlet weak var lbtime: UILabel!
    
    @IBAction func btndone(_ sender: Any) {
//        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let svc = storyBoard.instantiateViewController(identifier: "createVC") as! createVC
//         self.view.window?.rootViewController = svc

        performSegue(withIdentifier: "sentdatetime", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sentdatetime" {
            let vc = segue.destination as! createVC
            vc.datadate = lbdate.text!
            vc.datatime = lbtime.text!
        }
    }
    
    @IBAction func btncancel(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyBoard.instantiateViewController(identifier: "createVC") as! createVC
        self.view.window?.rootViewController = svc
//         self.dismiss(animated: true, completion: nil)
//         navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var timepicker: UIDatePicker!
    
    var datepicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker.frame = CGRect(x: 0, y: 338, width: self.view.bounds.width, height: 160)
        datepicker.datePickerMode = .date
        datepicker.locale = Locale.current
        datepicker.backgroundColor = UIColor(red: 255/255, green: 13/255, blue: 18/255, alpha: 1)
        
        self.view.addSubview(datepicker)
        
        timepicker.backgroundColor = UIColor(red: 255/255, green: 13/255, blue: 18/255, alpha: 1)
        
        datepicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        
        timepicker.addTarget(self, action: #selector(getDateAndTime), for: .valueChanged)
        
        getDateAndTime()
        
 
        
    }

    @objc func getDateAndTime(){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        timeFormatter.amSymbol = "AM"
        timeFormatter.pmSymbol = "PM"
        
        let dataString = dateFormater.string(from: datepicker.date)
        lbdate.text = "DATE \(dataString)"
        
        let timeString = timeFormatter.string(from: timepicker.date)
        lbtime.text = "TIME \(timeString)"
        
        
    }


}
