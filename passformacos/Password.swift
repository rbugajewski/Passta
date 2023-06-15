//
//  Password.swift
//  passformacos
//
//  Created by rb on 15.06.23.
//  Copyright © 2023 Rafael Bugajewski. All rights reserved.
//

import Foundation

class Password {
    static let LoginPrefix = "login:"

    let container: [String]

    init(container: [String]) {
        self.container = container
    }

    /// Parses unencrypted container until it finds a line with the prefix `Password.LoginPrefix`, if not found naively returns the value
    /// of the second line, or an empty string.
    /// - Returns: Login if found, empty string otherwise.
    func parseLogin() -> String {
        guard container.count > 1 else { return "" }

        guard let login = container.first(where: { line in
            line.lowercased().hasPrefix(Password.LoginPrefix)
        })?.deletingPrefix(Password.LoginPrefix)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            if container[1].count > 0  {
                let loginDirty = container[1].drop(while: {$0 != ":"})

                return String(loginDirty.dropFirst()).trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                return ""
            }
        }

        return login
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String? {
        guard self.hasPrefix(prefix) else { return nil }

        return String(self.dropFirst(prefix.count))
    }
}
