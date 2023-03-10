import UIKit

class BasicCell: UITableViewCell {
    
    @IBOutlet weak var labelCell : UILabel!
    
    static let identifier = "BasicCell"
    static let nib = UINib(nibName: "BasicCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
