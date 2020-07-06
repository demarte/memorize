//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Ivan on 05/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct ThemeChooserView: View {
  
  @State private var editMode: EditMode = .inactive
  @ObservedObject var store: EmojiMemoryThemeStore
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List {
          ForEach(store.themes) { theme in
            NavigationLink(destination:
              EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))
                .navigationBarTitle(theme.name)) {
                  ThemeRow(theme: theme, editMode: self.$editMode)
                    .environmentObject(self.store)
            }
          }
          .onDelete { indexSet in
            indexSet.forEach { self.store.themes.remove(at: $0) }
          }
        }
      }
      .navigationBarTitle("Memorize")
      .navigationBarItems(
        leading: Button(action: {
          self.store.newTheme()
        }, label: {
          Image(systemName: "plus").imageScale(.large)
        }),
        trailing: EditButton())
        .environment(\.editMode, $editMode)
    }
  }
}

struct ThemeRow: View {
  
  var theme: Theme
  @Binding var editMode: EditMode
  @State private var showThemeEditor = false
  
  @EnvironmentObject var store: EmojiMemoryThemeStore
  
  private var emojis: String {
    theme.emojis.reduce(into: "") { (result, emoji) in
      result.append(contentsOf: emoji)
    }
  }
  
  var body: some View {
    HStack {
      if editMode == .active {
        Image(systemName: "pencil.circle.fill")
          .font(Font.system(size: self.iconFontSize))
          .onTapGesture {
            self.showThemeEditor = true
        }
        .sheet(isPresented: $showThemeEditor) {
          ThemeEditorView(theme: self.theme, isShowing: self.$showThemeEditor, editMode: self.$editMode)
            .environmentObject(self.store)
        }
      }
      VStack(alignment: .leading) {
        Text(theme.name)
          .font(Font.title)
        Text(emojis)
          .lineLimit(1)
      }
    }
    .foregroundColor(Color(theme.color))
  }
  
  // MARK: - Drawing Constants -
  
  private let iconFontSize: CGFloat = 30
}

struct ThemeChooserView_Previews: PreviewProvider {
  static var previews: some View {
    ThemeChooserView(store: EmojiMemoryThemeStore())
  }
}
