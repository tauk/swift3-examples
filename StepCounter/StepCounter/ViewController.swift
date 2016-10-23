//
//  ViewController.swift
//  StepCounter
//
//  Created by tauk on 10/19/16.
//  Copyright © 2016 tauk. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var acitivityLabel: UILabel!
    
    //need the CMPedometer to count steps
    let cmPedometer = CMPedometer()
    
    //need CMMotionActivityManager to detect motion type
    let cmMotionActivityMgr = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let now = Date()
        
        //count the steps
        if (CMPedometer.isStepCountingAvailable()){
            //start getting step count updates from the pedometer - updates come a background thread
            cmPedometer.startUpdates(from: now) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil) {
                        //print("\(data!.numberOfSteps)")
                        self.stepsLabel.text = "\(data!.numberOfSteps)"
                    }
                })
            }
        }
        
        //detect motion activity
        if (CMMotionActivityManager.isActivityAvailable()){
            //start getting motion activity updates from motion acitivity manager
            cmMotionActivityMgr.startActivityUpdates(to: OperationQueue.main) {
                (data: CMMotionActivity?) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(data?.stationary == true){
                        self.acitivityLabel.text = "Stationary"
                    } else if (data?.walking == true){
                        self.acitivityLabel.text = "Walking"
                    } else if (data?.running == true){
                        self.acitivityLabel.text = "Running"
                    } else if (data?.automotive == true) {
                        self.acitivityLabel.text = "Driving"
                    }
                })
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

