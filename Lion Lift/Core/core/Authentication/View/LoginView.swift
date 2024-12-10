import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage = ""
    @State private var isLoading: Bool = false

    @State private var navigateToSignup = false
    @State private var navigateToForgotPassword = false
    @State private var navigateToMainTab = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    

    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Text("Login")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text("Incorrect username or password, please try again")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    

                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Password", text: $password)
                        .modifier(TextFieldModifier())
                    
                    Button {
                        
                    } label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.trailing, 24)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }


                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Button {
                            viewModel.login(withEmail: email, password: password)
                        } label: {
                            Text("Log In")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 360, height: 44)
                                .background(.white)
                                .cornerRadius(8)
                                .padding(.vertical)
                        }
                    }

                    Spacer()
                    
                    Spacer()

                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Don't have an account? ")
                            .font(.caption)
                            .foregroundStyle(.black) +
                        
                        Text("Sign Up")
                            .foregroundStyle(.white)
                            .font(.caption)
                            .bold()
                    }
                }
            }
            .onAppear() {
                viewModel.errorMessage = ""
            }
        }
        .tint(.black)
    }
}
