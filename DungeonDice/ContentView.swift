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
                Text(mainTitle)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
                
                Text(resultMessage)
                    .font(.title)
                
                Spacer()
                
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
                arangeGridItems(geo: geo)
                print("A")
            }
            .onChange(of: geo.size.width, perform: { _ in
                arangeGridItems(geo: geo)
                print("C")
            })
        }
    }
    
    func arangeGridItems(geo: GeometryProxy) {
        var screenWidth = geo.size.width - (horizontalPadding * 2)
        
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        let numberOfButtonPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonPerRow
        print(numberOfButtonPerRow)
        print(buttonsLeftOver)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
