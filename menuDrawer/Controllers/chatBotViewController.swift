//
//  chatBotViewController.swift
//  CIB
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import Speech
import AVKit
import InstantSearchVoiceOverlay
class chatBotViewController: UIViewController {
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputTypeView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var attachBtn: UIButton!
    @IBOutlet weak var onlinelabel: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
     let voiceOverlayController = VoiceOverlayController()
    let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

      var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
      var recognitionTask         : SFSpeechRecognitionTask?
      let audioEngine             = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()
        table_view.register(UINib(nibName: "chatTableViewCell", bundle: .main), forCellReuseIdentifier: "cell1")
         table_view.register(UINib(nibName: "chatHeaderTableViewCell", bundle: .main), forCellReuseIdentifier: "header")
        //btnStart.addTarget(self, action: Selector("holdRelease:"), for: UIControl.Event.touchUpInside);
        //btnStart.addTarget(self, action: Selector("HoldDown:"), for: UIControl.Event.touchDown)
        self.setupSpeech()
        setUpDesign()
       // voiceOverlayController.set
        // Do any additional setup after loading the view.
    }
    func HoldDown(sender:UIButton)
    {
       print("hold down")
    }

    func holdRelease(sender:UIButton)
    {
       print("hold release")
    }
    @IBAction func btnStartSpeechToText(_ sender: UIButton) {
        
        voiceOverlayController.start(on: self, textHandler: { (text, final,tx)  in
            self.inputField.text = String(describing: text)
                  print("voice output: \(String(describing: text))")
                  print("voice output: is it final? \(String(describing: final))")
              }, errorHandler: { (error) in
                  print("voice output: error \(String(describing: error))")
              })
         /*  if audioEngine.isRunning {
               self.audioEngine.stop()
               self.recognitionRequest?.endAudio()
               self.btnStart.isEnabled = false
               self.btnStart.setTitle("Start Recording", for: .normal)
           } else {
               self.startRecording()
               self.btnStart.setTitle("Stop Recording", for: .normal)
           }*/
       }

    func setUpDesign(){
        self.inputTypeView.layer.cornerRadius = self.inputTypeView.frame.height / 2
        self.inputTypeView.clipsToBounds = true
    }
    @IBAction func sendBtnPrsd(_ sender: UIButton) {
    }
    
    @IBAction func attachBtnPrsd(_ sender: UIButton) {
    }
    @IBAction func backBtnPrsd(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupSpeech() {

           self.btnStart.isEnabled = false
           self.speechRecognizer?.delegate = self

           SFSpeechRecognizer.requestAuthorization { (authStatus) in

               var isButtonEnabled = false

               switch authStatus {
               case .authorized:
                   isButtonEnabled = true

               case .denied:
                   isButtonEnabled = false
                   print("User denied access to speech recognition")

               case .restricted:
                   isButtonEnabled = false
                   print("Speech recognition restricted on this device")

               case .notDetermined:
                   isButtonEnabled = false
                   print("Speech recognition not yet authorized")
               }

               OperationQueue.main.addOperation() {
                   self.btnStart.isEnabled = isButtonEnabled
               }
           }
       }
    func startRecording() {

           // Clear all previous session data and cancel task
           if recognitionTask != nil {
               recognitionTask?.cancel()
               recognitionTask = nil
           }

           // Create instance of audio session to record voice
           let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
               try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
           } catch {
               print("audioSession properties weren't set because of an error.")
           }

           self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

           let inputNode = audioEngine.inputNode

           guard let recognitionRequest = recognitionRequest else {
               fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
           }

           recognitionRequest.shouldReportPartialResults = true

           self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

               var isFinal = false

               if result != nil {

                   self.inputField.text = result?.bestTranscription.formattedString
                   isFinal = (result?.isFinal)!
               }

               if error != nil || isFinal {

                   self.audioEngine.stop()
                   inputNode.removeTap(onBus: 0)

                   self.recognitionRequest = nil
                   self.recognitionTask = nil

                   self.btnStart.isEnabled = true
               }
           })

           let recordingFormat = inputNode.outputFormat(forBus: 0)
           inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
               self.recognitionRequest?.append(buffer)
           }

           self.audioEngine.prepare()

           do {
               try self.audioEngine.start()
           } catch {
               print("audioEngine couldn't start because of an error.")
           }

           self.inputField.text = "Say something, I'm listening!"
       }
}
extension chatBotViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:chatHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "header") as! chatHeaderTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:chatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! chatTableViewCell
        if indexPath.row == 0{
            cell.msgLabel.text = "Hi, Welcome to CIB. How can i help you?"
            cell.dateLabe.text = "01:00 AM"
            cell.setUpCellType(type: .incoming)
        }else{
            cell.msgLabel.text = "Yes i have a query regarding account"
            cell.dateLabe.text = "01:05 AM"
            cell.setUpCellType(type: .outgoing)
        }
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
extension UIView{
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}

extension chatBotViewController: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.btnStart.isEnabled = true
        } else {
            self.btnStart.isEnabled = false
        }
    }
}
