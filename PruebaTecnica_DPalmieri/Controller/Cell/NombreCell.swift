import UIKit

class NombreCell: UITableViewCell {
    
    @IBOutlet weak var textFieldNombre : UITextField!
    @IBOutlet weak var labelMessage : UILabel!
    
    
    static let identifier = "NombreCell"
    static let nib = UINib(nibName: "NombreCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension NombreCell : DataControllerDelegateNombre{
    func showLabel() {
        self.labelMessage.text = "Máximo 35 caracteres."
        self.labelMessage.textColor = .red
        self.labelMessage.isHidden = false
    }
    
    func hiddenLabel() {
        self.labelMessage.text = ""
        self.labelMessage.textColor = .red
        self.labelMessage.isHidden = true
    }
    
    
}
