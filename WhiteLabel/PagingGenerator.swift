//
//  PagingGenerator.swift
//
//  Based on code by by Marcin Krzyzanowski on 22/06/15.
//  Copyright (c) 2015 Marcin Krzyżanowski. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import Foundation

open class PagingGenerator {
    
    open var next: ((_ page: Int, _ completionMarker: @escaping ((_ success: Bool) -> Void) ) -> Void)!
    open var page: Int
    open var startPage: Int = 1
    open var didReachEnd: Bool = false
    open var isFetchingPage: Bool = false
    
    public init(startPage: Int) {
        self.startPage = startPage
        self.page = startPage
    }
    
    open func getNext(_ complete: (() -> Void)? = nil) {
        if didReachEnd { return }
        isFetchingPage = true
        next(page) { success in
            if success {
                self.page += 1
            }
            self.isFetchingPage = false
            complete?()
        }
    }
    
    open func reachedEnd() {
        didReachEnd = true
    }
    
    open func reset() {
        didReachEnd = false
        page = startPage
    }
}
