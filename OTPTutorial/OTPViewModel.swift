//
//  OTPViewModel.swift
//  OTPTutorial
//
//  Created by Sanjeev Bharti on 10/23/23.
//

import Foundation

final class OTPViewModel: ObservableObject {
    
    // Static values on OTP view
    enum Constant: String {
        
        case pageTitleText = "OTP View"
        case infoText = "Your one-time verification code is sent to registered mobile number ending **65."
        case resendCodeText = "Resend Code"
        case textfieldPlaceHolderText = "Enter OTP"
        case testMatchText = "123123"
        
        enum Lottie: String {
            case dots = "dots"
            case success = "checkmark"
            case failure = "cross"
            case relax = "relax"
        }
        
    }
    
    // Textfield text information
    @Published var otpText: String = ""
    
    // Refresh status monitor for textfield
    @Published var textFieldRefreshed = false
    
    // Text match status
    @Published var status = false
    
    // Show success or error animation
    @Published var showSuccessOrErrorView = false
    
    @Published var showNextPage = false
    
    // Show/Hide Loader
    @Published var showLoader = false
    
    // Max characters length
    var maxLength: Int = 6
    
}

extension OTPViewModel {
    
    static var sample: OTPViewModel {
        return OTPViewModel()
    }
}
