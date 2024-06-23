//
//  HamburgerMenuViewController.swift
//  BudgetBuddy
//
//  Created by 柴田健作 on 2024/06/22.
//

import UIKit

class HamburgerMenuViewController: UIViewController {
    private var menuViewWidth: CGFloat = 0.0
    
    private let outView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkGray
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var menuViewLeadingAnchor: NSLayoutConstraint?
    private let menuView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Menu
    private let headerViewHeight: CGFloat = 180
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let footerViewHeight: CGFloat = 60
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray3
        self.menuViewWidth = UIScreen.main.bounds.width * 0.7
        
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.openThisView()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .clear
        self.view.addSubview(outView)
        self.view.addSubview(menuView)
        
        menuViewLeadingAnchor = menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -self.menuViewWidth)
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: self.view.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            menuViewLeadingAnchor!,
            menuView.widthAnchor.constraint(equalToConstant: self.menuViewWidth),
            
            outView.topAnchor.constraint(equalTo: self.view.topAnchor),
            outView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            outView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            outView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // Menu
        menuView.addSubview(mainView)
        menuView.addSubview(headerView)
        menuView.addSubview(footerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: menuView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
            
            mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: footerViewHeight),
            footerView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor)
        ])
        
        // MARK: - GESTURE
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanGesture(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
        let outViewTapped = UITapGestureRecognizer(target: self, action: #selector(outViewTapped(_:)))
        outView.isUserInteractionEnabled = true
        outView.addGestureRecognizer(outViewTapped)
    }
    
    // MARK: - Event
    private func openThisView() {
        self.menuViewLeadingAnchor!.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.outView.alpha = 0.8
        })
    }
    
    private func closeThisView() {
        self.menuViewLeadingAnchor!.constant = -self.menuViewWidth
        UIView.animate(withDuration: 0.4, animations: {
            self.outView.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    // MARK: - ActionEvent
    @objc func outViewTapped(_ gesture: UITapGestureRecognizer) {
        self.closeThisView()
    }
    
    @objc private func viewPanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        switch gesture.state {
        case .began, .changed:
            break
        case .ended:
            if translation.x < 0  {
                self.closeThisView()
            }
        default:
            break
        }
    }
}