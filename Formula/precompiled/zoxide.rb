# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/z/zoxide.rb
# @repo https://github.com/ajeetdsouza/zoxide

class Zoxide < Formula
  desc "Shell extension to navigate your filesystem faster"
  homepage "https://github.com/ajeetdsouza/zoxide"
  license "MIT"
  version "0.10.0"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/ajeetdsouza/zoxide/releases/download/v0.10.0/zoxide-0.10.0-x86_64-apple-darwin.tar.gz"
    sha256 "18ab7ae2633ad6e2ab79a4e665cbba1e95b7c872d44523326efb793202451dad"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/ajeetdsouza/zoxide/releases/download/v0.10.0/zoxide-0.10.0-aarch64-apple-darwin.tar.gz"
    sha256 "b55ae6f2f5f23d0a6ccb3bd4eeb2af9c7e0a6556e5255c82100e40305129bbb0"
  end

  def install
    bin.install "zoxide"
    bash_completion.install "completions/zoxide.bash" => "zoxide"
    zsh_completion.install "completions/_zoxide"
    fish_completion.install "completions/zoxide.fish"
    share.install "man"
  end

  test do
    assert_empty shell_output("#{bin}/zoxide add /").strip
    assert_equal "/", shell_output("#{bin}/zoxide query").strip
  end
end
