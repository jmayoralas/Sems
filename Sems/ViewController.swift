//
//  ViewController.swift
//  Sems
//
//  Created by Jose Luis Fernandez-Mayoralas on 27/6/16.
//  Copyright © 2016 Jose Luis Fernandez-Mayoralas. All rights reserved.
//

import Cocoa
import JMZeta80

private let kColorSpace = CGColorSpaceCreateDeviceRGB()
private let kInstantLoadEnabled = "(Instant load enabled)"
private let kInstantLoadDisabled = "(Instant load disabled)"

class ViewController: NSViewController, VirtualMachineStatus {
    private let open_dialog = NSOpenPanel()
    
    @IBOutlet weak var screenView: NSImageView!
    
    @objc var screen: VmScreen!
    var vm: VirtualMachine!
    let appVersionString = String(
        format: "Sems v%@.%@",
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String,
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        vm.run()
    }
    
    override func viewDidAppear() {
        self.view.window!.title = String(format: "%@ %@", appVersionString, kInstantLoadDisabled)
    }

    // MARK: Initialization
    func setup() {
        self.setupOpenDialog()
        self.screenView.imageScaling = .scaleProportionallyUpOrDown
        self.screen = VmScreen(zoomFactor: 2)
        
        configureVM()
        
        self.loadSpeccyRom()
        
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown) {(theEvent: NSEvent) -> NSEvent? in return self.onKeyDown(theEvent: theEvent)}
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyUp) {(theEvent: NSEvent) -> NSEvent? in return self.onKeyUp(theEvent: theEvent)}
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.flagsChanged) {(theEvent: NSEvent) -> NSEvent? in return self.onFlagsChanged(theEvent: theEvent)}
    }
    
    private func setupOpenDialog() {
        open_dialog.showsResizeIndicator = true
        open_dialog.showsHiddenFiles = false
        open_dialog.canChooseDirectories = true
        open_dialog.canCreateDirectories = true
        open_dialog.allowsMultipleSelection = false
    }
    
    private func loadSpeccyRom() {
        loadRomData(data: NSDataAsset(name: "Rom48k")!.data as NSData)
    }
    
    private func loadRomFile(path: String) {
        loadRomData(data: NSData(contentsOfFile: path)!)
    }
    
    private func loadRomData(data: NSData) {
        var buffer = [UInt8](repeating: 0, count: data.length)
        (data as NSData).getBytes(&buffer, length: data.length)
        
        try! self.vm.loadRomAtAddress(0x0000, data: buffer)
    }
    
    private func configureVM() {
        let clock = Clock()
        let bus = Bus16(clock: clock, screen: screen)
        let cpu = Cpu(bus: bus, clock: clock)
        let ula = Ula(screen: screen, clock: clock)
        
        vm = VirtualMachine(bus: bus, cpu: cpu, ula: ula, clock: clock, screen: screen)
        vm.delegate = self
    }
    private func errorShow(messageText: String) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        alert.addButton(withTitle: "OK")
        
        alert.messageText = messageText
        alert.runModal()
    }
    
    // MARK: Keyboard handling
    private func onKeyDown(theEvent: NSEvent) -> NSEvent? {
        if !theEvent.modifierFlags.contains(NSEvent.ModifierFlags.command) {
            if self.vm.isRunning() {
                self.vm.keyDown(char: KeyEventHandler.getChar(event: theEvent))
                return nil
            }
        }
        
        return theEvent
    }
    
    private func onKeyUp(theEvent: NSEvent) -> NSEvent? {
        if self.vm.isRunning() {
            self.vm.keyUp(char: KeyEventHandler.getChar(event: theEvent))
            return nil
        }
        return theEvent
    }
    
    private func onFlagsChanged(theEvent: NSEvent) -> NSEvent? {
        if self.vm.isRunning() {
            self.vm.specialKeyUpdate(special_keys: KeyEventHandler.getSpecialKeys(event: theEvent))
            return nil
        }
        return theEvent
    }
    
    // MARK: Screen handling
    func Z80VMScreenRefresh() {
        let image = imageFromARGB32Bitmap(
            pixels: self.screen.buffer,
            width: self.screen!.width,
            height: self.screen!.height
        )
        
        DispatchQueue.main.async { [unowned self] in
            self.screenView.image = image
        }
    }
    
    func imageFromARGB32Bitmap(pixels:[PixelData], width:Int, height:Int) -> NSImage {
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        assert(pixels.count == Int(width * height))
        
        var data = pixels // Copy to mutable []
        let providerRef = CGDataProvider.init(data: NSData(bytes: &data, length: data.count * MemoryLayout<PixelData>.size))
        
        let cgim = CGImage.init(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * MemoryLayout<PixelData>.size,
            space: kColorSpace,
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: CGColorRenderingIntent.defaultIntent
        )
        
        return NSImage(cgImage: cgim!, size: NSZeroSize)
    }
    
    // MARK: Menu selectors
    @IBAction func showDebugger(_ sender: AnyObject) {
        // do some validations here
        let storyBoard = NSStoryboard(name: "Main", bundle: nil)
        let debuggerWindowController = storyBoard.instantiateController(withIdentifier: "DebuggerWindowController") as! NSWindowController
        (debuggerWindowController.contentViewController as! DebuggerViewController).setVM(vm: self.vm)
        debuggerWindowController.showWindow(sender)
    }

    @IBAction func loadCustomRom(_ sender: AnyObject) {
        open_dialog.title = "Choose ROM file"
        open_dialog.allowedFileTypes = ["rom", "bin"]
        
        if open_dialog.runModal() == NSApplication.ModalResponse.OK {
            if let result = open_dialog.url {
                self.loadRomFile(path: result.path)
                self.resetMachine(sender)
            }
        }
    }
    
    @IBAction func openTape(_ sender: AnyObject) {
        open_dialog.title = "Choose a file"
        open_dialog.allowedFileTypes = ["tap", "tzx"]
        
        if open_dialog.runModal() == NSApplication.ModalResponse.OK {
            if let result = open_dialog.url {
                let path = result.path

                do {
                    try self.vm.openTape(path: path)
                } catch let error as TapeLoaderError {
                    self.handleTapeError(error: error)
                } catch {
                    self.handleUnknownError()
                }
            }
        }
    }
    
    @IBAction func playTape(_ sender: AnyObject) {
        guard !self.vm.instantLoadEnabled() else {
            self.errorShow(messageText: "Cannot play a tape when instant load is enabled")
            return
        }
        
        if self.vm.tapeIsPlaying() {
            self.vm.stopTape()
        } else {
            do {
                try vm.startTape()
            } catch let error as TapeLoaderError {
                self.handleTapeError(error: error)
            } catch {
                self.errorShow(messageText: "Unknown error")
            }
        }
    }
    
    @IBAction func resetMachine(_ sender: AnyObject) {
        self.vm.reset()
    }
    
    @IBAction func warpEmulation(_ sender: AnyObject) {
        self.vm.toggleWarp()
    }
    
    @IBAction func toggleInstantLoad(_ sender: AnyObject) {
        if self.vm.instantLoadEnabled() {
            self.view.window!.title = String(format: "%@ %@", self.appVersionString, kInstantLoadDisabled)
            self.vm.disableInstantLoad()
        } else {
            self.view.window!.title = String(format: "%@ %@", self.appVersionString, kInstantLoadEnabled)
            self.vm.enableInstantLoad()
        }
    }
    
    @IBAction func showTapeBlockSelector(_ sender: AnyObject) {
        // do some validations here
        do {
            let tapeBlockDirectory = try self.vm.getBlockDirectory()
            
            let storyBoard = NSStoryboard(name: "Main", bundle: nil)
            
            let tapeBlockSelectorWindowController = storyBoard.instantiateController(withIdentifier: "TapeBlockSelectorWindowController") as! NSWindowController
            
            if let tapeBlockSelectorWindow = tapeBlockSelectorWindowController.window {
                let tapeBlockSelectorViewController = tapeBlockSelectorWindowController.contentViewController as! TapeBlockSelectorViewController
                
                tapeBlockSelectorViewController.setBlockDirectory(blockDirectory: tapeBlockDirectory)
                
                let application = NSApplication.shared
                let modalResult = application.runModal(for: tapeBlockSelectorWindow)
                
                self.view.window!.makeMain()
                self.view.window!.makeKey()
                
                if modalResult == NSApplication.ModalResponse.OK {
                    do {
                        try self.vm.setCurrentTapeBlock(index: tapeBlockSelectorViewController.getSelectedTapeBlockIndex())
                    } catch let error as TapeLoaderError {
                        self.handleTapeError(error: error)
                    } catch {
                        self.handleUnknownError()
                    }
                }
            }
        } catch let error as TapeLoaderError {
            self.handleTapeError(error: error)
        } catch {
            self.handleUnknownError()
        }
    }
    
    // MARK: Error handlers
    func handleTapeError(error: TapeLoaderError) {
        self.errorShow(messageText: error.description)
    }
    
    func handleUnknownError() {
        self.errorShow(messageText: "Unknown error!")
    }
}

