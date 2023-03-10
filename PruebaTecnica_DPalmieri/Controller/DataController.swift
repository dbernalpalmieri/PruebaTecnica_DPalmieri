import UIKit

protocol DataControllerDelegateFoto{
    func reloadImageView()
}
protocol DataControllerDelegateNombre{
    func showLabel()
    func hiddenLabel()
}

class DataController: UIViewController {
    
    @IBOutlet weak var tableViewData : UITableView!
    
    var delegateFoto : DataControllerDelegateFoto?
    var delegateNombre : DataControllerDelegateNombre?
    var elements = [Element]()
    
    override func viewWillAppear(_ animated: Bool) {
        SetConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetData()
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    func SetData(){
        elements = util.elements.filter { $0.market }
    }
    
    func SetConfig(){
        
        util.dateFormatter.locale = Locale(identifier: .localizedName(of: .ascii))
        util.dateFormatter.dateFormat = "dd-MM-yyyy"
        
        tableViewData.register(CamaraCell.nib, forCellReuseIdentifier: CamaraCell.identifier)
        tableViewData.register(FotoCell.nib, forCellReuseIdentifier: FotoCell.identifier)
        tableViewData.register(NombreCell.nib, forCellReuseIdentifier: NombreCell.identifier)
        tableViewData.register(TelefonoCell.nib, forCellReuseIdentifier: TelefonoCell.identifier)
        tableViewData.register(FechaCell.nib, forCellReuseIdentifier: FechaCell.identifier)
        tableViewData.register(SexoCell.nib, forCellReuseIdentifier: SexoCell.identifier)
        tableViewData.register(ColorCell.nib, forCellReuseIdentifier: ColorCell.identifier)
        tableViewData.register(BasicCell.nib, forCellReuseIdentifier: BasicCell.identifier)
        tableViewData.delegate = self
        tableViewData.dataSource = self
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
    }
//    @objc func keyboard(notification:Notification) {
//        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
//            return
//        }
//        
//        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
//            self.view.frame.origin.y = -keyboardReact.height
//        }else{
//            self.view.frame.origin.y = 0
//        }
//        
//    
//    }

        
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func datePickerChange(_ sender : UIDatePicker){
        
        guard let cell = sender.superview?.superview as? FechaCell,
              let textFieldFecha = cell.textFieldFecha
        else{
            return
        }
        
        textFieldFecha.text = util.dateFormatter.string(from: sender.date)
    }
    
    @objc func imageViewTouchInside(_ recognizer: UITapGestureRecognizer){
        ChooseSourceImage()
    }
    
    func ChooseSourceImage(){
        let alertController = UIAlertController(title: "Choose an Image", message: "", preferredStyle: .actionSheet)
        let optionButton1 = UIAlertAction(title: "Open Camera", style: .default){[self] (_) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.sourceType = .camera
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)
                
            }else{
                return
            }
            
        }
        let optionButton2 = UIAlertAction(title: "Gallery", style: .default){[self] (_) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.sourceType = .photoLibrary
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)
                
            }else{
                return
            }
            
        }
        let optionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(optionButton1)
        alertController.addAction(optionButton2)
        alertController.addAction(optionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension DataController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return elements[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch elements[indexPath.section].id{
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CamaraCell.identifier) as? CamaraCell else {
                    return UITableViewCell()
                }
                cell.imageViewCamera.image = UIImage(systemName: "questionmark")
                cell.imageViewCamera.isUserInteractionEnabled = true
                cell.imageViewCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTouchInside)))
                delegateFoto = cell

                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FotoCell.identifier) as? FotoCell else {
                    return UITableViewCell()
                }

                cell.imageViewFoto.downloaded(from: "https://images.pexels.com/photos/14930738/pexels-photo-14930738.jpeg")

                return cell
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NombreCell.identifier) as? NombreCell else {
                    return UITableViewCell()
                }
                cell.textFieldNombre.placeholder = "Nombre"
                cell.textFieldNombre.tag = elements[indexPath.section].id
                cell.labelMessage.text = ""
                cell.labelMessage.textColor = .red
                cell.labelMessage.isHidden = true
                cell.textFieldNombre.delegate = self
                delegateNombre = cell
                return cell
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TelefonoCell.identifier) as? TelefonoCell else {
                    return UITableViewCell()
                }
                cell.textFieldTelefono.tag = elements[indexPath.section].id
                cell.textFieldTelefono.placeholder = "Télefono"
                cell.textFieldTelefono.keyboardType = .numberPad
                cell.textFieldTelefono.delegate = self
                return cell

            case 4:

                guard let cell = tableView.dequeueReusableCell(withIdentifier: FechaCell.identifier) as? FechaCell else {
                    return UITableViewCell()
                }
                cell.textFieldFecha.isEnabled = false
                //cell.textFieldFecha.tag = elements[indexPath.section].id
                cell.datePickerFechaNacimiento.date = Date()
                cell.datePickerFechaNacimiento.maximumDate = util.maximunDate
                cell.datePickerFechaNacimiento.minimumDate = util.minimunDate
                cell.datePickerFechaNacimiento.addTarget(self, action: #selector(datePickerChange), for: .valueChanged)

                return cell

            case 5:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicCell.identifier) as? BasicCell else{
                    return UITableViewCell()
                }
                cell.labelCell.font = UIFont.systemFont(ofSize: 16)
                cell.backgroundColor = .clear
                cell.labelCell.text = elements[indexPath.section].cells[indexPath.row].title
                if util.selectSexo == indexPath.row{
                    cell.accessoryType = .checkmark
                }
                    
                return cell
                
            case 6:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicCell.identifier) as? BasicCell else{
                    return UITableViewCell()
                }
                cell.labelCell.font = UIFont.systemFont(ofSize: 16)
                cell.backgroundColor = util.colors[indexPath.row]
                cell.labelCell.text = elements[indexPath.section].cells[indexPath.row].title
                if util.selectColor.contains(indexPath.row){
                    cell.accessoryType = .checkmark
                }
                return cell
            default:
                return UITableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.section].id{
            case 0:
                return 280.0
            case 1:
                return 360.0
            case 2:
                return 80.0
            case 3:
                return 60.0
            case 4:
                return 120.0
            case 5:
                return 60.0
            case 6:
                return 60.0
            default:
                return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicCell.identifier) as? BasicCell else{
            return UITableViewCell()
        }
        cell.labelCell.font = UIFont.boldSystemFont(ofSize: 20)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.labelCell.text = elements[section].title
        cell.accessoryType = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch elements[indexPath.section].id{
            case 5:
                guard let cell = tableView.cellForRow(at: indexPath) as? BasicCell else{
                    return
                }
                
                // Clear all checkmarks
                if let previousCell = tableView.cellForRow(at: IndexPath(row: util.selectSexo, section: indexPath.section)) as? BasicCell {
                    previousCell.accessoryType = .none
                    util.selectSexo = -1
                }
                // Mark the selected cell
                util.selectSexo = indexPath.row
                cell.accessoryType = .checkmark
                
                
                
            case 6:
              
                guard let cell = tableView.cellForRow(at: indexPath) as? BasicCell else{
                    return
                }
                if util.selectColor.contains(indexPath.row) {
                    util.selectColor.remove(at: util.selectColor.firstIndex(of: indexPath.row)!)
                    cell.accessoryType = .none
                } else {
                    util.selectColor.append(indexPath.row)
                    cell.accessoryType = .checkmark
                }

                // Show a message if no cells are selected
                if util.selectColor.isEmpty {
                    util.selectColor.append(indexPath.row)
                    cell.accessoryType = .checkmark
                    util.UpdateView {
                        self.present(util.Alert("Error", "Un color debe estar seleccionado."), animated: true)
                    }
                }
                
            default:
                tableView.deselectRow(at: indexPath, animated: true)
                return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
}
extension DataController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField.tag {
            case 2:
                let allowedCharacters = CharacterSet.letters.union(CharacterSet(charactersIn: " "))
                let maxLength = 35
                
                    // check characters
                guard newText.rangeOfCharacter(from: allowedCharacters.inverted) == nil else {
                    return false
                    
                }
                
                if newText.count <= maxLength{
                    delegateNombre?.hiddenLabel()
                } else {
                    delegateNombre?.showLabel()
                    return false
                    
                }
            case 3:
                guard let text = textField.text else {return false}
                let newString = (text as NSString).replacingCharacters(in: range, with: string)
                textField.text = util.formatterPhoneNumber("(XX)-XXXX-XXXX", newString)
                return false 
            default:
                return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    
   
}
extension DataController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        if let _ = image.pngData(){
            util.imageData = image.pngData()
            delegateFoto?.reloadImageView()
        }
        
        
    }
}
