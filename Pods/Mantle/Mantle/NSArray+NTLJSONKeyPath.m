//
//  NSArray+NTLJSONKeyPath.m
//  Pods
//
//  Created by cheng way on 8/15/15.
//
//

#import "NSArray+NTLJSONKeyPath.h"
#import "MTLJSONAdapter.h"

@implementation NSArray (NTLJSONKeyPath)
- (id)mtl_valueForJSONKeyPath:(NSString *)JSONKeyPath success:(BOOL *)success error:(NSError **)error {
    
    NSUInteger count = self.count;
    
    id result;
    for (int i = 0; i < count; i++) {
        // Check the result before resolving the key path component to not
        // affect the last value of the path.
        result = self[i];
        if (result == nil || result == NSNull.null) break;
        
        if (![result isKindOfClass:NSDictionary.class] && ![result isKindOfClass:[NSArray class]]) {
            if (error != NULL) {
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid JSON dictionary", @""),
                                           NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedString(@"JSON key path %1$@ could not resolved because an incompatible JSON dictionary was supplied: \"%2$@\"", @""), JSONKeyPath, self]
                                           };
                
                *error = [NSError errorWithDomain:MTLJSONAdapterErrorDomain code:MTLJSONAdapterErrorInvalidJSONDictionary userInfo:userInfo];
            }
            
            if (success != NULL) *success = NO;
            
            return nil;
        }
        if ([result isKindOfClass:NSDictionary.class]) {
            result = result[JSONKeyPath];
            if (result) break;
        } else if ([result isKindOfClass:[NSArray class]]) {
            result = [(NSArray *)result mtl_valueForJSONKeyPath:JSONKeyPath success:success error:error];
        }
        
    }
    
    if (success != NULL) *success = YES;
    
    return result;

}
@end
