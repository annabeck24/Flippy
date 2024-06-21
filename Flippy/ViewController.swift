import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    var flipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let selectPhotoButton = UIButton(frame: CGRect(x: 50, y: 450, width: 300, height: 50))
        selectPhotoButton.setTitle("Select Photo", for: .normal)
        selectPhotoButton.backgroundColor = .blue
        selectPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        view.addSubview(selectPhotoButton)
        
        flipButton = UIButton(frame: CGRect(x: 50, y: 520, width: 300, height: 50))
        flipButton.setTitle("Flip Photo", for: .normal)
        flipButton.backgroundColor = .red
        flipButton.addTarget(self, action: #selector(flipPhoto), for: .touchUpInside)
        flipButton.isHidden = true
        view.addSubview(flipButton)
    }
    
    @objc func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            flipButton.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func flipPhoto() {
        if let image = imageView.image {
            imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .upMirrored)
        }
    }
}
