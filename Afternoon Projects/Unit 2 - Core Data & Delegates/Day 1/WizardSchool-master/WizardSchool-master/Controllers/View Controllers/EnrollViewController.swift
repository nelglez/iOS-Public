//
//  SignUpViewController.swift
//  WizardSchool-master
//
//  Copyright © 2018 DevMountain. All rights reserved.
//

import UIKit


protocol EnrollViewControllerDelegate: class  {
    
    /**
    Passes a wizard to the delegate.
    - parameter wizard: The wizard to pass.
    */
    func wizardCreated(wizard: Wizard)
}

class EnrollViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedTrait: Trait?
    var selectedTraitButton: UIButton?
    var selectedWand: Wand?
    var selectedWandButton: UIButton?
    weak var delegate: EnrollViewControllerDelegate?
    @IBOutlet weak var wizardNameTextField: UITextField!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatButtons()
    }
    
    // MARK: - Actions
    
    /**
    Calls on the WizardController to instantiate a wizard. Informs the delegate and passes the wizard.
     */
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Unwrap the input from the user.
        guard let wizardName = wizardNameTextField.text, !wizardName.isEmpty,
            let trait = selectedTrait,
            let wand = selectedWand
            else { return }
        
        // Initialize a new Wizard
        let wizard = WizardController.enroll(name: wizardName, with: wand, and: trait)
        
        // Call our delegate function to inform the parent that a wizard was created
        delegate?.wizardCreated(wizard: wizard)
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Sets the selectedWand property on the EnrollViewController based on the sender's restoration identifier.
     - parameter sender: The button tapped.
    */
    @IBAction func wandButtonTapped(_ sender: UIButton) {
        
        if let selectedWandButton = selectedWandButton {
            inverseColor(for: selectedWandButton)
        }
        
        inverseColor(for: sender)
        var selectedWand: Wand?
        
        switch sender.restorationIdentifier {
        case "almond" :
            selectedWand = .almond
        case "mahogany":
            selectedWand = .mahogany
        case "walnut":
            selectedWand = .walnut
        case "oak":
            selectedWand = .oak
            
        default:
            print("Something went wrong.")
        }
        
        self.selectedWand = selectedWand
        self.selectedWandButton = sender
    }
    
    /**
     Sets the selectedTrait property on the EnrollViewController based on the sender's restoration identifier.
     - parameter sender: The button tapped.
     */
    @IBAction func traitButtonTapped(_ sender: UIButton) {
        
        if let selectedTraitButton = selectedTraitButton {
            inverseColor(for: selectedTraitButton)
        }
        
        self.selectedTraitButton = sender
        inverseColor(for: sender)
        var selectedTrait: Trait?
        
        switch sender.restorationIdentifier {
        case "cunning":
            selectedTrait = .cunning
        case "loyal":
            selectedTrait = .loyal
        case "brave":
            selectedTrait = .brave
        case "intelligent":
            selectedTrait = .intelligent
        default:
            print("Something went wrong.")
        }
        
        self.selectedTrait = selectedTrait
    }
}

extension EnrollViewController {
    
    /**
     Inverts the button's background/text color.
     - parameter button:
     */
    func inverseColor(for button: UIButton) {
        let backgroundColor = button.backgroundColor
        let fontColor = button.titleLabel?.textColor
        
        button.backgroundColor = fontColor
        button.setTitleColor(backgroundColor, for: .normal)
        print("break")
    }
    
    /**
     Formats each button in the buttons outlet collection on EnrollViewController.
     */
    func formatButtons() {
        for button in buttons {
            button.layer.cornerRadius = 10
            button.layer.borderColor = button.backgroundColor?.cgColor
            button.layer.borderWidth = 2
        }
    }
}