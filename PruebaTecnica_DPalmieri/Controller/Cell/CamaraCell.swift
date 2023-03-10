import UIKit

class CamaraCell: UITableViewCell, UIImagePickerControllerDelegate{
    @IBOutlet weak var imageViewCamera : UIImageView!
    
    static let identifier = "CamaraCell"
    static let nib = UINib(nibName: "CamaraCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadImage(){
       // self.imageViewCamera.image = Imagepicker
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CamaraCell : DataControllerDelegateFoto{
    func reloadImageView() {
        self.imageViewCamera.image = UIImage(data: util.imageData!)
    }
    
    
}
