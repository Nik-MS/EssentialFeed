//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Nikhil Menon on 3/28/24.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
