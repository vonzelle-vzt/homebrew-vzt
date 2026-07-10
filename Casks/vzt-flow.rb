cask "vzt-flow" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.1"
  sha256 arm:   "9a023b12acd1d31b7ad3c1fbbdd8e6a5f082e3901dce6a3a456068070d04cd4f",
         intel: "ffc9f88cdff09886a641c8f4865537ad6e36d9378287b0716fec2919f3ba322c"

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

    VZT Flow is signed with an Apple Developer ID and notarized by Apple, with
    the ticket stapled to the app, so it opens on a normal double-click.

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

    From 0.3.1 on, upgrades keep your Accessibility and Input Monitoring grants:
    a Developer ID signature gives macOS a code requirement that names the team
    rather than the exact binary, so it keeps matching across releases.

    Upgrading FROM 0.3.0 or earlier costs one last re-grant. Those builds were
    ad-hoc signed and their grants pinned the old binary's hash, so the hotkey
    will silently do nothing while System Settings still shows a ticked box.
    Clear the stale rows once, then re-grant when macOS asks:
      tccutil reset Accessibility com.vzt.flow
      tccutil reset ListenEvent com.vzt.flow

    Full docs: https://github.com/vonzelle-vzt/vzt-flow/blob/main/docs/USAGE-macOS.md
  EOS
end
