# https://github.com/Homebrew/homebrew-core/blob/bc3642b346d015033f5ef7a41cdc75194a1fee22/Formula/u/usage.rb
# @repo https://github.com/jdx/usage

class Usage < Formula
  desc "Tool for working with usage-spec CLIs"
  homepage "https://usage.jdx.dev/"
  license "MIT"
  version "6.12.0"
  compatibility_version 1

  depends_on :macos

  url "https://gh-proxy.com/https://github.com/jdx/usage/releases/download/v6.12.0/usage-universal-apple-darwin.tar.gz"
  sha256 "1e43be745db2fd81259e2b0e68d689d7f55b93da815f452c2154710f6de6ec52"

  def install
    bin.install "usage"
    generate_completions_from_executable(bin/"usage", "--completions")
    man1.install "usage.1"
  end

  test do
    assert_match "usage-cli", shell_output("#{bin}/usage --version").chomp
    assert_equal "--foo", shell_output("#{bin}/usage complete-word --spec 'flag \"--foo\"' -").chomp
  end
end
