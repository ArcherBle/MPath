//
//  AppDelegate.swift
//  FrPDF
//
//  Created by kxz on 2020/12/2.
//

import Cocoa
import PDFKit
@main
class AppDelegate: NSObject, NSApplicationDelegate, NSSharingServicePickerDelegate {
    func none(){
        
    }
    @IBOutlet var window: NSWindow!
    
    
    
    @IBOutlet weak var dark: NSMenuItem!
    
    @IBOutlet weak var light: NSMenuItem!
    
    @IBOutlet weak var titleinput: NSTextField!
    
    
    @IBOutlet weak var subtitleinput: NSTextField!
    
    @IBOutlet weak var changetitlepanel: NSPanel!
    
    @IBOutlet weak var closeoropenwindow: NSMenuItem!
    
    
    @IBOutlet weak var pdfbody: PDFView!
    let statusbody = NSStatusBar.system.statusItem(withLength: -1.0)
    let choosecolorbody = NSColorPanel.shared
    let choosefilebody = NSOpenPanel.init()
    let sharingtomail = NSSharingService.init(named: NSSharingService.Name.composeEmail)
    let sharingtomessage = NSSharingService.init(named: NSSharingService.Name.composeMessage)
    let sharingtoairdrop = NSSharingService.init(named:  NSSharingService.Name.sendViaAirDrop)
  
    
    
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
      changetitlepanel.close()
        pdfbody.backgroundColor = .gridColor
        choosecolorbody.color = .gridColor
        choosecolorbody.showsAlpha = true
        choosecolorbody.setTarget(self)
        choosecolorbody.setAction(#selector(choosecolorbodychange))
        statusbody.button?.image = NSImage.init(named: "StatusbarIcon")
        statusbody.button?.target = self
        statusbody.button?.action =  #selector(statusbodyclick)
        choosefilebody.cancel(none())
        choosefilebody.canChooseDirectories = false
        choosefilebody.canChooseFiles = true
        choosefilebody.allowedFileTypes = ["pdf"]
        choosefilebody.canCreateDirectories = true
        choosefilebody.canHide = true
        window.orderFront(nil)
          
        pdfbody.autoScales = true
        pdfbody.document = PDFDocument.init(url: Bundle.main.url(forResource: "FrPDF_", withExtension: "pdf")!)
        choosecolorbody.mode = .wheel
        choosecolorbody.title = "Choose Color"
        // Insert code here to initialize your application
        
    }
    @objc func choosecolorbodychange(){
        pdfbody.backgroundColor = choosecolorbody.color
    }
    @objc func statusbodyclick(){
        window.orderFront(nil)
    }
    @IBAction func actiona(_ sender: Any) {
        choosecolorbody.orderFront(nil)
    }
    
    @IBAction func actionb(_ sender: Any) {
        choosefilebody.runModal()
        if choosefilebody.url == URL(string: "") {
      
                window.subtitle = ""
            
        } else {
            pdfbody.document = PDFDocument.init(url: choosefilebody.url!)
            window.subtitle = "Read"
            subtitleinput.cell?.title = "Read"
      
           
        }
        
    }
    
    @IBAction func actc(_ sender: Any) {

            window.subtitle = ""
        
        
        window.title = "FrPDF"
        choosecolorbody.color = .gridColor
        window.backgroundColor = .white
        choosecolorbody.showsAlpha = true
        choosecolorbody.setTarget(self)
        choosecolorbody.setAction(#selector(choosecolorbodychange))
        statusbody.button?.image = NSImage.init(named: "StatusbarIcon")
        statusbody.button?.target = self
        statusbody.button?.action =  #selector(statusbodyclick)
        choosefilebody.cancel(none())
        choosefilebody.canChooseDirectories = false
        choosefilebody.canChooseFiles = true
        choosefilebody.allowedFileTypes = ["pdf"]
        choosefilebody.canCreateDirectories = true
        choosefilebody.canHide = true
        pdfbody.backgroundColor = .gridColor
        pdfbody.document = PDFDocument.init(url: Bundle.main.url(forResource: "FrPDF_", withExtension: "pdf")!)
        
        choosecolorbody.title = "Choose Color"
        light.state = .on
        dark.state = .off
        choosecolorbody.mode = .wheel
    }
    
    @IBAction func okpush(_ sender: Any) {
        window.title = titleinput.cell!.title
        window.subtitle = subtitleinput.cell!.title
    }
    
    @IBAction func changewindowtitlepush(_ sender: Any) {
        titleinput.cell?.title = window.title
        subtitleinput.cell?.title = window.subtitle
        changetitlepanel.orderFront(nil)
        
    }
    
    @IBAction func sharingtomessage(_ sender: Any) {
        if choosefilebody.url == URL.init(string: "") {
            sharingtomessage?.perform(withItems: [pdfbody.document?.documentURL])
        } else {
            sharingtomessage?.perform(withItems: [choosefilebody.url])
        
               
        }
    }
    
    @IBAction func sharingtomail(_ sender: Any) {
       
            
        if choosefilebody.url == URL.init(string: "") {
            sharingtomail?.perform(withItems: [pdfbody.document?.documentURL])
        } else {
            sharingtomail?.perform(withItems: [choosefilebody.url])
            
               
        }
        
    }
    
    @IBAction func sharingtoairdrop(_ sender: Any) {
        if choosefilebody.url == URL.init(string: "") {
            sharingtoairdrop?.perform(withItems: [pdfbody.document?.documentURL])
        } else {
            sharingtoairdrop?.perform(withItems: [choosefilebody.url])
            
               
        }
        
    }
    
    
    @IBAction func closeoropenwindowaction(_ sender: Any) {
        if closeoropenwindow.title == "Close window" {
            window.close()
            closeoropenwindow.title = "Open window"
        }else{
            window.orderFront(nil)
            closeoropenwindow.title = "Close window"
        }
    }
    
    @IBAction func lightaction(_ sender: Any) {
        window.backgroundColor = .white
        light.state = .on
        dark.state = .off
        pdfbody.backgroundColor = .gridColor
        choosecolorbody.color = .gridColor
    }
    @IBAction func darkaction(_ sender: Any) {
        window.backgroundColor = .black
        pdfbody.backgroundColor = .black
        light.state = .off
        dark.state = .on
        choosecolorbody.color = .black
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    
    
}

