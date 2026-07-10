cask "vzt-flow" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "eccc348e7fc00f196f3397b6b7aa49618545aba1c6092460c226cc7ea3fdab3d",
         intel: "f5806de5ad27a65e272996a7b34c086eb6840443178c5b430f91392b03cd1eff"

  url "https://github.com/vonzelle-vzt/vzt-flow/releases/download/v#{version}/VZT.Flow_#{version}_#{arch}.dmg"
  name "VZT Flow"
  desc "Local, on-device voice dictation — no cloud, no subscription"
  homepage "https://github.com/vonzelle-vzt/vzt-flow"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :ventura

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

    Apple Silicon requires macOS 13.0; Intel requires macOS 13.3, because the
    bundled onnxruntime library will not load below that.

    Grant these three permissions in System Settings → Privacy & Security
    before dictation will work:
      - Microphone           (speech capture)
      - Accessibility        (paste transcript at cursor)
      - Input Monitoring     (global hotkey to start/stop dictation)

    Speech-to-text models are NOT bundled in the app — they download on
    first run (~2.5GB total: Parakeet TDT v3 ASR is required; the optional
    Qwen3 cleanup/polish model is additional). Make sure you're on a good
    connection before your first launch.

    This cask installs the menu-bar app only. For the `flow` CLI and the MCP
    server, run the installer with NO_APP=1 so it leaves this cask's app alone:
      NO_APP=1 curl -fsSL https://raw.githubusercontent.com/vonzelle-vzt/vzt-flow/main/scripts/install.sh | bash
    Without NO_APP=1 that script REPLACES /Applications/VZT Flow.app, leaving
    brew with a receipt for a bundle it no longer wrote.

    After every "brew upgrade --cask vzt-flow", macOS silently drops the
    Accessibility and Input Monitoring grants (this app is ad-hoc signed, so
    its code identity changes each release and the old grants stop matching).
    The hotkey will do nothing, and the System Settings checkbox will still
    look ticked. Fix it by clearing the stale grants, then re-granting:
      tccutil reset Accessibility com.vzt.flow
      tccutil reset ListenEvent com.vzt.flow

    Full docs: https://github.com/vonzelle-vzt/vzt-flow/blob/main/docs/USAGE-macOS.md
  EOS
end
