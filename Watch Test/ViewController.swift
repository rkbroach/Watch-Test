import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
    
    @IBOutlet var theSwitch: UISwitch!
    
    var session: WCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    func processApplicationContext() {
        if let iPhoneContext = session?.applicationContext as? [String : Bool] {
            if iPhoneContext["switchStatus"] == true {
                theSwitch.isOn = true
            } else {
                theSwitch.isOn = false
            }
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if let validSession = session {
            let iPhoneAppContext = ["switchStatus": sender.isOn]
            
            do {
                try validSession.updateApplicationContext(iPhoneAppContext)
            } catch {
                print("Something went wrong")
            }
        }
    }
}
