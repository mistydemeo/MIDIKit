//
//  HUIEvent ChannelStripComponent.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import MIDIKitCore

extension HUIEvent {
    /// A discrete component of a HUI channel strip and its state change.
    public enum ChannelStripComponent: Equatable, Hashable {
        #warning("> finish inline docs")
        
        case levelMeter(side: HUIModel.StereoLevelMeter.Side, level: Int)
        
        
        case recordReady(state: Bool)
        
        
        case insert(state: Bool)
        
        
        case vPotSelect(state: Bool)
        
        /// V-Pot encoding.
        case vPot(value: HUIVPotValue)
        
        
        case auto(state: Bool)
        
        
        case solo(state: Bool)
        
        
        case mute(state: Bool)
        
        
        case nameTextDisplay(text: HUISmallDisplayString)
        
        
        case select(state: Bool)
        
        
        case faderTouched(state: Bool)
        
        
        case faderLevel(level: UInt14)
        
        
    }
}
