import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var tableViewForm : UITableView!
    @IBOutlet weak var buttonSend : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetConfig()
    }
    
    func SetConfig(){
        tableViewForm.register(ElementCell.nib, forCellReuseIdentifier: ElementCell.identifier)
        tableViewForm.delegate = self
        tableViewForm.dataSource = self
        tableViewForm.separatorStyle = .none
    }

    @IBAction func buttonSendAction (_ sender : UIButton){
        if util.elements.filter({ $0.market }).count > 0 {
            performSegue(withIdentifier: "SendData", sender: self)
        }else{
            self.present(util.Alert("Error", "Selecciona al menos un elemento."), animated: true)
            
        }
        
    }

}
extension HomeController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return util.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellElement = tableView.dequeueReusableCell(withIdentifier: ElementCell.identifier) as? ElementCell else {
            return UITableViewCell()
        }
        
        cellElement.labelElement.text = util.elements[indexPath.row].title
        
        cellElement.imageViewCheck.backgroundColor = .clear
        cellElement.imageViewCheck.image = {
            switch indexPath.row{
                case 0:
                    return UIImage(systemName: "camera.fill")!
                case 1:
                    return UIImage(systemName: "person.crop.rectangle")!
                case 2:
                    return UIImage(systemName: "person.fill")!
                case 3:
                    return UIImage(systemName: "number")!
                case 4:
                    return UIImage(systemName: "calendar")!
                case 5:
                    return UIImage(systemName: "figure.dress.line.vertical.figure")!
                case 6:
                    return UIImage(systemName: "paintbrush.pointed.fill")!
                default:
                    return UIImage(systemName: "questionmark")!
            }
        }()
        
        cellElement.imageViewCheck.tintColor = .black
        cellElement.imageViewCheck.layer.masksToBounds = false
        cellElement.imageViewCheck.layer.cornerRadius = cellElement.imageViewCheck.frame.size.width/2
        cellElement.imageViewCheck.clipsToBounds = true
        return cellElement
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        util.elements[indexPath.row].market = !util.elements[indexPath.row].market
        
        guard let cellElement = tableView.cellForRow(at: indexPath) as? ElementCell else{
            return
        }
        
        cellElement.accessoryType = {
            if  util.elements[indexPath.row].market {
                return .checkmark
            }else{
                return .none
            }
        }()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

