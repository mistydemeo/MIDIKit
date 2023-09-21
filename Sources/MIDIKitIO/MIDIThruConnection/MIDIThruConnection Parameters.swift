//
//  MIDIThruConnection Parameters.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2021-2023 Steffan Andrews • Licensed under MIT License
//

#if !os(tvOS) && !os(watchOS)

@_implementationOnly import CoreMIDI

extension MIDIThruConnection {
    /// Parameters for a MIDI Thru connection.
    public struct Parameters {
        public var filterOutAllControls: Bool = false
        public var filterOutBeatClock: Bool = false
        public var filterOutMTC: Bool = false
        public var filterOutSysEx: Bool = false
        public var filterOutTuneRequest: Bool = false
    
        public init() { }
    }
}

extension MIDIThruConnection.Parameters {
    init(_ coreMIDIParams: MIDIThruConnectionParams) {
        filterOutAllControls = coreMIDIParams.filterOutAllControls != 0
        filterOutBeatClock = coreMIDIParams.filterOutBeatClock != 0
        filterOutMTC = coreMIDIParams.filterOutMTC != 0
        filterOutSysEx = coreMIDIParams.filterOutSysEx != 0
        filterOutTuneRequest = coreMIDIParams.filterOutTuneRequest != 0
    }
}

extension MIDIThruConnection.Parameters {
    /// Builds Core MIDI `MIDIThruConnectionParams` from local properties.
    func coreMIDIThruConnectionParams(
        inputs: [MIDIInputEndpoint],
        outputs: [MIDIOutputEndpoint]
    ) -> MIDIThruConnectionParams {
        var params = MIDIThruConnectionParams()
    
        MIDIThruConnectionParamsInitialize(&params) // fill with defaults
    
        // MIDIThruConnectionParams Properties:
        //  .outputs
        //      MIDIThruConnectionEndpoint tuple (initial size: 8).
        //      All MIDI generated by these outputs is routed into
        //      this connection for processing and distribution to inputs.
        //  .numSources
        //      The number of valid outputs in the .outputs tuple.
        //  .inputs
        //      MIDIThruConnectionEndpoint tuple (initial size: 8).
        //      All MIDI output from the connection is routed to these inputs.
        //  .numDestinations
        //      The number of valid outputs in the .inputs tuple.
        //  (many more properties available including filters)
    
        // Source(s) and destination(s).
    
        // These expect tuples, so we have to perform some weirdness.
        // Rather than initialize MIDIThruConnectionEndpoint objects,
        // just access the .endpointRef property.
        // All 8 are pre-initialized MIDIThruConnectionEndpoint objects.
        
        // Apple docs for MIDIThruConnectionEndpoint:
        // > Set the endpoint’s uniqueID to 0 if the endpoint exists and you’re passing its
        // > endpointRef. When retrieving a connection from Core MIDI, its endpointRef may be NULL
        // > if it doesn’t exist, but the uniqueID is always non-zero.
        
        // outputs
    
        params.numSources = UInt32(outputs.count)
    
        for srcEP in 0 ..< outputs.count {
            switch srcEP {
            case 0:
                params.sources.0 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 1:
                params.sources.1 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 2:
                params.sources.2 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 3:
                params.sources.3 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 4:
                params.sources.4 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 5:
                params.sources.5 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 6:
                params.sources.6 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            case 7:
                params.sources.7 = .init(
                    endpointRef: outputs[srcEP].coreMIDIObjectRef,
                    uniqueID: outputs[srcEP].uniqueID
                )
            default:
                break // ignore more than 8 endpoints
            }
        }
    
        // inputs
    
        params.numDestinations = UInt32(inputs.count)
    
        for destEP in 0 ..< inputs.count {
            switch destEP {
            case 0:
                params.destinations.0 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 1:
                params.destinations.1 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 2:
                params.destinations.2 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 3:
                params.destinations.3 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 4:
                params.destinations.4 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 5:
                params.destinations.5 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 6:
                params.destinations.6 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
    
            case 7:
                params.destinations.7 = .init(
                    endpointRef: inputs[destEP].coreMIDIObjectRef,
                    uniqueID: inputs[destEP].uniqueID
                )
            default:
                break // ignore more than 8 endpoints
            }
        }
    
        // properties
    
        // 0 or 1
        params.filterOutAllControls = filterOutAllControls ? 1 : 0
    
        // 0 or 1
        params.filterOutBeatClock = filterOutBeatClock ? 1 : 0
    
        // 0 or 1
        params.filterOutMTC = filterOutMTC ? 1 : 0
    
        // 0 or 1
        params.filterOutSysEx = filterOutSysEx ? 1 : 0
    
        // 0 or 1
        params.filterOutTuneRequest = filterOutTuneRequest ? 1 : 0
    
        return params
    }
}

#endif
