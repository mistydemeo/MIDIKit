//
//  SMPTEOffsetFrameRate.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2021-2023 Steffan Andrews • Licensed under MIT License
//

import MIDIKitCore

// MARK: - SMPTEOffsetFrameRate

extension MIDIFile {
    /// For use in SMPTE Offset track events
    public enum SMPTEOffsetFrameRate: UInt8, CaseIterable, Equatable, Hashable {
        case fps24     = 0b00 // 0 decimal
        case fps25     = 0b01 // 1 decimal
        case fps29_97d = 0b10 // 2 decimal
        case fps30     = 0b11 // 3 decimal
    }
}

extension MIDIFile.SMPTEOffsetFrameRate: Sendable { }

extension MIDIFile.SMPTEOffsetFrameRate: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        switch self {
        case .fps24:
            return "24fps"
            
        case .fps25:
            return "25fps"
            
        case .fps29_97d:
            return "29.97dfps"
            
        case .fps30:
            return "30fps"
        }
    }

    public var debugDescription: String {
        "SMPTEOffsetFrameRate(" + description + ")"
    }
}
