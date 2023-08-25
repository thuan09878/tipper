import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipSplitTextField: UITextField!
    @IBOutlet weak var totalSplitTextField: UITextField!
    
    var totalBill: Double? {
        return Double(totalBillTextField.text!)
    }
    
    var tipPercentage: Double = 0.15
    var numberOfPeople: Double = 1.0
    private var forrmater: NumberFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        totalBillTextField.delegate = self
        forrmater = NumberFormatter()
        forrmater.numberStyle = NumberFormatter.Style.decimal
        forrmater.minimum = 0
    }
    
    @IBAction func tipChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        tipPercentLabel.text = "\(sliderValue)%"
        tipPercentage = Double(Int(sender.value)) * 0.01
        updateInterface()
    }
    
    @IBAction func splitNumberChanged(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        numberOfPeople = Double(stepperValue)
        updateInterface()
    }
    
    @IBAction func totalBillChanged(_ sender: UITextField) {
        updateInterface()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        totalBillTextField.resignFirstResponder()
    }
    
    func updateInterface() {
        if let totalBill = self.totalBill {
            let totalWithTip = totalBill*tipPercentage + totalBill
            tipTextField.text = String(format: "$%.2f", (totalBill*tipPercentage))
            totalTextField.text = String(format: "$%.2f", totalWithTip)
            tipSplitTextField.text = String(format: "$%.2f", (totalBill*tipPercentage) / numberOfPeople)
            totalSplitTextField.text = String(format: "$%.2f", totalWithTip / numberOfPeople)

        }
    }
}

