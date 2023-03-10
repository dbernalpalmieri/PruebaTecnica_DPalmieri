import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var labelElement : UILabel!
    @IBOutlet weak var imageViewCheck : UIImageView!

    static let identifier = "ElementCell"
    static let nib = UINib(nibName: "ElementCell", bundle: .main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
