import UIKit

class FotoCell: UITableViewCell {
    
    @IBOutlet weak var imageViewFoto : UIImageView!
    
    static let identifier = "FotoCell"
    static let nib = UINib(nibName: "FotoCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
