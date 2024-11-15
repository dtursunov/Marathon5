//
//  ViewController.swift
//  Marathon5
//
//  Created by Diyor Tursunov on 15/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var popoverViewController = PopoverViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector (buttonTapped(_ :)), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        popoverViewController.preferredContentSize = .init(width: 300, height: 280)
        popoverViewController.modalPresentationStyle = .popover
        
        let popoverPresentationController = popoverViewController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceRect = sender.bounds
        popoverPresentationController?.sourceView = sender
        popoverPresentationController?.delegate = self
        
        // 5. Present the popover view controller
        present(popoverViewController, animated: true, completion: nil)
    }
}

class PopoverViewController: UIViewController {

    let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["280pt", "150pt"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        segmentedControl.selectedSegmentIndex = 0

        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector (buttonTapped(_ :)), for: .touchUpInside)
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        preferredContentSize = .init(width: 300, height: selectedIndex == 0 ? 280 : 150)
    }

}


extension ViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        // Return no adaptive presentation style,
        // use default presentation behaviour
        return .none
    }
}
