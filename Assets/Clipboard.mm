//
//  Clipboard.m
//  CutBorad
//
//  Created by ThreeCM on 18/08/2017.
//  Copyright © 2017 threecm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Clipboard.h"

@interface Clipboard()

extern "C"
{
    /*  compare the namelist with system processes  */
    void _copyTextToClipboard(const char *textList);
    const char * _getTextFromClipboard();
    char* _MakeStringCopy( const char* string);
    float getiOSBatteryLevel();
}

@end


@implementation Clipboard
//将文本复制到IOS剪贴板
- (void)objc_copyTextToClipboard : (NSString*)text
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}

//获取IOS剪贴板

@end

extern "C" {
    float getiOSBatteryLevel(){
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        return [[UIDevice currentDevice] batteryLevel];
    }
    
    static Clipboard *iosClipboard;
    void _copyTextToClipboard(const char *textList)
    {
        NSString *text = [NSString stringWithUTF8String: textList] ;
        if(iosClipboard == NULL)
        {
            iosClipboard = [[Clipboard alloc] init];
        }
        [iosClipboard objc_copyTextToClipboard: text];
    }
    
    char* _MakeStringCopy( const char* string)
    {
        if (NULL == string) {
            return NULL;
        }
        char* res = (char*)malloc(strlen(string)+1);
        strcpy(res, string);
        return res;
    }
    
    const char * _getTextFromClipboard()
    {
        UIPasteboard* pBoard=[UIPasteboard generalPasteboard];
        if(pBoard!=NULL)
        {
            NSString* pNsStr=pBoard.string;
            if(pNsStr!=NULL)
            {
                return _MakeStringCopy([pNsStr UTF8String]);
            }
            else
            {
                NSLog(@"pBoard.string is null");
                return _MakeStringCopy("");
            }
        }
        else
        {
            NSLog(@"UIPasteboard pBoard is null");
            return  _MakeStringCopy("");
        }
    }
}
