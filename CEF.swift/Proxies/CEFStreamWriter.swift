//
//  CEFStreamWriter.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFStreamWriter {
    
    /// Create a new CefStreamWriter object for a file.
    public convenience init?(filePath: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(filePath)
        defer { CEFStringPtrRelease(cefStrPtr) }
        self.init(ptr: cef_stream_writer_create_for_file(cefStrPtr))
    }

    /// Create a new CefStreamWriter object for a custom handler.
    public convenience init?(handler: CEFWriteHandler) {
        self.init(ptr: cef_stream_writer_create_for_handler(handler.toCEF()))
    }
    
    /// Write raw binary data.
    func write(buffer: UnsafePointer<Void>, chunkSize: size_t, count: size_t) -> size_t {
        return cefObject.write(cefObjectPtr, buffer, chunkSize, count)
    }

    /// Seek to the specified offset position. |whence| may be any one of
    /// SEEK_CUR, SEEK_END or SEEK_SET. Returns zero on success and non-zero on
    /// failure.
    func seek(offset: Int64, whence: CEFSeekPosition) -> Bool {
        return cefObject.seek(cefObjectPtr, offset, whence.rawValue) == 0
    }
    
    /// Return the current offset position.
    func tell() -> Int64 {
        return cefObject.tell(cefObjectPtr)
    }
    
    /// Flush the stream.
    func flush() -> Bool {
        return cefObject.flush(cefObjectPtr) != 0
    }
    
    /// Returns true if this reader performs work like accessing the file system
    /// which may block. Used as a hint for determining the thread to access the
    /// reader from.
    func mayBlock() -> Bool {
        return cefObject.may_block(cefObjectPtr) != 0
    }
    
}

