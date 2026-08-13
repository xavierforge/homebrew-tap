class GrammarWatch < Formula
  desc "Watches a Claude Code session and reviews your English prompts in real time"
  homepage "https://github.com/xavierforge/grammar-watch"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.0/grammar-watch-aarch64-apple-darwin.tar.xz"
      sha256 "d5575325f9a948c27fb25219e2eb3c09e4921f0c8eea1cc00a57f53db5263b2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.0/grammar-watch-x86_64-apple-darwin.tar.xz"
      sha256 "0e4de29645958795ca5df03a82c9023bb7b47845c532e58cc1252ed92732dfa2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.0/grammar-watch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c727268d7575fed1931c832f064386e1492b760441262956c049de8ba11cbc54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.0/grammar-watch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0680a9d72a153f4a322ef673a97d127a12fa0f6e5d314829f55d66c45f48354d"
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
