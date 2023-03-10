import UIKit

class SexoCell: UITableViewCell {

    @IBOutlet weak var segmentedControlSexo : UISegmentedControl!
    
    static let identifier = "SexoCell"
    static let nib = UINib(nibName: "SexoCell", bundle: .main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
