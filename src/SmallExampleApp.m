/*
 * SPDX-FileCopyrightText: 2024 Amrit Bhogal <ambhogal01@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

#import <ObjFW/ObjFW.h>
#import <ObjGTK4/ObjGTK4-Umbrella.h>

@interface SmallExampleApp: OFObject <OFApplicationDelegate>
@property (strong) OGTKApplicationWindow *window;
@property (strong) OGTKBox *box;
@property (strong) OGTKButton *button;
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
	[app connectSignal:@"activate" target:self selector:@selector(onActivate:)];

	// ObjFW runloop
	[[OFApplication sharedApplication] getArgumentCount:&argc andArgumentValues:&argv];

	ret = [app runWithArgc:*argc argv:*argv];
	[OFApplication terminateWithStatus:ret];
}

- (void)onActivate:(OGTKApplication *)app
{
	self.window = [[OGTKApplicationWindow alloc] init:app];
	self.window.title = @"Hello, World!";

	[self.window setDefaultSizeWithWidth:640 height:480];

	self.box = [[OGTKBox alloc] initWithOrientation:GTK_ORIENTATION_VERTICAL spacing:0];
	self.box.halign = GTK_ALIGN_CENTER;
	self.box.valign = GTK_ALIGN_CENTER;

	self.window.child = self.box;

	self.button = [[OGTKButton alloc] initWithLabel:@"Button clicked 0 times"];
	[self.button connectSignal:@"clicked" target:self selector:@selector(onButtonClicked:)];

	[self.box append:self.button];
	[self.window present];
}

- (void)onButtonClicked:(OGTKButton *)button
{
	button.label = [OFString stringWithFormat:@"Button clicked %zu times", ++count];
}

@end

OF_APPLICATION_DELEGATE(SmallExampleApp);
