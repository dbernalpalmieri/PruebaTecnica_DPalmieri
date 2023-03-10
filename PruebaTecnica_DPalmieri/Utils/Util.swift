import Foundation
import UIKit

var util = Util.shareInstance

struct Util{
    static var shareInstance = Util()
    
    var elements = [
        Element(id: 0, title: "Camara", market: false, cells: [Cell(id: 0, title: "Camara")]),
        Element(id: 1, title: "Foto", market: false, cells: [Cell(id: 0, title: "Foto")]),
        Element(id: 2, title: "Nombre Completo", market: false, cells: [Cell(id: 0, title: "Nombre")]),
        Element(id: 3, title: "Número telefónico", market: false,cells: [Cell(id: 0, title: "Télefono")] ),
        Element(id: 4, title: "Fecha de Nacimiento", market: false, cells: [Cell(id: 0, title: "Fecha")]),
        Element(id: 5, title: "Sexo (Masculino/Femenino)", market: false, cells: [
            Cell(id: 0, title: "Masculino"),
            Cell(id: 1, title: "Femenino")
        ]),
        Element(id: 6, title: "Color Favorito", market: false, cells: [
            Cell(id: 0, title: "Rojo"),
            Cell(id: 1, title: "Verde"),
            Cell(id: 2, title: "Azul"),
            Cell(id: 3, title: "Magenta"),
            Cell(id: 4, title: "Amarillo"),
            Cell(id: 5, title: "Cyan"),
        ])
    ]
    let colors = [UIColor(ciColor: .red), UIColor(ciColor: .green), UIColor(ciColor: .blue), UIColor(ciColor: .magenta), UIColor( ciColor: .yellow), UIColor(ciColor: .cyan)]
    
    let date = Date()
    let maximunDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
    let minimunDate = Calendar.current.date(byAdding: .year, value: -110, to: Date())
    
    let dateFormatter = DateFormatter()
    
    var imageData : Data?
    
    var selectSexo = -1
    var selectColor = [Int]()
    
    func Alert(_ title : String? = "Alert", _ message : String? = "This is a Alert", _ options : [UIAlertAction]? = [UIAlertAction]() ) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let defaultOption = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        if let options = options, options.count > 0 {
            for optionAction in options {
                alert.addAction(optionAction)
            }
        }else{
            alert.addAction(defaultOption)
        }
        return alert
    }
    
    func UpdateView(_ function: @escaping () -> Void){
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
                   
                function()
            }
        }
    }
    
    func formatterPhoneNumber(_ mask : String, _ phoneNumber : String) -> String{
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result : String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex{
            if character == "X"{
                result.append(number[index])
                index = number.index(after: index)
            }else{
                result.append(character)
            }
        }
        return result
    }
    
}
