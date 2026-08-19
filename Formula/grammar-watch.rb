class GrammarWatch < Formula
  desc "Watches a Claude Code session and reviews your English prompts in real time"
  homepage "https://github.com/xavierforge/grammar-watch"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.4.0/grammar-watch-aarch64-apple-darwin.tar.xz"
      sha256 "ee9eda1250c7d6acdedc5e1909300e969504a9a0a8134d0f5a5b16de788eb68b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.4.0/grammar-watch-x86_64-apple-darwin.tar.xz"
      sha256 "84cc7ff908deb56a767ea0dfc3006e27d4d8c9928c256ddce684b743dcebe2ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.4.0/grammar-watch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f4f1317953170c7eb752e7e812218c06679d8eeb767b446cd62d3015707a39d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.4.0/grammar-watch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c039d88c0d64324c2d8bbb77f262d72ace1f7a2fd5b69ba7bcc7e852b1c81ebf"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "grammar-watch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "grammar-watch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "grammar-watch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "grammar-watch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
