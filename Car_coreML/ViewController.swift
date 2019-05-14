//
//  ViewController.swift
//  Car_coreML
//
//  Created by Forsaken on 13/05/2019.
//  Copyright © 2019 Forsaken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var modelControkl: UISegmentedControl!
    
    @IBOutlet weak var Extras: UISwitch!
    
    @IBOutlet weak var sliderPrecio: UISlider!
    
    @IBOutlet weak var kmsLabel: UILabel!
    
    @IBOutlet weak var statusControl: UISegmentedControl!
    
    @IBOutlet weak var priceLabel: UILabel!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    let cars = Cars()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.stackView.setCustomSpacing(25, after: self.modelControkl)
        self.stackView.setCustomSpacing(25, after: self.Extras)
        self.stackView.setCustomSpacing(25, after: self.sliderPrecio)
        self.stackView.setCustomSpacing(50, after: self.statusControl)
        
        
        self.calcularValor()
        
    }
    
   
    @IBAction func calcularValor() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formatterKMS = formatter.string(from: self.sliderPrecio?.value as! NSNumber) ?? "0"
        self.kmsLabel.text = "Kilometraje: \(formatterKMS) KMs"
        
        
        //Calcualando con ML
        if let prediccion = try? cars.prediction(modelo: Double(self.modelControkl.selectedSegmentIndex), extras: self.Extras.isOn ? Double(1.0) : Double(0.0), kilometraje: Double(self.sliderPrecio.value), estado: Double(self.statusControl.selectedSegmentIndex)){
            
            let clampValue = max(500, prediccion.price)
            formatter.numberStyle = .currency
            self.priceLabel.text = formatter.string(from: NSNumber(value: clampValue))
        }else{
            self.priceLabel.text = "Error"
        }
        
        
    }
    
    
    
    
}

