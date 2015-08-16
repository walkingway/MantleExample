//
//  NSArray+NTLJSONKeyPath.h
//  Pods
//
//  Created by cheng way on 8/15/15.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (NTLJSONKeyPath)

- (id)mtl_valueForJSONKeyPath:(NSString *)JSONKeyPath success:(BOOL *)success error:(NSError **)error;

@end
