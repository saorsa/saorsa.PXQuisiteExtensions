//
//  NSArray+LINQ_Sets.h
//  LINQ4Obj-C
//
//  Copyright (c) 2013 Michal Konturek
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


#import "LINQ.h"

@interface NSArray (LINQ_Sets)

/**
 Removes duplicate values from a collection.
 */
- (instancetype)linq_distinct;

/**
 Removes duplicate values from a collection using
 block to determine duplicate status.
 */
- (NSArray *)linq_distinctWithBlock:(id (^)(id item))block;

/**
 Returns the collection without the elements
 that appear in a second collection.
 */
- (instancetype)linq_except:(NSArray *)other;

/**
 Returns the set intersection, which means elements
 that appear in each of two collections.
 */
- (instancetype)linq_intersect:(NSArray *)other;

/**
 Returns the set union, which means unique elements
 that appear in either of two collections.
 */
- (NSArray *)linq_union:(NSArray *)other;

@end
