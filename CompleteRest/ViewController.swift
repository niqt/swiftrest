//
//  ViewController.swift
//  CompleteRest
//
//  Created by Nicola De FIlippo on 04/10/2018.
//  Copyright © 2018 Nicola De FIlippo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let gitHubInfoController = GitHubInfoController()

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*gitHubInfoController.fetchGitHubInfo { (gitHubInfo) in
            if let gitHubInfo = gitHubInfo {
                DispatchQueue.main.async {
                    print(gitHubInfo.avatarUrl!.absoluteString)
                    self.avatar.image = UIImage(named: gitHubInfo.avatarUrl!.absoluteString)
                    self.labelName.text = gitHubInfo.name
                }
            }
        }*/
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        gitHubInfoController.fetchGitHubInfo { (gitHubInfo) in
            if let gitHubInfo = gitHubInfo {
                self.updateUI(with: gitHubInfo)
            }
        }
        
    }

    
    func updateUI(with gitHubInfo: GitHubInfo) {
        let task = URLSession.shared.dataTask(with: gitHubInfo.avatarUrl!,
                                              completionHandler: { (data, response, error) in
                                                if let data = data,
                                                    let image = UIImage(data: data) {
                                                    DispatchQueue.main.async {
                                                        self.labelName.text = gitHubInfo.name
                                                        self.avatar.image = image
                                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                    }
                                                }
        })
        task.resume()
 
    
    
    }

}
