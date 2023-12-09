//
//  Onboarding.swift
//  Opium
//
//  Created by Sangeeta Papinwar on 11/08/23.
//

import SwiftUI
import Combine
import Web3Auth

struct Onboarding: View {
    var body: some View {
        NavigationView {
            FirstView()
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
        SecondView()
        ThirdView()
    }
}


struct FirstView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Simple.\nReliable.\nEffortless.")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(30)
                
                Spacer()
                
                HStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.primary)
                        .frame(width: 30)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.secondary)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    NavigationLink(destination: SecondView()) {
                            HStack {
                                Text("ENTER")
                                    .foregroundColor(Color("ourBlack"))
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .padding(.trailing, 5)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .foregroundColor(Color("ourBlack"))
                                    .fontWeight(.semibold)
                                    .frame(width: 25, height: 20)
                            }
                            
                    }
                    
                }
                .frame(height: 4)
                .padding(30)
                .padding(.bottom, 30)
            }
        }
            
        
    }
}



struct SecondView: View {
    
    @State private var cancellables: Set<AnyCancellable> = []

    @State private var connected: Bool = false
    @State private var status: String = "Offline"

    @State private var errorMessage = ""
    @State private var showError = false
    
    @EnvironmentObject var session: SessionModel

    @State private var showProgressView = false
    @State private var showToast = false
    private var useCoreKit: Bool = false
    
    private var clientID: String = "BDIwcnJZqBJ6prCXi2irSvSrELWVMCd0_DcVn1CBUEY7jn0La9FtA3zukzgjLzrvorJXSPBzrzNd5oEFvI0TaeI"
    private var network: Network = .sapphire_devnet
    private var buildEnv: BuildEnv = .staging
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("We want to\nmake sure it's really you.")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(30)
                
                Spacer()
             
                    Section {
                        Button(
                            action: {
                                session.login(provider: .GOOGLE)
                            }
                        ) {
                            ZStack {
                                HStack {
                                    
                                    Image("google_logo")
                                        .resizable()
                                        .frame(width: 27, height: 27)
                                        .saturation(0)
                                    
                                    Text("Continue with Google")
                                        .foregroundStyle(Color("ourBlack"))
                                
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(.gray, lineWidth: 2)
                                        .frame(width: 300)
                                )
                                .padding(.bottom)
                            }
                                
                        }
                        
                        }
                        .alert(isPresented: $showError) {
                            Alert(
                                title: Text("Error"),
                                message: Text(errorMessage)
                            )
                        }

        
                
                HStack {
                    Spacer()

                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.secondary)
                        .frame(width: 30)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.primary)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    
                }
                .frame(height: 4)
                .padding(30)
                .padding(.bottom, 30)
            }
            .onReceive(NotificationCenter.default.publisher(for: .Connection)) { notification in
                status = notification.userInfo?["value"] as? String ?? "Offline"
            }
        }
            
        
    }
}

struct ThirdView: View {
    @State var showToast = false
    
    @State var showIndicator = false
    @State var showTxn = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Image("safe_green")
                        .resizable()
                        .frame(width: 70, height: 70)
                    Spacer()
                }
                .padding(.leading, 20)
                
                HStack {
                    Text("Create a\ngnosis safe\ncontract")
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(30)
                
                Spacer()
                
                Section {
                    Group {
                        
                        if showIndicator {
                            ProgressView()
                                .controlSize(.large)
                        }
                        
                        if showTxn {
                            Link("https://goerli.basescan.org/tx/0x9fd71811c55854f1be12f8456f65428c64a007b7899f798a5b6664bde8948fde", destination: URL(string: "https://goerli.basescan.org/tx/0x9fd71811c55854f1be12f8456f65428c64a007b7899f798a5b6664bde8948fde")!)

                        }
                        
                        Button {
                            self.showIndicator = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                self.showIndicator = false
                                self.showTxn = true
                            }
                            
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.blue)
                                HStack {
                                    Text("Create Safe")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                        .padding(.trailing, 5)
                                    
                                }
                            }
                            .frame(width: 300, height: 60)
                        }
                        
                    }
                } footer: {
                    Text("You will be asked to accept a transation on metamask")
                        .font(.footnote)
                        .padding(.bottom, 50)
                        .frame(width: 320)
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(.secondary)
                        .frame(width: 30)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.secondary)
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                            HStack {
                                Text("ENTER")
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .padding(.trailing, 5)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .frame(width: 25, height: 20)
                            }
                            
                    }
                    
                }
                .frame(height: 4)
                .padding(30)
                .padding(.bottom, 30)
            }
        }
            
        
    }
}


extension Notification.Name {
    static let Event = Notification.Name("event")
    static let Connection = Notification.Name("connection")
}

