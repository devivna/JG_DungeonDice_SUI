//
//  ContentView.swift
//  DungeonDice
//
//  Created by Students on 03.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...rawValue)
        }
        func message() -> String {
            return "You rolled a \(roll()) on a \(rawValue)-sided dice"
        }
    }
    @State private var mainTitle = "Dungeon Dice"
    @State private var resultMessage = ""
    
    @State private var buttonsLeftOver = 0
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 10
    let buttonWidth: CGFloat = 150
            
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                titleView
                
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                buttonsTableView
                
                HStack(alignment: .center, spacing: spacing) {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { number in
                        Button {
                            resultMessage = number.message()
                        } label: {
                            Text("\(number.rawValue)-sided")
                        }
                        .frame(width: buttonWidth)
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding()
            .onAppear {
                arangeGridItems(deviceWidth: geo.size.width)
                print("A")
            }
            .onChange(of: geo.size.width, perform: { _ in
                arangeGridItems(deviceWidth: geo.size.width)
                print("C")
            })
        }
    }
    
    func arangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - (horizontalPadding * 2)
        
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        let numberOfButtonPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonPerRow
        print(numberOfButtonPerRow)
        print(buttonsLeftOver)
    }
    
}

extension ContentView {
   private var titleView: some View {
        Text(mainTitle)
            .font(Font.custom("Snell Roundhand", size: 50))
            .fontWeight(.heavy)
            .foregroundColor(.cyan)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.title)
    }
    
    private var buttonsTableView: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)
        ], alignment: .center) {
            ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { number in
                Button {
                    resultMessage = number.message()
                } label: {
                    Text("\(number.rawValue)-sided")
                }
                .frame(width: buttonWidth)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
