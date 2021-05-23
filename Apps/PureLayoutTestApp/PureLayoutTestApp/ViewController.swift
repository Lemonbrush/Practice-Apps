//
//  ViewController.swift
//  PureLayoutTestApp
//
//  Created by Александр on 24.05.2021.
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    
    //MARK: - Views
    
    var buttony: UIButton = {
        let buttony = UIButton()
        buttony.setTitle("Press Me", for: .normal)
        buttony.setTitleColor(.white, for: .normal)
        buttony.setTitleColor(.green, for: .highlighted)
        buttony.backgroundColor = .black
        buttony.layer.cornerRadius = 25
        buttony.layer.cornerCurve = .continuous
        buttony.addTarget(self, action: #selector(animate), for: .touchUpInside)
        
        return buttony
    }()
    
    let redView: UIView = {
        
        let view = UIView.newAutoLayout()
        view.layer.cornerRadius = 25
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .red
        
        return view
    }()
    
    let blueView: UIView = {
        
        let view = UIView.newAutoLayout()
        view.layer.cornerRadius = 25
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .blue
        
        return view
    }()
    
    //MARK: - Variables and other properties
    
    var isAnimated = false
    
    var firstLayoutState: NSArray?
    var secondLayoutState: NSArray?
    
    var didSetupConstraints = false

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(buttony)
        
        redView.setNeedsUpdateConstraints()
    }
    
    //MARK: - animation and layout
    
    @objc func animate() {
       
        isAnimated = !isAnimated
        
        //Toggle animation states according to the state
        if isAnimated {
            secondLayoutState?.autoRemoveConstraints()
            firstLayoutState?.autoInstallConstraints()
        } else {
            firstLayoutState?.autoRemoveConstraints()
            secondLayoutState?.autoInstallConstraints()
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func updateViewConstraints() {
        
        let uniSize = CGSize(width: 100, height: 100)

        if !didSetupConstraints {
            
            buttony.autoSetDimensions(to: uniSize)
            blueView.autoSetDimensions(to: uniSize)
            redView.autoSetDimensions(to: uniSize)
            
            //Populate the first array of constraints for the first animation state
            firstLayoutState = NSLayoutConstraint.autoCreateConstraintsWithoutInstalling{
                
                buttony.autoCenterInSuperview()
                
                redView.autoPinEdge(toSuperviewSafeArea: .top)
                redView.autoAlignAxis(toSuperviewAxis: .vertical)
                
                blueView.autoPinEdge(toSuperviewSafeArea: .bottom)
                blueView.autoAlignAxis(.vertical, toSameAxisOf: redView)
                
            } as NSArray?
            
            //Populate the second array of constraints for the first animation state
            secondLayoutState = NSLayoutConstraint.autoCreateAndInstallConstraints {
                
                buttony.autoCenterInSuperview()
                redView.autoCenterInSuperview()
                blueView.autoCenterInSuperview()
                
            } as NSArray?
            
        }
        
        super.updateViewConstraints()
    }
    
}

