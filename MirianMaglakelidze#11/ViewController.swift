//შექმენით აპლიკა, რომელსაც ექნება:
//სამი ცალი ლეიბლი, რენდომ რიცხვების მნიშვნელობით
//სლაიდერი, რომელიც განსაზღვრავს ლეიბლებზე გამოსახული რენდომ რიცხვების რეინჯს
//ტექსტფილდი, სადაც მომხმარებელი შეიყვანს სამ მნიშვნელობას: “maximum”, “average”, “sum” (მაგ.: maximum -ის შეყვანის შემთხვევაში, ამ რიცხვებიდან მაქსიმუმი აიღოს, თქვენ განსაზღვრეთ edge case-ები)
//მეოთხე ლეიბლი, სადაც აჩვენებთ წინა პუნქტის შედეგს

import UIKit

// storyBoard აწყობილია iPone 11 Pro Max _ ზე

class ViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var resultBt: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var firstRandomNumberLb: UILabel!
    @IBOutlet weak var secondRandomNumberLb: UILabel!
    @IBOutlet weak var thirdRandomNumberLb: UILabel!
    @IBOutlet weak var resultLb: UILabel!
    @IBOutlet weak var sliderForRange: UISlider!
    @IBOutlet weak var sliderMinValue: UILabel! {
        didSet {
            self.sliderMinValue.text = "\(sliderForRange.minimumValue)"
        }
    }
    @IBOutlet weak var sliderMaxValue: UILabel! {
        didSet {
            self.sliderMaxValue.text = "\(sliderForRange.maximumValue)"
        }
    }
    // MARK: - properties
    var randomNumber: Double {
        Double.random(in: 0...Double(sliderForRange.value)).rounded()
    }
    // Array for saving lable numbers
    var arrayOfdouble: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderForRange.setValue(100, animated: true)
        setButtonDesign()
        defaultViewDisplay()
    }
    
    // MARK: - IBActions
    @IBAction func result(_ sender: UIButton) {
        resultLb.isHidden = false
        if let result = getResult(text: textField.text ?? "") {
            resultLb.text = "\(textField.text!.uppercased()) IS: \(result)"
        } else {
            resultLb.text = "Please enter correct word"
        }
    }
    @IBAction func setRangeForRandomNumber(_ sender: UISlider) {
        updateLabelsValue()
        if !resultLb.isHidden {
            defaultViewDisplay()
        }
    }
    // MARK: - class methods
    func updateLabelsValue() {
        arrayOfdouble.removeAll()
        firstRandomNumberLb.text = "\(randomNumber)"
        secondRandomNumberLb.text = "\(randomNumber)"
        thirdRandomNumberLb.text = "\(randomNumber)"
        arrayOfdouble.append(contentsOf: [Double(firstRandomNumberLb.text!)!, Double(secondRandomNumberLb.text!)!, Double(thirdRandomNumberLb.text!)!])
    }
    // Class method that returns the view to its original position
    func defaultViewDisplay() {
        updateLabelsValue()
        textField.text = ""
        resultLb.isHidden = true
        
    }
    func setButtonDesign() {
        resultBt.layer.cornerRadius = 10
        resultBt.tintColor = .black
    }
    func getResult(text: String) -> Double? {
        switch text.lowercased() {
        case "maximum":
            return arrayOfdouble.max()!
        case "average":
            return (arrayOfdouble.reduce(0) { $0 + $1 } / Double(arrayOfdouble.count)).rounded()
        case "sum":
            return arrayOfdouble.reduce(0) { $0 + $1 }
        default:
            return nil
        }
    }
}

