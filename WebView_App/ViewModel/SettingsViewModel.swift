//
//  SettingsViewModel.swift
//  WebView_App
//
//  Created by 深見龍一 on 2019/12/11.
//  Copyright © 2019 深見龍一. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel
{
    public var items = BehaviorRelay<[SettingsSectionModel]>(value: [])
    var itemsObservable: Observable<[SettingsSectionModel]>{return items.asObservable()}
    
    func setUp()
    {
        updateItems()
    }
    
    public func updateItems()
    {
        let sections: [SettingsSectionModel] =
        [
            self.accountSession(),
            self.commonSection()
        ]
        self.items.accept(sections)
    }
    
    private func accountSession() -> SettingsSectionModel
    {
        let items: [SettingsItem] =
        [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingsSectionModel
    {
        let items:[SettingsItem] =
        [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(test: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
}
