//
//  cajaFijaViewController.swift
//  ejCajaMov
//
//  Created by Javier Rodríguez Valentín on 20/09/2021.
//

import UIKit

class cajaFijaViewController: UIViewController {

    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBOutlet weak var labelDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func limits (limit: String)->Bool{
        var lim = true
        
        switch limit {
        case "arriba":
            if bottom.constant == -540 || (leading.constant < 540){
                lim = false
            }
        case "abajo":
            if bottom.constant == 0 {
                lim = false
            }
        case "izquierda":
            if leading.constant == 0 || bottom.constant <= -60 {
                lim = false
            }
        case "derecha":
            if leading.constant == 540 {
                lim = false
            }
        default:
            print("Algo va mal")
        }
        
        return lim
        
    }

    
    @IBAction func arriba(_ sender: Any) {
        if limits(limit: "arriba") {
            labelDisplay.text = ""
            bottom.constant -= 60
        }else{
            labelDisplay.text = "No se puede subir más"
        }
        
        /*if bottom.constant == -540 {
            //print("No se puede subir más")
            labelDisplay.text = "No se puede subir más"
        }else{
            labelDisplay.text = ""
            bottom.constant -= 60
        }*/
    }
    
    @IBAction func abajo(_ sender: Any) {
        if limits(limit: "abajo") {
            labelDisplay.text = ""
            bottom.constant += 60
        }else{
            labelDisplay.text = "No se puede bajar más"
        }
        
        /*if bottom.constant == 0{
            //print("No se puede bajar más")
            labelDisplay.text = "No se puede bajar más"
        }else{
            labelDisplay.text = ""
            bottom.constant += 60
        }*/
    }
    
    @IBAction func izquierda(_ sender: Any) {
        if limits(limit: "izquierda") {
            labelDisplay.text = ""
            leading.constant -= 60
        }else{
            labelDisplay.text = "No se puede ir más a la izquierda"
        }
        
        /*if leading.constant == 0{
            //print("No se puede ir más a la izquierda")
            labelDisplay.text = "No se puede ir más a la izquierda"
        }else{
            labelDisplay.text = ""
            leading.constant -= 60
        }*/
    }

    
    @IBAction func derecha(_ sender: Any) {
        if limits(limit: "derecha") {
            labelDisplay.text = ""
            leading.constant += 60
        }else{
            labelDisplay.text = "No se puede ir más a la derecha"
        }
        
        /*if leading.constant == 540 {
            labelDisplay.text = "No se puede ir más a la derecha"
            print("No se puede ir más a la derecha")
        }else{
            labelDisplay.text = ""
            leading.constant += 60
        }*/
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        var didHandleEvent = false
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow {
                if limits(limit: "izquierda"){
                    didHandleEvent = true
                    //print("Izquierda")
                    labelDisplay.text = ""
                    leading.constant -= 60
                }else{
                    labelDisplay.text = "No se puede ir más a la izquierda"
                }
                
            }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow {
                if limits(limit: "derecha") {
                    labelDisplay.text = ""
                    leading.constant += 60
                    didHandleEvent = true
                }else{
                    labelDisplay.text = "No se puede ir más a la derecha"
                }
                
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow {
                if limits(limit: "arriba") {
                    labelDisplay.text = ""
                    bottom.constant -= 60
                    didHandleEvent = true
                }else{
                    labelDisplay.text = "No se puede subir más"
                }
                
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow {
                if limits(limit: "abajo") {
                    labelDisplay.text = ""
                    bottom.constant += 60
                    didHandleEvent = true
                }else{
                    labelDisplay.text = "No se puede bajar más"
                }
                
            }
        }
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
    }
    
}
