import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    @State var colorSchemeToggle = true
    
    let vibrationOfToggle = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(colorSchemeToggle ? Color("DarkBackground")  : Color("LightBackground"))
            
            VStack(spacing: 50){
                ZStack {
                    Color(self.colorSchemeToggle ? UIColor(Color("DarkGray")) : .white)
                        .cornerRadius(25)
                    
                    Image(colorSchemeToggle ? "moon" : "sun")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .offset(x: colorSchemeToggle ? 20 : -20)
                    
                    Circle()
                        .foregroundColor(Color("LightGray"))
                        .frame(width: 24, height: 24)
                        .offset(x: colorSchemeToggle ? -20 : 20)
                }
                .frame(width: 72, height: 32)
                .onTapGesture {
                    vibrationOfToggle.impactOccurred()
                    withAnimation(.default) {
                        self.colorSchemeToggle.toggle()
                    }
                }
                
                VStack {
                    Spacer()
                    
                    displayText()
                    
                    buttonsView()
                }
                .padding(Constants.padding)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func displayText() -> some View {
        Text(viewModel.displayText)
            .padding()
            .foregroundColor(colorSchemeToggle ? .white : .black)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)
            .minimumScaleFactor(0.2)
    }
    
    @ViewBuilder
    func buttonsView() -> some View {
        VStack(spacing: Constants.padding) {
            ForEach(viewModel.buttonTypes, id: \.self) { row in
                HStack(spacing: Constants.padding) {
                    ForEach(row, id: \.self) { buttonType in
                        DetailButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .environmentObject(CalculatorView.ViewModel())
    }
}
