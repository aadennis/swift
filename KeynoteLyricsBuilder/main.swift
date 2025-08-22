import Foundation

// MARK: - Config
let inputPath = "lyrics.txt"
let delaySeconds: Double = 5.0

// MARK: - Output Path
func keynotePath(from input: String) -> String {
    let url = URL(fileURLWithPath: input)
    let base = url.deletingPathExtension().lastPathComponent
    return url.deletingLastPathComponent().appendingPathComponent("\(base).key").path
}
let outputPath = keynotePath(from: inputPath)

// MARK: - Read Lyrics
guard let lyrics = try? String(contentsOfFile: inputPath) else {
    fatalError("❌ Could not read lyrics file at \(inputPath)")
}
let lines = lyrics.split(separator: "\n").map { String($0) }

// MARK: - Build AppleScript
var script = """
tell application "Keynote"
    activate
    set newDoc to make new document
"""

for line in lines {
    script += """

    tell newDoc
        set thisSlide to make new slide
        tell thisSlide
            set thisTextBox to make new shape with properties {shape type:text, object text:"\(line)"}
            set transition properties to {transition effect:dissolve, transition duration:\(delaySeconds)}
        end tell
    end tell
    """
}

script += """

save newDoc in POSIX file "\(outputPath)"
end tell
"""

// MARK: - Execute AppleScript
let task = Process()
task.launchPath = "/usr/bin/osascript"
task.arguments = ["-e", script]
task.launch()
task.waitUntilExit()

print("✅ Presentation saved to: \(outputPath)")
