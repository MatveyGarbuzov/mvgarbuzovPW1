//
//  ViewController.swift
//  mvgarbuzovPW1
//
//  Created by Matvey Garbuzov on 12.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Fields
    let heightOfScreen = UIScreen.main.bounds.height
    let widthOfScreen = UIScreen.main.bounds.width
    let leftInset: CGFloat = 10.0
    let rightInset: CGFloat = -10.0

    private lazy var button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var views: [UIView] = {
        var views: [UIView] = []
        for _ in 0...7 {
            let view = UIView()
            views.append(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        return views
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupButton()
        setupViews()
    }
    
    // MARK: - Private func
    
    private func changeColorAndRadiusOfViews() {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        
        for view in views {
            UIView.animate(withDuration: 1, animations: {
                view.backgroundColor = set.popFirst()
                view.layer.cornerRadius = .random(in: 0...30)
            })
            
        }
    }
    
    func setupViews() {
        for myView in views {
            view.addSubview(myView)
        }
        
        changeColorAndRadiusOfViews()
        
        NSLayoutConstraint.activate([
            views[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset),
            views[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            views[0].widthAnchor.constraint(equalToConstant: widthOfScreen * 0.3),
            views[0].heightAnchor.constraint(equalToConstant: heightOfScreen/3),
            
            views[1].leadingAnchor.constraint(equalTo: views[0].trailingAnchor, constant: 30),
            views[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightInset),
            views[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            views[1].heightAnchor.constraint(equalToConstant: heightOfScreen/3),
            
            views[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset),
            views[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightInset),
            views[2].topAnchor.constraint(equalTo: views[0].bottomAnchor, constant: 30),
            views[2].heightAnchor.constraint(equalToConstant: heightOfScreen/9),
            
            views[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset),
            views[3].topAnchor.constraint(equalTo: views[2].bottomAnchor, constant: 30),
            views[3].widthAnchor.constraint(equalToConstant: widthOfScreen * 2 / 3),
            views[3].heightAnchor.constraint(equalToConstant: heightOfScreen / 8),
            
            views[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset),
            views[4].topAnchor.constraint(equalTo: views[3].bottomAnchor, constant: 30),
            views[4].widthAnchor.constraint(equalToConstant: widthOfScreen / 3 - 15),
            views[4].heightAnchor.constraint(equalToConstant: heightOfScreen / 8),
            
            views[5].leadingAnchor.constraint(equalTo: views[4].trailingAnchor, constant: 30),
            views[5].topAnchor.constraint(equalTo: views[3].bottomAnchor, constant: 30),
            views[5].heightAnchor.constraint(equalToConstant: heightOfScreen / 8),
            views[5].widthAnchor.constraint(equalToConstant: widthOfScreen / 3 - 15),
            
            views[6].leadingAnchor.constraint(equalTo: views[5].trailingAnchor, constant: 30),
            views[6].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: rightInset),
            views[6].topAnchor.constraint(equalTo: views[2].bottomAnchor, constant: 30),
            views[6].bottomAnchor.constraint(equalTo: button.topAnchor, constant: -30)
        ])
    }
    
    func setupButton() {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        button.setTitle("Press to change color and corner radius", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15.0
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIView?) {
        guard let button = sender as? UIButton else { return }
        button.isEnabled = false
        button.alpha = 0.7
        
        UIView.animate(withDuration: 1, animations: {
            self.changeColorAndRadiusOfViews()
            button.alpha = 1
        }) { completion in
            button.isEnabled = true
        }
    }
}
