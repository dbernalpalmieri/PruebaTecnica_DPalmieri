import UIKit

class FechaCell: UITableViewCell {
    
    @IBOutlet weak var datePickerFechaNacimiento : UIDatePicker!
    @IBOutlet weak var textFieldFecha : UITextField!
    
    static let identifier = "FechaCell"
    static let nib = UINib(nibName: "FechaCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
