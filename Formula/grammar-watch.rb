class GrammarWatch < Formula
  desc "Watches a Claude Code session and reviews your English prompts in real time"
  homepage "https://github.com/xavierforge/grammar-watch"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.3.0/grammar-watch-aarch64-apple-darwin.tar.xz"
      sha256 "162076abd1cb663257a6fda6114026ff934c3141bece5482e3f3d45642a7e1ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.3.0/grammar-watch-x86_64-apple-darwin.tar.xz"
      sha256 "2842419abe4f8399eeb91772349db11920c5106c84869c03055e45b0e48a177b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.3.0/grammar-watch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff261a3ee2fdecba1479ec799f3e04210399c55558fc8ef6cb4ec8a802704f8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.3.0/grammar-watch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dee7789c2f595780c5dedd922bbf42a2e3a39c5bd2337dd06318c53d3bd28e89"
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
