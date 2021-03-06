//
//  ViewController.swift
//  SDSC-Wifire
//
//  Created by Eric Fakhourian on 4/11/17.
//  Copyright © 2017 Eric Fakhourian. All rights reserved.
//

import UIKit

//Main view controller
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        DataService.instance.loadPosts()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onPostsLoaded(_:)), name: NSNotification.Name(rawValue: "postsLoaded"), object: nil)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    
//    var globalVar: Int = 0
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
//        globalVar = selectedIndex!.row
//        print("tableView prepareForSegue: " + String(globalVar))
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 125.0
    }
    
    //Detect which row are you tapping on the tableviewcell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print("Row: \(row)")
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "mystoryboard") as! ImageViewController
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        //print(meetingArray[row] as! String)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func onPostsLoaded(_ notif: AnyObject) {
        tableView.reloadData()
    }
    /*
    //------------------------newstuff
    func Tapped() {
        let myPickerController = UIImagePickerController()
        
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        myPickerController.allowsEditing = false
        self.present(myPickerController, animated: true, completion: nil)
    }
    */
    //------------------------newstuffdone
    
    //this func is commented out, this is for the camera in the 
    //main page
//    @IBAction func tapOnCamera(_ sender: UIButton!) {
//        imagePicker.sourceType = .camera
//        sender.setTitle("", for: .normal)
//        present(imagePicker, animated: true, completion: nil)
//    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismiss(animated: true, completion: nil)
    
        
        let imgPath = DataService.instance.saveImageAndCreatePath(image)
//        
        //let post = Post(imagePath: image)
//        DataService.instance.addPost(post)
    
    }
    
    
//    func saveImageWithImageData(data: NSData, properties: NSDictionary, completion: (_ data: NSData, _ path: NSURL) -> Void) {
//        
//        let imageRef: CGImageSourceRef = CGImageSourceCreateWithData((data as CFDataRef), nil)!
//        let uti: CFString = CGImageSourceGetType(imageRef)!
//        let dataWithEXIF: NSMutableData = NSMutableData(data: data as Data)
//        let destination: CGImageDestinationRef = CGImageDestinationCreateWithData((dataWithEXIF as CFMutableDataRef), uti, 1, nil)!
//        
//        CGImageDestinationAddImageFromSource(destination, imageRef, 0, (properties as CFDictionaryRef))
//        CGImageDestinationFinalize(destination)
//        
//        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [AnyObject]
//        let savePath: String = paths[0].appendingPathComponent("exif.jpg")
//        
//        let manager: FileManager = FileManager.default
//        manager.createFile(atPath: savePath, contents: dataWithEXIF as Data, attributes: nil)
//        
//        completion(dataWithEXIF,NSURL(string: savePath)!)
//        
//        print("image with EXIF info converting to NSData: Done! Ready to upload! ")
//        
//    }

}

