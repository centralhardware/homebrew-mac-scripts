// run-on-logout <user> <command> [args...]
// Waits in <user>'s GUI session and runs the command when that user logs out
// (or restarts / shuts down). Fast user switching does not trigger it.
import AppKit

let args = Array(CommandLine.arguments.dropFirst())
guard args.count >= 2 else {
    fputs("usage: run-on-logout <user> <command> [args...]\n", stderr)
    exit(0)
}
// Loaded for every user; exit 0 so launchd does not restart it for the others.
guard NSUserName() == args[0] else { exit(0) }

final class Delegate: NSObject, NSApplicationDelegate {
    private let timeout: TimeInterval = 10
    private var lastRun = Date.distantPast

    func runCommand() {
        // One logout can arrive through several of the paths below.
        guard Date().timeIntervalSince(lastRun) > 30 else { return }
        let p = Process()
        p.executableURL = URL(fileURLWithPath: args[1])
        p.arguments = Array(args.dropFirst(2))
        let done = DispatchSemaphore(value: 0)
        p.terminationHandler = { _ in done.signal() }
        do { try p.run() } catch {
            NSLog("run-on-logout: %@", error.localizedDescription)
            return
        }
        if done.wait(timeout: .now() + timeout) == .timedOut {
            NSLog("run-on-logout: command timed out")
            p.terminate()
        } else if p.terminationStatus != 0 {
            NSLog("run-on-logout: command exited with %d", p.terminationStatus)
        }
        lastRun = Date()
    }

    // Earliest signal: the session is still fully alive here.
    @objc func willPowerOff(_ n: Notification) { runCommand() }

    // Logout waits for this reply.
    func applicationShouldTerminate(_ app: NSApplication) -> NSApplication.TerminateReply {
        runCommand()
        return .terminateNow
    }

    // Non-zero, so launchd brings us back if the logout gets cancelled.
    func applicationWillTerminate(_ n: Notification) { exit(1) }
}

let app = NSApplication.shared
let delegate = Delegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)
NSWorkspace.shared.notificationCenter.addObserver(
    delegate, selector: #selector(Delegate.willPowerOff(_:)),
    name: NSWorkspace.willPowerOffNotification, object: nil)

// Fallback: launchd tearing the session down.
signal(SIGTERM, SIG_IGN)
let term = DispatchSource.makeSignalSource(signal: SIGTERM, queue: .main)
term.setEventHandler { delegate.runCommand(); exit(1) }
term.resume()

app.run()
