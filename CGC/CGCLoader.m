//
//  CGCLoader.m
//  CGC
//
//  Created by Makigumo on 2016/12/23.
//    Copyright © 2016年 Makigumo. All rights reserved.
//

#import "CGCLoader.h"

@implementation CGCLoader {
    NSObject <HPHopperServices> *_services;
}

- (instancetype)initWithHopperServices:(NSObject <HPHopperServices> *)services {
    if (self = [super init]) {
        _services = services;
    }
    return self;
}

- (HopperUUID *)pluginUUID {
    return [_services UUIDWithString:@"452A0572-3957-4AEC-B766-8EA48150C965"];
}

- (HopperPluginType)pluginType {
    return Plugin_Loader;
}

- (NSString *)pluginName {
    return @"CGC";
}

- (NSString *)pluginDescription {
    return @"CGC Loader";
}

- (NSString *)pluginAuthor {
    return @"Makigumo";
}

- (NSString *)pluginCopyright {
    return @"©2016 - Makigumo";
}

- (NSString *)pluginVersion {
    return @"0.0.1";
}

- (BOOL)canLoadDebugFiles {
    return NO;
}

// Returns an array of DetectedFileType objects.
- (NSArray<NSObject <HPDetectedFileType> *> *)detectedTypesForData:(NSData *)data {
    if ([data length] < sizeof(CGC_HEADER)) {
        return @[];
    }

    const void *bytes = [data bytes];

    if (memcmp(bytes, CGC_HEADER, sizeof(CGC_HEADER)) == 0) {
        NSObject <HPDetectedFileType> *type = [_services detectedType];
        [type setFileDescription:@"CGC Executable"];
        [type setShortDescriptionString:@"cgc_exe"];
        [type setCompositeFile:YES];
        return @[type];
    }

    return @[];
}

- (FileLoaderLoadingStatus)loadData:(NSData *)data
              usingDetectedFileType:(NSObject <HPDetectedFileType> *)fileType
                            options:(FileLoaderOptions)options
                            forFile:(NSObject <HPDisassembledFile> *)file
                      usingCallback:(FileLoadingCallbackInfo)callback {

    return DIS_NotSupported;
}

- (void)fixupRebasedFile:(NSObject <HPDisassembledFile> *)file
               withSlide:(int64_t)slide
        originalFileData:(NSData *)fileData {

}

- (FileLoaderLoadingStatus)loadDebugData:(NSData *)data
                                 forFile:(NSObject <HPDisassembledFile> *)file
                           usingCallback:(FileLoadingCallbackInfo)callback {
    return DIS_NotSupported;
}

- (NSData *)extractFromData:(NSData *)data
      usingDetectedFileType:(NSObject <HPDetectedFileType> *)fileType
         returnAdjustOffset:(uint64_t *)adjustOffset {
    if ([data length] < sizeof(CGC_HEADER)) {
        return nil;
    }

    const void *bytes = [data bytes];

    if (memcmp(bytes, CGC_HEADER, sizeof(CGC_HEADER)) == 0) {

        NSMutableData *returnData = [NSMutableData dataWithData:data];
        [returnData replaceBytesInRange:NSMakeRange(0, sizeof(ELF_HEADER))
                              withBytes:ELF_HEADER];
        *adjustOffset = 0;
        return returnData;
    }
    return nil;
}

@end
