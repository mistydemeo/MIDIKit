//
//  MIDIHelper.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2021-2023 Steffan Andrews • Licensed under MIT License
//

import MIDIKit
import OTCore
import SwiftUI

final class MIDIHelper: ObservableObject {
    private weak var midiManager: MIDIManager?
    
    public init() { }
    
    public func setup(midiManager: MIDIManager) {
        self.midiManager = midiManager
        
        midiManager.notificationHandler = { notification, manager in
            print("Core MIDI notification:", notification)
        }
        
        do {
            print("Starting MIDI services.")
            try midiManager.start()
        } catch {
            logger.default("Error starting MIDI services:", error.localizedDescription)
        }
        
        createVirtualEndpoints()
        createConnections()
    }
    
    // MARK: - MIDI Connections
    
    public var midiInputConnection: MIDIInputConnection? {
        midiManager?.managedInputConnections[ConnectionTags.inputConnectionTag]
    }
    
    public var midiOutputConnection: MIDIOutputConnection? {
        midiManager?.managedOutputConnections[ConnectionTags.outputConnectionTag]
    }
    
    private func createConnections() {
        do {
            if midiInputConnection == nil {
                logger.debug("Adding MIDI input connection to the manager.")
                
                try midiManager?.addInputConnection(
                    to: .none,
                    tag: ConnectionTags.inputConnectionTag,
                    receiver: .eventsLogging()
                )
            }
        } catch {
            logger.error(error)
        }
        
        do {
            if midiOutputConnection == nil {
                logger.debug("Adding MIDI output connection to the manager.")
                
                try midiManager?.addOutputConnection(
                    to: .none,
                    tag: ConnectionTags.outputConnectionTag
                )
            }
        } catch {
            logger.error(error)
        }
    }
    
    public func updateInputConnection(selectedUniqueID: MIDIIdentifier?) {
        guard let midiInputConnection else { return }
        
        guard let selectedUniqueID else {
            midiInputConnection.removeAllOutputs()
            return
        }
        
        switch selectedUniqueID {
        case .invalidMIDIIdentifier:
            midiInputConnection.removeAllOutputs()
        default:
            if !midiInputConnection.outputsCriteria.contains(.uniqueID(selectedUniqueID)) {
                midiInputConnection.removeAllOutputs()
                midiInputConnection.add(outputs: [.uniqueID(selectedUniqueID)])
            }
        }
    }
    
    public func updateOutputConnection(selectedUniqueID: MIDIIdentifier?) {
        guard let midiOutputConnection else { return }
        
        guard let selectedUniqueID else {
            midiOutputConnection.removeAllInputs()
            return
        }
        
        switch selectedUniqueID {
        case .invalidMIDIIdentifier:
            midiOutputConnection.removeAllInputs()
        default:
            if !midiOutputConnection.inputsCriteria.contains(.uniqueID(selectedUniqueID)) {
                midiOutputConnection.removeAllInputs()
                midiOutputConnection.add(inputs: [.uniqueID(selectedUniqueID)])
            }
        }
    }
    
    // MARK: - Virtual Endpoints
    
    public var midiInput: MIDIInput? {
        midiManager?.managedInputs[ConnectionTags.inputTag]
    }
    
    public var midiOutput: MIDIOutput? {
        midiManager?.managedOutputs[ConnectionTags.outputTag]
    }
    
    private func createVirtualEndpoints() {
        do {
            if midiInput == nil {
                logger.debug("Adding virtual MIDI input port to the manager.")
                
                try midiManager?.addInput(
                    name: ConnectionTags.inputName,
                    tag: ConnectionTags.inputTag,
                    uniqueID: .userDefaultsManaged(key: ConnectionTags.inputTag),
                    receiver: .eventsLogging()
                )
            }
        } catch {
            logger.error(error)
        }
        
        do {
            if midiOutput == nil {
                logger.debug("Adding virtual MIDI output port to the manager.")
                
                try midiManager?.addOutput(
                    name: ConnectionTags.outputName,
                    tag: ConnectionTags.outputTag,
                    uniqueID: .userDefaultsManaged(key: ConnectionTags.outputTag)
                )
            }
        } catch {
            logger.error(error)
        }
    }
    
    public func destroyVirtualEndpoints() {
        midiManager?.remove(.input, .all)
        midiManager?.remove(.output, .all)
    }
    
    public var virtualEndpointsExist: Bool {
        midiInput != nil &&
            midiOutput != nil
    }
}
