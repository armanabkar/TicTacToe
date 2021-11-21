//
//  ContentView.swift
//  TicTacToe
//
//  Created by Arman Abkar on 9/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Text("Tic Tac Toe")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                    Spacer()
                    Text("Developed by Arman Abkar")
                        .foregroundColor(.white)
                }
                .disabled(viewModel.isGameBoardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                    }))
                }
            }
        }
    }
}

struct GameSquareView: View {
    var proxy: GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.red).opacity(0.6)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
