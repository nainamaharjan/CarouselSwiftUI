//
//  ContentView.swift
//  CarouselSwiftUI
//
//  Created by Naina Maharjan on 13/03/2024.
//

import SwiftUI

enum CardDesign {
    case designOne
    case designTwo
    case designThree
    // Add more designs as needed
}

struct ContentView: View {
    
    @State private var currentIndex: Int = 0
    let cards = [
        Card(id: 0, color: .red, design: .designOne),
        Card(id: 1, color: .blue, design: .designTwo),
        Card(id: 2, color: .pink, design: .designThree)
    ]
    
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            GeometryReader { geometry in
                ZStack {
                    ForEach(cards) { card in
                        switch card.design {
                            
                        case .designOne:
                            DesignOneCardView(card: card, currentIndex: $currentIndex, geometry: geometry)
                                .offset(x: CGFloat(card.id - currentIndex) * (geometry.size.width * 0.7))
                        case .designTwo:
                            DesignTwoCardView(card: card, currentIndex: $currentIndex, geometry: geometry)
                                .offset(x: CGFloat(card.id - currentIndex) * (geometry.size.width * 0.7))

                        case .designThree:
                            DesignThreeCardView(card: card, currentIndex: $currentIndex, geometry: geometry)
                                .offset(x: CGFloat(card.id - currentIndex) * (geometry.size.width * 0.7))
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let cardWidth = geometry.size.width * 0.2
                            let offset = value.translation.width / cardWidth
                            
                            withAnimation(Animation.spring()) {
                                if value.translation.width < -offset
                                {
                                    currentIndex = min(currentIndex + 1, cards.count - 1)
                                } else if value.translation.width > offset {
                                    currentIndex = max(currentIndex - 1, 0)
                                }
                            }
                            
                        }
                )
            }
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 156, maxHeight: 250)
        
        PageControl(index: $currentIndex, maxIndex: ((cards.count > 1) ? (cards.count - 1) : 0))
        
        
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                if index == self.index {
                    Capsule()
                        .fill(.red.opacity(0.7))
                        .frame(width: 8, height: 4)
                        .animation(Animation.spring().delay(0.5), value: index)
                } else {
                    Circle()
                        .fill(.gray.opacity(0.6))
                        .frame(width: 4, height: 4)
                }
            }
        }
    }
}


struct DesignOneCardView: View {
    let card: Card
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let cardWidth = geometry.size.width * 0.8
        let cardHeight : CGFloat = 136
        let offset = (geometry.size.width - cardWidth) / 2
        
        return ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(card.color)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.16), lineWidth: 1)
                )
                .frame(width: cardWidth, height: cardHeight)
                .opacity(card.id <= currentIndex + 1 ? 1.0 : 0.0)
                .scaleEffect(card.id == currentIndex ? 1.0 : 0.9)
            
            HStack(alignment: .center, spacing: 0) {
              Text("Design One")
                    .foregroundColor(.white)
            }.padding(.all, 16)
        }
        .frame(width: cardWidth, height: cardHeight)
        .offset(x: CGFloat(card.id - currentIndex) * offset)
    }
}

struct DesignTwoCardView: View {
    let card: Card
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let cardWidth = geometry.size.width * 0.8
        let cardHeight : CGFloat = 136
        let offset = (geometry.size.width - cardWidth) / 2
        
        return ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(card.color)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.16), lineWidth: 1)
                )
                .frame(width: cardWidth, height: cardHeight)
                .opacity(card.id <= currentIndex + 1 ? 1.0 : 0.0)
                .scaleEffect(card.id == currentIndex ? 1.0 : 0.9)
            
            HStack(alignment: .center, spacing: 0) {
                Text("Design Two")
                    .foregroundColor(.white)
            }.padding(.all, 16)
        }
        .frame(width: cardWidth, height: cardHeight)
        .offset(x: CGFloat(card.id - currentIndex) * offset)
    }
}


struct DesignThreeCardView: View {
    let card: Card
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let cardWidth = geometry.size.width * 0.8
        let cardHeight : CGFloat = 136
        let offset = (geometry.size.width - cardWidth) / 2
        
        return ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(card.color)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.16), lineWidth: 1)
                )
                .frame(width: cardWidth, height: cardHeight)
                .opacity(card.id <= currentIndex + 1 ? 1.0 : 0.0)
                .scaleEffect(card.id == currentIndex ? 1.0 : 0.9)
            
            HStack(alignment: .center, spacing: 0) {
                Text("Design Three")
                    .foregroundColor(.white)
            }.padding(.all, 16)
        }
        .frame(width: cardWidth, height: cardHeight)
        .offset(x: CGFloat(card.id - currentIndex) * offset)
    }
}


struct Card: Identifiable {
    var id: Int
    var color: Color
    var design: CardDesign
}


#Preview {
    ContentView()
}
