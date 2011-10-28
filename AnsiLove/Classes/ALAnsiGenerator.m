//
//  ALAnsiGenerator.m
//  AnsiLove.framework
//
//  Copyright (c) 2011, Stefan Vogt. All rights reserved.
//  http://byteproject.net
//
//  Use of this source code is governed by a MIT-style license.
//  See the file LICENSE for details.
//

#import "ALAnsiGenerator.h"

@implementation ALAnsiGenerator

- (id)init
{
    if (self == [super init]) {}
    return self;
}

+ (void)createPNGFromAnsiSource:(NSString *)inputFile 
                     outputFile:(NSString *)outputFile
                        columns:(NSString *)columns
                           font:(NSString *)font 
                           bits:(NSString *)bits
                      iceColors:(NSString *)iceColors
{     
    if (inputFile == nil || inputFile == @"") {
        // No inputfile? This means we can't do anything. Get the hell outta here.
        return;
    }
    
    if (outputFile == nil || outputFile == @"") {
        // In case the user provided no output file / path, just use the file name and
        // path from the inputFile value but add .png as suffix.
        outputFile = [[NSString alloc] initWithFormat:@"%@.png", inputFile];
    }
    
    // We need to resolve any tilde in path before passing this argument to NSTask.
    inputFile = [inputFile stringByExpandingTildeInPath];
    outputFile = [outputFile stringByExpandingTildeInPath];
    
    // Initialize the arguments array.
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    
    // Add the two most necessary arguments to the array.
    [arguments addObject:inputFile];
    [arguments addObject:outputFile];
    
    // The following if statements check if a string is nil or empty. That way we can
    // be sure only strings with proper contents will be added to the arguments array.
    if (columns && ![columns isEqualToString:@""]) {
        [arguments addObject:columns];
    }
    if (font && ![font isEqualToString:@""]) {
        [arguments addObject:font];
    }
    if (bits && ![bits isEqualToString:@""]) {
        [arguments addObject:bits];
    }
    if (iceColors && [iceColors isEqualToString:@"1"]) {
        [arguments addObject:iceColors];
    }
    
    // Finally start the task with the flags we gathered.
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"ansilove" ofType:nil]];
    [task setArguments:arguments];
    [task setStandardOutput:pipe];
    
    [task launch];
}

@end
