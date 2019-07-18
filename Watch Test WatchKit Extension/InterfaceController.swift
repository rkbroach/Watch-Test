import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    
    @IBOutlet var displayLabel: WKInterfaceLabel!
    
    let session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        processApplicationContext()
        
        session.delegate = self
        session.activate()
    }
    
    @IBAction func buttonTapped() {
        //displayLabel.setText("Hello World!")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async() {
            self.processApplicationContext()
        }
    }
    
    func processApplicationContext() {
        if let iPhoneContext = session.receivedApplicationContext as? [String : Bool] {
            
            if iPhoneContext["switchStatus"] == true {
                displayLabel.setText("Switch On")
            } else {
                displayLabel.setText("Switch Off")
            }
        }
    }
}
