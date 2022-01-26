//
//  ViewController.swift
//  FatImagesGCD
//
//  Created by Alexander Rubtsov on 25.01.2022.
//

import UIKit

enum BigImages: String {
    case whale = "https://lh3.googleusercontent.com/16zRJrj3ae3G4kCDO9CeTHj_dyhCvQsUDU0VF0nZqHPGueg9A9ykdXTc6ds0TkgoE1eaNW-SLKlVrwDDZPE=s0#w=4800&h=3567"
    case shark = "https://lh3.googleusercontent.com/BCoVLCGTcWErtKbD9Nx7vNKlQ0R3RDsBpOa8iA70mGW2XcC76jKS09pDX_Rad6rjyXQCxngEYi3Sy3uJgd99=s0#w=4713&h=3846"
    case seaLion = "https://lh3.googleusercontent.com/ibcT9pm_NEdh9jDiKnq0NGuV2yrl5UkVxu-7LbhMjnzhD84mC6hfaNlb-Ht0phXKH4TtLxi12zheyNEezA=s0#w=4626&h=3701"
}

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var photoView: UIImageView!
    
    // MARK: Actions
    
    @IBAction func synchronousDownload(_ sender: UIBarButtonItem) {
        guard let url = URL(string: BigImages.seaLion.rawValue) else {
            return
        }
        
        do {
            let imgData = try Data(contentsOf: url)
            let image = UIImage(data: imgData)
            
            photoView.image = image
        } catch {
            print(error)
        }
    }
    
    @IBAction func simpleAsynchronousDownload(_ sender: UIBarButtonItem) {
        guard let url = URL(string: BigImages.shark.rawValue) else {
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imgData = try Data(contentsOf: url)
                let image = UIImage(data: imgData)
                
                DispatchQueue.main.async {
                    self.photoView.image = image
                }
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func asynchronousDownload(_ sender: UIBarButtonItem) {
        guard let url = URL(string: BigImages.whale.rawValue) else {
            return
        }
        
        downloadImage(url: url) { image in
            self.photoView.image = image
        }
    }
    
    @IBAction func setTransparencyOfImage(_ sender: UISlider) {
        photoView.alpha = CGFloat(sender.value)
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Functions
    
    func downloadImage(url: URL, _ closure: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.global().async {
            do {
                let imgData = try Data(contentsOf: url)
                
                if let strongImage = UIImage(data: imgData) {
                    DispatchQueue.main.async {
                        closure(strongImage)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
