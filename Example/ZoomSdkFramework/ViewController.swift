//
//  ViewController.swift
//  ZoomSdkFramework
//
//  Created by Mohamed-AbdulRaouf on 03/29/2022.
//  Copyright (c) 2022 Mohamed-AbdulRaouf. All rights reserved.
//

import UIKit
import MobileRTC

class ViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
//        if #available(iOS 15.0, *) {
//            printContent(MobileRTC.shared().supportedLanguages())
//        } else {
//            // Fallback on earlier versions
//        }
//        MobileRTC.shared().setLanguage("ru")
//        MobileRTC.shared().setMobileRTCCustomLocalizableName("Localizable")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBOutlets
    @IBAction func joinAMeetingButtonPressed(_ sender: UIButton) {
        presentJoinMeetingAlert()
    }
    
    func presentJoinMeetingAlert() {
        let alertController = UIAlertController(title: "Join meeting", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting number"
            textField.keyboardType = .phonePad
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Meeting password"
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
        }
        let joinMeetingAction = UIAlertAction(title: "Join meeting", style: .default, handler: { alert -> Void in
            let numberTextField = alertController.textFields![0] as UITextField
            let passwordTextField = alertController.textFields![1] as UITextField

            if let meetingNumber = numberTextField.text, let password = passwordTextField.text {
                self.joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(joinMeetingAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startAnInstantMeetingButtonPressed(_ sender: UIButton) {
        startMeetingZak()
    }
    
        func joinMeeting(meetingNumber: String, meetingPassword: String) {
                if let meetingService = MobileRTC.shared().getMeetingService() {
                    meetingService.delegate = self
                    let joinMeetingParameters = MobileRTCMeetingJoinParam()
                    joinMeetingParameters.meetingNumber = meetingNumber
                    joinMeetingParameters.password = meetingPassword
                    meetingService.joinMeeting(with: joinMeetingParameters)
                }
            }
    
    func startMeetingZak() {
        if let meetingService = MobileRTC.shared().getMeetingService() {
            meetingService.delegate = self
            let startMeetingParams = MobileRTCMeetingStartParam4WithoutLoginUser()
            startMeetingParams.zak = "" // TODO: Enter ZAK
            startMeetingParams.userID = "" // TODO: Enter userID
            startMeetingParams.userName = "" // TODO: Enter your name
            meetingService.startMeeting(with: startMeetingParams)
        }
    }
}

// 1. Extend the ViewController class to adopt and conform to MobileRTCMeetingServiceDelegate. The delegate methods will listen for updates from the SDK about meeting connections and meeting states.
extension ViewController: MobileRTCMeetingServiceDelegate {
    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        switch error {
        case .passwordError: //MobileRTCMeetError_PasswordError:
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            print("Could not join or start meeting with MobileRTCMeetError: (error) \(message ?? "")")
        }
    }
    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }
    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        print("Current meeting state: (state)")
    }
}
