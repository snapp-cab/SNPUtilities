//
//  Bundle.swift
//  Driver
//
//  Created by Behdad Keynejad on 7/17/1396 AP.
//  Copyright © 1396 AP Snapp. All rights reserved.
//

import Foundation

extension Bundle {
    static func load<T>(_ nibName: String = String(describing: T.self)) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! T
    }

    static func info(for key: String) -> String {
        return (Bundle.main.infoDictionary?[key] as! String).replacingOccurrences(of: "\\", with: "")
    }

    func read(fileName: String, type: String) -> String? {
        if let path = self.path(forResource: fileName, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return String(data: data, encoding: .utf8)
            } catch {
                return nil
            }
        }
        return nil
    }
}
