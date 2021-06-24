#import "AndroidPhoneCallNotifierPlugin.h"
#if __has_include(<android_phone_call_notifier/android_phone_call_notifier-Swift.h>)
#import <android_phone_call_notifier/android_phone_call_notifier-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "android_phone_call_notifier-Swift.h"
#endif

@implementation AndroidPhoneCallNotifierPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAndroidPhoneCallNotifierPlugin registerWithRegistrar:registrar];
}
@end
