cask "arco" do
  arch arm: "arm64", intel: "x64"

  version "3.12.0"
  sha256 arm:   "4f0396144a2de7fb8b4d64093a4f81f5d37ca5ef7da9eb27e45399ba3ea84b33",
         intel: "70fe72867b18c5fba3eed131a9e4d79234f3ecce02abfec63cf9faf92c009381"

  url "https://github.com/devmatheusmota/arco/releases/download/v#{version}/Arco-#{version}-#{arch}.dmg",
      verified: "github.com/devmatheusmota/arco/"
  name "Arco"
  desc "Organizes, operates and resumes multiple coding agents and shells in parallel"
  homepage "https://github.com/devmatheusmota/arco"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Terminals and voice dictation run in their own Node processes, because their
  # native bindings target Node's ABI. Without a Node on the machine, every pane
  # stays empty.
  depends_on formula: "node"
  depends_on macos: :catalina

  app "Arco.app"

  # The build is unsigned, so everything inside the downloaded .dmg carries the
  # quarantine flag — including the helper binary every terminal is spawned
  # through, which macOS then refuses to run. Clearing it here is what `brew
  # install --cask --no-quarantine` would do, kept in the cask so the plain
  # install works too.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Arco.app"],
                   sudo:         false,
                   print_stderr: false
  end

  zap trash: [
    "~/.cache/arco",
    "~/.local/share/com.mota.arco",
    "~/Library/Application Support/Arco",
    "~/Library/Logs/Arco",
    "~/Library/Preferences/com.mota.arco.plist",
    "~/Library/Saved Application State/com.mota.arco.savedState",
  ]
end
