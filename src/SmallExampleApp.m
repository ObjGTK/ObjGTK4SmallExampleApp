/*
 * SPDX-FileCopyrightText: 2024 Amrit Bhogal <ambhogal01@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import <ObjFW/ObjFW.h>
#import <ObjGTK4/ObjGTK4-Umbrella.h>

@interface SmallExampleApp : OFObject<OFApplicationDelegate>
@end

@implementation SmallExampleApp {
    size_t count;
}

- (void)applicationDidFinishLaunching:(OFNotification *)notification
{
    int* argc;
    char*** argv;

    OGTKApplication* app = [[OGTKApplication alloc] initWithApplicationId:@"net.frityet.exampleApp" flags:G_APPLICATION_DEFAULT_FLAGS];
    [app connectSignal:@"activate" target:self selector:@selector(onActivate:)];

    [[OFApplication sharedApplication] getArgumentCount:&argc andArgumentValues:&argv];

    [OFApplication terminateWithStatus:[app runWithArgc:*argc argv:*argv]];
}

- (void)onActivate:(OGTKApplication *)app
{
    OGTKApplicationWindow* window = [[OGTKApplicationWindow alloc] init:app];
    window.title = @"Hello, World!";

    [window setDefaultSizeWithWidth:640 height:480];

    OGTKBox* box = [[OGTKBox alloc] initWithOrientation:GTK_ORIENTATION_VERTICAL spacing:0];
    box.halign = GTK_ALIGN_CENTER;
    box.valign = GTK_ALIGN_CENTER;

    window.child = box;

    OGTKButton* button = [[OGTKButton alloc] initWithLabel:@"Button clicked 0 times"];
    [button connectSignal:@"clicked" target:self selector:@selector(onButtonClicked:)];

    [box append:button];
    [window present];
}

- (void)onButtonClicked:(OGTKButton *)button
{
    button.label = [OFString stringWithFormat:@"Button clicked %zu times", ++count];
}

@end

OF_APPLICATION_DELEGATE(SmallExampleApp);