import UIKit

class TelefonoCell: UITableViewCell {
    @IBOutlet weak var textFieldTelefono : UITextField!
    
    static let identifier = "TelefonoCell"
    static let nib = UINib(nibName: "TelefonoCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
