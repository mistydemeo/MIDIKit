//
//  LargeTextDisplayView.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import MIDIKitControlSurfaces

extension HUISurfaceView {
    func LargeTextDisplayView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(huiSurface.model.largeDisplay.top.stringValue)
            Text(huiSurface.model.largeDisplay.bottom.stringValue)
        }
        .font(.system(size: 14, weight: .regular, design: .monospaced))
        .foregroundColor(.white)
        .frame(width: 360, height: 42)
        .background(.black)
        .cornerRadius(3.0, antialiased: true)
    }
}
