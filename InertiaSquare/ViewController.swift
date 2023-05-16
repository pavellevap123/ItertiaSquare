//
//  ViewController.swift
//  InertiaSquare
//
//  Created by Pavel Paddubotski on 16.05.23.
//

import UIKit

class ViewController: UIViewController {
    private var animator: UIDynamicAnimator!
    
    private lazy var movingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movingView)
        movingView.center.x = view.bounds.width / 2
        movingView.center.y = view.bounds.height / 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: view)
        
        animator.removeAllBehaviors()
        
        let springBehavior = UIAttachmentBehavior(item: movingView, attachedToAnchor: tapLocation)
        springBehavior.length = 0
        springBehavior.damping = 0.7
        springBehavior.frequency = 2.0
        animator.addBehavior(springBehavior)
        
        let snapBehavior = UISnapBehavior(item: movingView, snapTo: tapLocation)
        //snapBehavior.damping = 0.7
        animator.addBehavior(snapBehavior)
    }
}
