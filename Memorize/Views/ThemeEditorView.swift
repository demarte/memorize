//
//  ThemeEditorView.swift
//  Memorize
//
//  Created by Ivan on 27/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct ThemeEditorView: View {
  
  var theme: Theme
  @Binding var isShowing: Bool
  @Binding var editMode: EditMode
  @State private var themeName: String = ""
  @State private var emojisToAdd: String = ""
  @State private var emojis: [String] = []
  @State private var numberOfPairs = 2
  @State private var color: UIColor.RGB?
  @State private var removedEmojis: [String] = []
  @EnvironmentObject var store: EmojiMemoryThemeStore
  
  var body: some View {
    VStack {
      Header(name: theme.name) {
        self.updateTheme()
        self.isShowing = false
      }
      GeometryReader { geometry in
        Form {
          Section {
            TextField("Theme Name", text: self.$themeName)
          }
          Section(header: Text("Add Emoji")) {
            HStack {
              TextField("Emojis To Add", text: self.$emojisToAdd)
              Button(action: {
                self.emojisToAdd.forEach { self.emojis.append(String($0)) }
                self.emojisToAdd = ""
              }) {
                Text("Add")
              }
              .disabled(self.emojisToAdd.isEmpty)
            }
          }
          EmojisSection(emojis: self.$emojis, title: "Emojis", subTitle: "Tap emoji to exclude") { emoji in
            self.removedEmojis.append(emoji)
          }
          EmojisSection(emojis: self.$removedEmojis, title: "Remove", subTitle: "Tap emoji to recover") { emoji in
            self.emojis.append(emoji)
          }
          Section(header: Text("Card Count")) {
            HStack {
              Text("\(self.numberOfPairs) Pairs")
              Spacer()
              Stepper("", value: self.$numberOfPairs, in: 2...self.theme.emojis.count)
            }
          }
          Section(header: Text("Color")) {
            ColorPalette() { color in
              self.color = color
            }
            .frame(width: geometry.size.width * 0.9, height: 300)
          }
        }
      }
    }
    .onAppear {
      self.themeName = self.theme.name
      self.emojis = self.theme.emojis
      self.numberOfPairs = self.theme.numberOfPairsOfCards
    }
    .onDisappear(perform: {
      withAnimation {
        self.editMode = .inactive
      }
    })
  }
  
  private func updateTheme() {
    let color = self.color ?? theme.color
    let name = self.themeName.isEmpty ? theme.name : self.themeName
    
    let newTheme = Theme(themeName: name, emojis: emojis, color: color, numberOfPairsOfCards: numberOfPairs)
    
    for index in store.themes.indices {
      if store.themes[index].id == theme.id {
        store.themes[index] = newTheme
      }
    }
  }
}


struct EmojisSection: View {
  @Binding var emojis: [String]
  var title: String
  var subTitle: String
  var onRemoveEmoji: (String) -> Void
  
  var body: some View {
    Section(header:
      HStack {
        Text(title)
        Spacer()
        Text(subTitle)
    }) {
      ScrollView(.horizontal) {
        HStack {
          ForEach(self.emojis, id: \.self) { emoji in
            Text(emoji).font(.largeTitle)
              .onTapGesture {
                if let emoji = self.emojis.removeLast(matching: emoji) {
                  self.onRemoveEmoji(emoji)
                }
            }
          }
        }
        .padding()
      }
    }
  }
}

struct Header: View {
  var name: String
  var onTapButton: () -> Void
  
  var body: some View {
    ZStack {
      Text(name)
      HStack {
        Spacer()
        Button(action: {
          self.onTapButton()
        }, label: {
          Text("done")
        })
      }
      .padding()
    }
  }
}

struct ThemeEditorView_Previews: PreviewProvider {
  static var previews: some View {
    ThemeEditorView(theme: Theme(
      themeName: "Faces",
      emojis: ["🤓","🤪","😍","😝","🥵","🥶","🤬","🤯","😎","🤩","🤮"],
      color: UIColor.RGB(red: 0.9, green: 0.74, blue: 0.23, alpha: 1),
      numberOfPairsOfCards: 7),isShowing: Binding.constant(true), editMode: Binding.constant(.inactive))
  }
}
