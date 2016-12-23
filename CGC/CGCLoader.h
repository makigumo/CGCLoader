//
//  CGCLoader.h
//  CGC
//
//  Created by Makigumo on 2016/12/23.
//    Copyright © 2016年 Makigumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Hopper/Hopper.h>

static const uint8_t CGC_HEADER[] = {0x7F, 0x43, 0x47, 0x43, 0x01, 0x01, 0x01, 0x43, 0x01};
static const uint8_t ELF_HEADER[] = "\x7F""ELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00";

@interface CGCLoader : NSObject <FileLoader>

@end
