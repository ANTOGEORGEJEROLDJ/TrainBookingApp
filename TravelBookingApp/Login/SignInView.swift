//
//  SignInScreen.swift
//  TravelBookingApp
//
//  Created by Paranjothi iOS MacBook Pro on 13/06/25.
//

import SwiftUI
import FirebaseAuth
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import CryptoKit

struct SignInScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    private let appleLoginManager = AppleSignInManager()
    
    @State private var UserName = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var navigationToSelectNewsScreen = false
    @State private var isSignedIn = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("loginImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 175, height: 175)
                        .padding(.top)
                    
                    Text("Login to continue")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.5))
                    
                    VStack(spacing: 20) {
                        CustomTextField(icon: "person.fill", placeHolder: "UserName", text: $UserName)
                        CustomTextField(icon: "envelope.fill", placeHolder: "Email", text: $email)
                        CustomTextField(icon: "lock.fill", placeHolder: "Password", text: $password)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Navigation Link
                    NavigationLink(
                        destination: SelectingView()
                            .environment(\.managedObjectContext, viewContext),
                        isActive: $navigationToSelectNewsScreen
                    ) {
                        EmptyView()
                    }

                    VStack{
                        // Register Button
                        Button(action: {
                            registerWithEmail()
                        }) {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .bold()
                                .background(Color.orange.opacity(0.4))
                                .foregroundColor(.black.opacity(0.7))
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal)
                        
                        // Social Login
                        HStack(spacing: 20) {
                            // Google
                            Button(action: {
                                handleGoogleSignIn()
                            }) {
                                Image("google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 19, height: 19)
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .background(Color.orange.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                            // Apple
                            Button(action: {
                                appleLoginManager.startSignInWithAppleFlow()
                            }) {
                                Image("apple")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 19, height: 19)
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .background(Color.orange.opacity(0.3))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                        .padding(.top, 30)
                    }.padding()
                        .padding(.top, 20)
                }
            }
        }
    }

    // MARK: - Email Register
    func registerWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email or password empty")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration failed: \(error.localizedDescription)")
                return
            }

            // Set display name
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.UserName
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Failed to set display name: \(error.localizedDescription)")
                } else {
                    print("✅ Display name set")
                    self.navigationToSelectNewsScreen = true
                }
            }
        }
    }

    // MARK: - Email Login
    func signInWithEmail() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                return
            }

            self.UserName = Auth.auth().currentUser?.displayName ?? ""
            self.navigationToSelectNewsScreen = true
        }
    }

    // MARK: - Google Sign-In
    func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
            if let error = error {
                print("❌ Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            guard let result = result,
                  let idToken = result.user.idToken?.tokenString else { return }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("❌ Firebase Sign-In failed: \(error.localizedDescription)")
                } else {
                    self.UserName = authResult?.user.displayName ?? "Google User"
                    self.email = authResult?.user.email ?? ""
                    self.navigationToSelectNewsScreen = true
                    print("✅ Google Sign-In Success: \(authResult?.user.email ?? "")")
                }
            }
        }
    }
}

// MARK: - Apple Sign-In Manager
@available(iOS 13.0, *)
class AppleSignInManager: NSObject {
    func startSignInWithAppleFlow() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

@available(iOS 13.0, *)
extension AppleSignInManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIWindow()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // TODO: Handle Apple sign-in response
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Apple Sign-In Failed: \(error.localizedDescription)")
    }
}

#Preview {
    SignInScreen()
}


// Login Button
//                    Button(action: {
//                        signInWithEmail()
//                    }) {
//                        Text("Login")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .bold()
//                            .background(Color.green.opacity(0.4))
//                            .foregroundColor(.black.opacity(0.7))
//                            .cornerRadius(15)
//                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
//                    }
//                    .padding(.top, 25)
//                    .padding(.horizontal)
