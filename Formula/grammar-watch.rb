class GrammarWatch < Formula
  desc "Watches a Claude Code session and reviews your English prompts in real time"
  homepage "https://github.com/xavierforge/grammar-watch"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.5.1/grammar-watch-aarch64-apple-darwin.tar.xz"
      sha256 "edb373f8b9e5a39439c3642b503af9196b1f5f65cd9aae08b0060a15cded0121"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.5.1/grammar-watch-x86_64-apple-darwin.tar.xz"
      sha256 "3205c253f87ede1dc34ac834c328596ea3b49fd3b6793a0748bfb72d49e1bd74"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.5.1/grammar-watch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c95a3c975981bfa4784c2b9fbd841046ecfa1a62a1e263f54455d38d24849907"
    end
    if Hardware::CPU.intel?
      url "https://github.com/xavierforge/grammar-watch/releases/download/v0.5.1/grammar-watch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "26792c982198aec77f264efb1667626884832babb9cea46177e54820e79fd530"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
