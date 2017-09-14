import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController {
    
    var input: PHContentEditingInput?
    var displayedImage: UIImage!
    let save: UserDefaults = UserDefaults.standard
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var selectBtn: UIButton!
    @IBOutlet var disguiseBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

fileprivate extension PhotoEditingViewController {
    
    func setupView() {
        view.backgroundColor = .darkGray
        selectBtn.layer.cornerRadius = selectBtn.frame.size.height / 2
        selectBtn.layer.masksToBounds = true
        selectBtn.isExclusiveTouch = true
        selectBtn.imageView?.contentMode = .scaleAspectFill
        selectBtn.addTarget(self, action: #selector(didTapSelect), for: .touchUpInside)
        disguiseBtn.layer.cornerRadius = disguiseBtn.frame.size.height / 2
        disguiseBtn.layer.masksToBounds = true
        disguiseBtn.isExclusiveTouch = true
        disguiseBtn.addTarget(self, action: #selector(didTapDisguise), for: .touchUpInside)
        selectedImageView.layer.cornerRadius = selectBtn.frame.size.height / 2
        selectedImageView.layer.masksToBounds = true
        selectedImageView.clipsToBounds = true
        
        if let imageData = save.data(forKey: "image") {
            let image = UIImage(data: imageData)
            selectedImageView.image = image
            selectBtn.setTitle("", for: .normal)
            selectBtn.backgroundColor = .clear
        } else {
            disguiseBtn.backgroundColor = .gray
            disguiseBtn.isEnabled = false
        }
    }
    
    func resizeImage(_ image: UIImage) -> UIImage {
        var resultImage = image
        var width = image.size.width
        var height = image.size.height
        var base: CGFloat = 0
        if width > 500 && height > 500 {
            if width > height || width == height {
                base = 500 / width
                width *= base
                height *= base
            } else if width < height {
                base = 500 / height
                width *= base
                height *= base
            }
            let size = CGSize(width: width, height: height)
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        return resultImage
    }
    
    @objc func didTapDisguise() {
        displayedImage = selectedImageView.image
        mainImageView.image = displayedImage
        disguiseBtn.isEnabled = false
        disguiseBtn.backgroundColor = .gray
    }
    
    @objc func didTapSelect() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = .photoLibrary
            present(controller, animated: true, completion: nil)
        }
    }
}

extension PhotoEditingViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        selectedImageView.image = image
        selectBtn.backgroundColor = .clear
        selectBtn.setTitle("", for: .normal)
        let data = UIImageJPEGRepresentation(image, 1)
        save.set(data, forKey: "image")
        picker.dismiss(animated: true, completion: nil)
        disguiseBtn.isEnabled = true
        disguiseBtn.backgroundColor = UIColor(red:0.54, green:0.79, blue:0.41, alpha:1.00)
    }
}

extension PhotoEditingViewController: PHContentEditingController {
    
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        input = contentEditingInput
        if let input = input {
            displayedImage = input.displaySizeImage
            mainImageView.image = displayedImage
        }
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        guard let input = input else { return }
        let output = PHContentEditingOutput(contentEditingInput: input)
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: resizeImage(displayedImage))
        let formatIdentifier = "com.kyoya.PhotoDisguiser.Photo-Disguiser"
        let formatVersion = "1.0"
        let adjustmentData = PHAdjustmentData(formatIdentifier: formatIdentifier, formatVersion: formatVersion, data: archivedData)
        output.adjustmentData = adjustmentData
        
        switch input.mediaType {
        case .image:
            guard let resultImage = displayedImage else { return }
            let renderedpngData = UIImageJPEGRepresentation(resultImage, 1)
            let saveSucceeded = (try? renderedpngData?.write(to: output.renderedContentURL, options: [.atomic])) != nil
            if saveSucceeded {
                completionHandler(output)
            }
        default:
            break
        }
    }
    
    func cancelContentEditing() {}
    
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool { return false }
    
    var shouldShowCancelConfirmation: Bool { return false }
}
