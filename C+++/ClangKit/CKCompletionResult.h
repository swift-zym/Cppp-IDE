/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina - www.xs-labs.com
 * All rights reserved.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

#import "CKCursor.h"
#import "../clang-c/Index.h"
#import <Cocoa/Cocoa.h>

/*!
 * @class           CKCompletionResult
 * @abstract        Completion result class
 */
@interface CKCompletionResult: NSObject
{
@protected
    
    CXCompletionString _string;
    CKCursorKind       _cursorKind;
    NSArray          * _chunks;
}

/*!
 * @property        text
 * @abstract        The completion result's text
 */
@property( atomic, readonly ) CXCompletionString * string;

/*!
 * @property        cursorKind
 * @abstract        The completion result's cursor kind
 */
@property( atomic, readonly ) CKCursorKind cursorKind;

/*!
 * @property        chunks
 * @abstract        The completion chunks (an array of CKCompletionChunk objects)
 */
@property( atomic, readonly ) NSArray * chunks;

/*!
 * @method          completionResultWithCXCompletionString:cursorKind:
 * @abstract        Gets a completion result from a completion string
 * @param           string      The completion string
 * @param           cursorKind  The cursor kind
 * @return          The completion result object
 * @discussion      The returned object is autoreleased.
 */
+ ( id )completionResultWithCXCompletionString: ( CXCompletionString )string cursorKind: ( CKCursorKind )cursorKind;

/*!
 * @method          initWithCXCompletionString:
 * @abstract        Initializes a completion result from a completion string
 * @param           string      The completion string
 * @param           cursorKind  The cursor kind
 * @return          The completion result object
 */
- ( id )initWithCXCompletionString: ( CXCompletionString )string cursorKind: ( CKCursorKind )cursorKind;

@end