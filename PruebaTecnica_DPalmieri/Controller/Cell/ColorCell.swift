import UIKit

class ColorCell: UITableViewCell {
    @IBOutlet weak var colorWellColor : UIColorWell!
    
    static let identifier = "ColorCell"
    static let nib = UINib(nibName: "ColorCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
