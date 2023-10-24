//
//  ContentView.swift
//  OTPTutorial
//
//  Created by Sanjeev Bharti on 10/22/23.
//

import SwiftUI
import Lottie

struct OTPView: View {
    
    @ObservedObject var viewModel: OTPViewModel
    
    var body: some View {
        
        NavigationView(content: {
            
            VStack(spacing: 30) {
                
                // Animating view which changes as per input. There are three states Initial(dot animation), Success(checkmark animation) and Error(cross animation)
                animatingHeaderView
                
                // Textfield with information text
                otpFieldView
                
                Spacer()
                
                // Resend Code Button
                footerView
            }
            .padding()
            .navigationTitle(OTPViewModel.Constant.pageTitleText.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $viewModel.showNextPage, content: {
                LottieView(name: OTPViewModel.Constant.Lottie.relax.rawValue, loopMode: .loop)
            })
        })
    }
    
    private var animatingHeaderView: some View {
        ZStack {
            dotsAnimationView
                .opacity(viewModel.showSuccessOrErrorView ? 0.0 : 1.0)
            
            if viewModel.showSuccessOrErrorView {
                successErrorAnimationView()
                    .onAppear(perform: {
                        
                        // Show next page after `Success` animation
                        if viewModel.status == true {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: DispatchWorkItem(block: {
                                viewModel.showNextPage.toggle()
                            }))
                        }
                    })
            }
        }
        .frame(height: 150.0)
    }
    
    private var otpFieldView: some View {
        VStack {
            TextField(OTPViewModel.Constant.textfieldPlaceHolderText.rawValue, text: $viewModel.otpText)
                .font(.title)
                .fontWeight(.semibold)
                .kerning(viewModel.textFieldRefreshed ? 15 : 0)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.otpText, initial: false) { oldValue, newValue in
                    updationsOn(newValue)
                }
            
            Divider().padding(.horizontal, 50.0)
            
            Text(OTPViewModel.Constant.infoText.rawValue)
            
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.vertical)
            
            if true {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
        .multilineTextAlignment(.center)
        .fontDesign(.rounded)
    }
    
    private var footerView: some View {
        Button(OTPViewModel.Constant.resendCodeText.rawValue) {
            // Reset entered text
            viewModel.otpText = ""
            
            //Note: API call to resend OTP
        }
        .font(.footnote)
        .bold()
        .foregroundStyle(.blue)
        .fontDesign(.rounded)
    }
    
    
    private var dotsAnimationView: some View {
        LottieView(name: OTPViewModel.Constant.Lottie.dots.rawValue, loopMode: .loop)
    }
    
    private func successErrorAnimationView() -> some View {
        LottieView(name: viewModel.status ? OTPViewModel.Constant.Lottie.success.rawValue : OTPViewModel.Constant.Lottie.failure.rawValue)
    }
    
    private func updationsOn(_ textChange: String) {
        
        // Max limit validation check
        if textChange.count > viewModel.maxLength {
            viewModel.otpText = String(textChange.prefix(viewModel.maxLength))
        }
        
        // Update view after text change in textfield
        viewModel.textFieldRefreshed = textChange.count <= 0 ? false : true
        
        // Show/Hide Error or Success view
        if textChange.count == viewModel.maxLength {
            
            viewModel.showLoader = true
            // Call API to validate OTP. Below is dummy code
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: DispatchWorkItem(block: {
                viewModel.showLoader = false
                viewModel.status = textChange.elementsEqual(OTPViewModel.Constant.testMatchText.rawValue)
                viewModel.showSuccessOrErrorView = true
            }))
        } else {
            viewModel.showSuccessOrErrorView = false
        }
    }
    
}

#Preview {
    OTPView(viewModel: OTPViewModel.sample)
}
