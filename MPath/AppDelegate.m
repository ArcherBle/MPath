//
//  AppDelegate.m
//  MPath
//
//  Created by kxz on 2020/12/11.
//

#import "AppDelegate.h"
#import <PDFKit/PDFKit.h>
@interface AppDelegate ()
@property (weak) IBOutlet NSButton *imagebutton;


@property (strong) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *pathshow;
@property (weak) IBOutlet NSPathControl *pathcontrol;

@property (weak) IBOutlet NSButton *copypath;
@property (weak) IBOutlet NSWindow *licensewindow;

@property (weak) IBOutlet PDFView *licensepdfshow;

@end
NSString *path;
NSOpenPanel *openfilepanel;
NSURL *pathurl;
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[_pathshow cell]setTitle:@""];
    [_licensewindow close];
 
    NSBundle *appbundle = [NSBundle bundleWithIdentifier:@"kxz.MPath"];
    NSString *pdfpath = [appbundle pathForResource:@"GPLLicense" ofType:@"pdf"];
    NSURL *pdfurl = [[NSURL alloc]initFileURLWithPath:pdfpath];
    PDFDocument *pdf = [[PDFDocument alloc]initWithURL:pdfurl];
    [_licensepdfshow setDocument:pdf];
    path = @"";
    openfilepanel = [NSOpenPanel openPanel];
    [openfilepanel setCanCreateDirectories:YES];
    [openfilepanel setCanChooseFiles:YES];
    [openfilepanel setCanCreateDirectories:YES];
    [_imagebutton setImage:[NSImage imageNamed:@""]];
    path = @"";
    [[_pathshow cell]setTitle:@""];
    pathurl = [[NSURL alloc]initWithString:@""];
    [_copypath setEnabled:NO];
    // Insert code here to initialize your application
    
}

- (IBAction)imagebuttonaction:(id)sender {
    if ([path  isEqual: @""]) {
       
    } else {
        [[NSWorkspace sharedWorkspace]selectFile:path inFileViewerRootedAtPath:@""];
    }
}


- (IBAction)choosefileaction:(id)sender {
    [openfilepanel runModal];
    
    
    if ([[[openfilepanel URL]path]   isEqual: @""]) {
        
      
    } else {
        [_imagebutton setImage:[[NSWorkspace sharedWorkspace]iconForFile:[[openfilepanel URL]path]]];
        [_copypath setEnabled:YES];
        path = [[openfilepanel URL]path];
        pathurl = [openfilepanel URL];
        [[_pathshow cell]setTitle:path];
        [_pathcontrol setURL:pathurl];
        path = [[openfilepanel URL]path];

        }
    
}
- (IBAction)copypathaction:(id)sender {
    [[NSPasteboard generalPasteboard]clearContents];
    [[NSPasteboard generalPasteboard]setString:[[_pathshow cell]title] forType:NSPasteboardTypeString];
}

- (IBAction)showfileinfinder:(id)sender {
    if ([path  isEqual: @""]) {
       
    } else {
        [[NSWorkspace sharedWorkspace]selectFile:path inFileViewerRootedAtPath:@""];
    }
}
- (IBAction)licenseshowbutton:(id)sender {
    [_licensewindow orderFront:nil];
}
- (IBAction)openmainwindowbutton:(id)sender {
    [_window orderFront:nil];
}
- (IBAction)printlicensebutton:(id)sender {
    [_licensepdfshow print:nil];
    
}
- (IBAction)savelicensebutton:(id)sender {
    NSSavePanel *savefile = [NSSavePanel savePanel];
    [savefile setMessage:@"Save file to path"];
    [savefile setTitle:@"Save file"];
    [savefile setAllowedFileTypes:@[@"pdf"]];
    
    [savefile runModal];
    NSBundle *appbundle = [NSBundle bundleWithIdentifier:@"kxz.MPath"];
    NSString *pdfpath = [appbundle pathForResource:@"GPLLicense" ofType:@"pdf"];
    NSData *data = [NSData dataWithContentsOfFile:pdfpath];
    [data writeToFile:[[savefile URL]path] atomically:NO];
    [[NSWorkspace sharedWorkspace]selectFile:[[savefile URL]path] inFileViewerRootedAtPath:@""];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    
    exit(0);
}


@end
