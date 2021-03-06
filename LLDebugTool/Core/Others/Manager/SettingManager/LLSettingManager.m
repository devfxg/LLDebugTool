//
//  LLSettingManager.m
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "LLSettingManager.h"

#import "LLFunctionComponent.h"
#import "LLConfig.h"
#import "LLRouter.h"
#import "LLConst.h"

#import "NSUserDefaults+LL_Utils.h"

static LLSettingManager *_instance = nil;

static NSString *doubleClickActionKey = @"doubleClickActionKey";
static NSString *colorStyleKey = @"colorStyleKey";
static NSString *entryWindowStyleKey = @"entryWindowStyleKey";
static NSString *statusBarStyleKey = @"statusBarStyleKey";
static NSString *logStyleKey = @"logStyleKey";
static NSString *shrinkToEdgeWhenInactiveKey = @"shrinkToEdgeWhenInactiveKey";
static NSString *shakeToHideKey = @"shakeToHideKey";
static NSString *magnifierZoomLevelKey = @"magnifierZoomLevelKey";
static NSString *magnifierSizeKey = @"magnifierSizeKey";
static NSString *showWidgetBorderKey = @"showWidgetBorderKey";
static NSString *hierarchyIgnorePrivateClassKey = @"hierarchyIgnorePrivateClassKey";
static NSString *webViewClassKey = @"webViewClassKey";
static NSString *lastWebViewUrlKey = @"lastWebViewUrlKey";
static NSString *mockLocationEnableKey = @"mockLocationEnableKey";
static NSString *mockLocationLatitudeKey = @"mockLocationLatitudeKey";
static NSString *mockLocationLongitudeKey = @"mockLocationLongitudeKey";

@implementation LLSettingManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LLSettingManager alloc] init];
    });
    return _instance;
}

- (void)prepareForConfig {
    NSNumber *doubleClickAction = self.doubleClickAction;
    if (doubleClickAction != nil) {
        [LLConfig shared].doubleClickAction = [doubleClickAction integerValue];
    }
    NSNumber *colorStyle = self.colorStyle;
    if (colorStyle != nil) {
        [LLConfig shared].colorStyle = colorStyle.integerValue;
    }
    NSNumber *entryWindowStyle = self.entryWindowStyle;
    if (entryWindowStyle != nil) {
        [LLConfig shared].entryWindowStyle = entryWindowStyle.integerValue;
    }
    NSNumber *statusBarStyle = self.statusBarStyle;
    if (statusBarStyle != nil) {
        [[LLConfig shared] configStatusBarStyle:statusBarStyle.integerValue];
    }
#ifdef LLDEBUGTOOL_LOG
    NSNumber *logStyle = self.logStyle;
    if (logStyle != nil) {
        [LLConfig shared].logStyle = logStyle.integerValue;
    }
#endif
    NSNumber *shrinkToEdgeWhenInactive = self.shrinkToEdgeWhenInactive;
    if (shrinkToEdgeWhenInactive != nil) {
        [LLConfig shared].shrinkToEdgeWhenInactive = [shrinkToEdgeWhenInactive boolValue];
    }
    NSNumber *shakeToHide = self.shakeToHide;
    if (shakeToHide != nil) {
        [LLConfig shared].shakeToHide = [shakeToHide boolValue];
    }
#ifdef LLDEBUGTOOL_MAGNIFIER
    NSNumber *magnifierZoomLevel = self.magnifierZoomLevel;
    if (magnifierZoomLevel != nil) {
        [LLConfig shared].magnifierZoomLevel = [magnifierZoomLevel integerValue];
    }
    NSNumber *magnifierSize = self.magnifierSize;
    if (magnifierSize != nil) {
        [LLConfig shared].magnifierSize = [magnifierSize integerValue];
    }
#endif
#ifdef LLDEBUGTOOL_WIDGET_BORDER
    NSNumber *showWidgetBorder = self.showWidgetBorder;
    if (showWidgetBorder != nil) {
        [LLConfig shared].showWidgetBorder = [showWidgetBorder boolValue];
    }
#endif
#ifdef LLDEBUGTOOL_HIERARCHY
    NSNumber *hierarchyIgnorePrivateClass = self.hierarchyIgnorePrivateClass;
    if (hierarchyIgnorePrivateClass != nil) {
        [LLConfig shared].hierarchyIgnorePrivateClass = [hierarchyIgnorePrivateClass boolValue];
    }
#endif
#ifdef LLDEBUGTOOL_LOCATION
    NSNumber *mockLocationEnable = self.mockLocationEnable;
    if (mockLocationEnable != nil) {
        [LLRouter setLocationHelperEnable:[mockLocationEnable boolValue]];
    }
    NSNumber *mockLocationLatitude = self.mockLocationLatitude;
    NSNumber *mockLocationLogitude = self.mockLocationLongitude;
    if (mockLocationLatitude && mockLocationLogitude) {
        [LLConfig shared].mockLocationLatitude = [mockLocationLatitude doubleValue];
        [LLConfig shared].mockLocationLongitude = [mockLocationLogitude doubleValue];
    }
#endif
}

#pragma mark - Getters and Setters
- (void)setDoubleClickAction:(NSNumber *)doubleClickAction {
    [NSUserDefaults LL_setNumber:doubleClickAction forKey:doubleClickActionKey];
}

- (NSNumber *)doubleClickAction {
    return [NSUserDefaults LL_numberForKey:doubleClickActionKey];
}

- (void)setColorStyle:(NSNumber *)colorStyle {
    [NSUserDefaults LL_setNumber:colorStyle forKey:colorStyleKey];
}

- (NSNumber *)colorStyle {
    return [NSUserDefaults LL_numberForKey:colorStyleKey];
}

- (void)setEntryWindowStyle:(NSNumber *)entryWindowStyle {
    [NSUserDefaults LL_setNumber:entryWindowStyle forKey:entryWindowStyleKey];
}

- (NSNumber *)entryWindowStyle {
    return [NSUserDefaults LL_numberForKey:entryWindowStyleKey];
}

- (void)setStatusBarStyle:(NSNumber *)statusBarStyle {
    [NSUserDefaults LL_setNumber:statusBarStyle forKey:statusBarStyleKey];
}

- (NSNumber *)statusBarStyle {
    return [NSUserDefaults LL_numberForKey:statusBarStyleKey];
}

- (void)setLogStyle:(NSNumber *)logStyle {
    [NSUserDefaults LL_setNumber:logStyle forKey:logStyleKey];
}

- (NSNumber *)logStyle {
    return [NSUserDefaults LL_numberForKey:logStyleKey];
}

- (void)setShrinkToEdgeWhenInactive:(NSNumber *)shrinkToEdgeWhenInactive {
    [NSUserDefaults LL_setNumber:shrinkToEdgeWhenInactive forKey:shrinkToEdgeWhenInactiveKey];
}

- (NSNumber *)shrinkToEdgeWhenInactive {
    return [NSUserDefaults LL_numberForKey:shrinkToEdgeWhenInactiveKey];
}

- (void)setShakeToHide:(NSNumber *)shakeToHide {
    [NSUserDefaults LL_setNumber:shakeToHide forKey:shakeToHideKey];
}

- (NSNumber *)shakeToHide {
    return [NSUserDefaults LL_numberForKey:shakeToHideKey];
}

- (void)setMagnifierZoomLevel:(NSNumber *)magnifierZoomLevel {
    [NSUserDefaults LL_setNumber:magnifierZoomLevel forKey:magnifierZoomLevelKey];
}

- (NSNumber *)magnifierZoomLevel {
    return [NSUserDefaults LL_numberForKey:magnifierZoomLevelKey];
}

- (void)setMagnifierSize:(NSNumber *)magnifierSize {
    [NSUserDefaults LL_setNumber:magnifierSize forKey:magnifierSizeKey];
}

- (NSNumber *)magnifierSize {
    return [NSUserDefaults LL_numberForKey:magnifierSizeKey];
}

- (void)setShowWidgetBorder:(NSNumber *)showWidgetBorder {
    [NSUserDefaults LL_setNumber:showWidgetBorder forKey:showWidgetBorderKey];
}

- (NSNumber *)showWidgetBorder {
    return [NSUserDefaults LL_numberForKey:showWidgetBorderKey];
}

- (void)setHierarchyIgnorePrivateClass:(NSNumber *)hierarchyIgnorePrivateClass {
    [NSUserDefaults LL_setNumber:hierarchyIgnorePrivateClass forKey:hierarchyIgnorePrivateClassKey];
}

- (NSNumber *)hierarchyIgnorePrivateClass {
    return [NSUserDefaults LL_numberForKey:hierarchyIgnorePrivateClassKey];
}

- (void)setWebViewClass:(NSString *)webViewClass {
    [NSUserDefaults LL_setString:webViewClass forKey:webViewClassKey];
}

- (NSString *)webViewClass {
    return [NSUserDefaults LL_stringForKey:webViewClassKey];
}

- (void)setLastWebViewUrl:(NSString *)lastWebViewUrl {
    [NSUserDefaults LL_setString:lastWebViewUrl forKey:lastWebViewUrlKey];
}

- (NSString *)lastWebViewUrl {
    return [NSUserDefaults LL_stringForKey:lastWebViewUrlKey];
}

- (void)setMockLocationEnable:(NSNumber *)mockLocationEnable {
    [NSUserDefaults LL_setNumber:mockLocationEnable forKey:mockLocationEnableKey];
}

- (NSNumber *)mockLocationEnable {
    return [NSUserDefaults LL_numberForKey:mockLocationEnableKey];
}

- (void)setMockLocationLatitude:(NSNumber *)mockLocationLatitude {
    [NSUserDefaults LL_setNumber:mockLocationLatitude forKey:mockLocationLatitudeKey];
}

- (NSNumber *)mockLocationLatitude {
    return [NSUserDefaults LL_numberForKey:mockLocationLatitudeKey];
}

- (void)setMockLocationLongitude:(NSNumber *)mockLocationLongitude {
    [NSUserDefaults LL_setNumber:mockLocationLongitude forKey:mockLocationLongitudeKey];
}

- (NSNumber *)mockLocationLongitude {
    return [NSUserDefaults LL_numberForKey:mockLocationLongitudeKey];
}

@end
