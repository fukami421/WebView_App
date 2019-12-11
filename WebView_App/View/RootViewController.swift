//
//  RootViewController.swift
//  WebView_App
//
//  Created by 深見龍一 on 2019/12/11.
//  Copyright © 2019 深見龍一. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableBtn: UIButton!
    @IBOutlet weak var webBtn: UIButton!
    
    let webVC =  WebViewController.init(nibName: nil, bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNav()
        self.bind()
    }
    
    private func setUpNav()
    {
        self.title = "root"
    }

    private func bind()
    {
        self.webBtn.rx.tap
        .subscribe { [unowned self] _ in
            self.navigationController?.pushViewController(self.webVC, animated: true)//遷移する
            print("")
        }
        .disposed(by: self.disposeBag)    }
}
