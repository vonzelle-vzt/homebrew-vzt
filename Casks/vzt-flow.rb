cask "vzt-flow" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "cce8c967e00b6dbe8ccd061e36995a18b29ae502db30cd6b3495ba54b334fc66",
         intel: "6296eb8cdef6200896aa99905ac4551c171a6d9e444f07a65f95bda47368a1f2"

  url "https://github.com/vonzelle-vzt/vzt-flow/releases/download/v#{version}/VZT.Flow_#{version}_#{arch}.dmg"
  name "VZT Flow"
  desc "Local, on-device voice dictation — no cloud, no subscription"
  homepage "https://github.com/vonzelle-vzt/vzt-flow"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :monterey

  app "VZT Flow.app"

  zap trash: [
    "~/.config/vzt-flow",
    "~/Library/Application Support/com.vzt.flow",
    "~/Library/Preferences/com.vzt.flow.plist",
    "~/Library/Saved Application State/com.vzt.flow.savedState",
  ]

  caveats <<~EOS
    If "brew install --cask" refused to install this cask as untrusted, run
    "brew trust --cask vonzelle-vzt/vzt/vzt-flow" first, then re-run the
    install — some Homebrew versions gate third-party taps that way.

    VZT Flow is unsigned (ad-hoc signature, no Apple Developer ID). On first
    launch, macOS Gatekeeper will refuse to open it via a normal double-click.
    Right-click (or Control-click) the app in /Applications and choose "Open",
    then confirm in the dialog — only required once.

    Grant these three permissions in System Settings → Privacy & Security
    before dictation will work:
      - Microphone           (speech capture)
      - Accessibility        (paste transcript at cursor)
      - Input Monitoring     (global hotkey to start/stop dictation)

    Speech-to-text models are NOT bundled in the app — they download on
    first run (~2.5GB total: Parakeet TDT v3 ASR is required; the optional
    Qwen3 cleanup/polish model is additional). Make sure you're on a good
    connection before your first launch.

    This cask installs the menu-bar app only. For the `flow` CLI, run:
      curl -fsSL https://raw.githubusercontent.com/vonzelle-vzt/vzt-flow/main/scripts/install.sh | bash
    (skip the app portion of that script since brew already installed it —
    it detects an existing /Applications/VZT Flow.app and won't overwrite it)

    Full docs: https://github.com/vonzelle-vzt/vzt-flow/blob/main/docs/USAGE-macOS.md
  EOS
end
