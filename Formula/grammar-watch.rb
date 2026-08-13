class GrammarWatch < Formula
  desc "Watches a Claude Code session and reviews your English prompts in real time"
  homepage "https://github.com/xavierforge/grammar-watch"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.1/grammar-watch-aarch64-apple-darwin.tar.xz"
      sha256 "cb18719dd65c0ed1502e22d3020468b4db1153cfb208b7e19239d296657fc966"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.1/grammar-watch-x86_64-apple-darwin.tar.xz"
      sha256 "64137ca4ff6f40847625b35dcda5e3fb824ce3accf1735d9ca796823f84ed9d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.1/grammar-watch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a9d2ab8521310a1c0362a2f94dd86e2edfdf1c3a387d2a1445a304eddbafcc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.1.1/grammar-watch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7fcd12c776b43829bdad1ce677ba595324ff257dca76e18e6bf4f598497f22bc"
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
