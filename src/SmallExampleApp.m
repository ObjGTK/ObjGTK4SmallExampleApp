/*
 * SPDX-FileCopyrightText: 2024 Amrit Bhogal <ambhogal01@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import <ObjFW/ObjFW.h>
#import <ObjGTK4/ObjGTK4-Umbrella.h>

@interface SmallExampleApp: OFObject <OFApplicationDelegate>
@end

@implementation SmallExampleApp
{
	size_t count;
}

- (void)applicationDidFinishLaunching:(OFNotification *)notification
{
	int *argc;
	char ***argv;
	int ret;

	// GTK runloop
	OGTKApplication *app =
	    [[OGTKApplication alloc] initWithApplicationId:@"net.frityet.exampleApp"
	                                             flags:G_APPLICATION_DEFAULT_FLAGS];
	[app connectSignal:@"activate" target:self selector:@selector(activateApplication:)];

	// ObjFW runloop
	[[OFApplication sharedApplication] getArgumentCount:&argc andArgumentValues:&argv];

	ret = [app runWithArgc:*argc argv:*argv];
	[OFApplication terminateWithStatus:ret];
}

- (void)activateApplication:(OGTKApplication *)app
{
	OGTKApplicationWindow *window = [[OGTKApplicationWindow alloc] initWithApplication:app];
	window.title = @"GTK4 by Objective-C using ObjFW";

	[window setDefaultSizeWithWidth:640 height:480];

	OGTKBox *box = [[OGTKBox alloc] initWithOrientation:GTK_ORIENTATION_VERTICAL spacing:0];
	box.halign = GTK_ALIGN_CENTER;
	box.valign = GTK_ALIGN_CENTER;

	window.child = box;

	OGTKButton *button = [[OGTKButton alloc] initWithLabel:@"Button clicked 0 times"];
	[button connectSignal:@"clicked" target:self selector:@selector(buttonClicked:)];

	[box append:button];
	[window present];
}

- (void)buttonClicked:(OGTKButton *)button
{
	button.label = [OFString stringWithFormat:@"Button clicked %zu times", ++count];
}

@end

OF_APPLICATION_DELEGATE(SmallExampleApp);
