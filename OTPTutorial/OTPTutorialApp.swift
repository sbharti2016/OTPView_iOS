//
//  OTPTutorialApp.swift
//  OTPTutorial
//
//  Created by Sanjeev Bharti on 10/22/23.
//

import SwiftUI

@main
struct OTPTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            OTPView(viewModel: OTPViewModel())
        }
    }
}
