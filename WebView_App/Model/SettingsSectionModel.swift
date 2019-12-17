//
//  SettingsSectionModel.swift
//  WebView_App
//
//  Created by 深見龍一 on 2019/12/11.
//  Copyright © 2019 深見龍一. All rights reserved.
//

import UIKit
import RxDataSources

typealias SettingsSectionModel = SectionModel<SettingsSection, SettingsItem>

enum SettingsSection
{
    case account
    case common
    
    var headerHeihgt: CGFloat{return 40.0}
    var footerHeight: CGFloat{return 1.0}
}

enum SettingsItem
{
    case account
    case security
    case notification
    case contents
    case sounds
    case dataUsing
    case accessibility
    
    case description(test: String)
    
    var title: String?
    {
        switch self {
            case .account:
                return "アカウント"
            case .security:
                return "セキュリティー"
            case .notification:
                return "通知"
            case .contents:
                return "コンテンツ設定"
            case .sounds:
                return "サウンド設定"
            case .dataUsing:
                return "データ利用時の設定"
            case .accessibility:
                return "アクセシビリティ"
            case .description:
                return nil
        }
    }
    
    var rowHeight: CGFloat
    {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType
    {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}

