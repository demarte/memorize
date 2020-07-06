//
//  ColorPalette.swift
//  Memorize
//
//  Created by Ivan on 28/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct ColorPalette: View {
  
  @State private var selectedColor: UIColor?
  
  private let onTapColor: (UIColor.RGB) -> Void
  
  init(onTapColor: @escaping (UIColor.RGB) -> Void) {
    self.onTapColor = onTapColor
  }
  
  var body: some View {
    Grid(self.colorPaletteOptions, id: \.self) { color in
      ZStack {
        GeometryReader { geometry in
          RoundedRectangle(cornerRadius: self.borderRadius)
            .fill(Color(color))
          RoundedRectangle(cornerRadius: self.borderRadius).stroke(lineWidth: self.borderWidth)
            .foregroundColor(.black)
          if self.selectedColor != nil && color == self.selectedColor {
            HStack {
              Spacer()
              VStack(alignment: .trailing) {
                Spacer()
                Image(systemName: "checkmark.circle")
                  .foregroundColor(self.checkmarkColor)
                  .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
                  .padding(5)
              }
            }
          }
        }
      }
      .frame(width: 80, height: 80)
      .onTapGesture {
        self.selectedColor = color
        let rgb = UIColor.RGB(red: color.rgb.red, green: color.rgb.green, blue: color.rgb.blue, alpha: color.rgb.alpha)
        self.onTapColor(rgb)
      }
    }
  }
  
  private var checkmarkColor: Color {
    if let color = selectedColor {
      if color.rgb.red == UIColor.black.rgb.red && color.rgb.green == UIColor.black.rgb.blue && color.rgb.green == UIColor.black.rgb.green {
        return .white
      }
    }
    return .black
  }
  
  // MARK: - Drawing Constants -
  
  private let borderRadius: CGFloat = 10
  private let borderWidth: CGFloat = 2
  private let colorPaletteOptions: [UIColor] = [
    #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
  ]
}
