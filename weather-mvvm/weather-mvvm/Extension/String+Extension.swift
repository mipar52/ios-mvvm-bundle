//
//  String+Extension.swift
//  weather-mvvm
//
//  Created by Milan Parađina on 09.06.2023..
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
