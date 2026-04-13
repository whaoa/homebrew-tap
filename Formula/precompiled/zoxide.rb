# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/z/zoxide.rb
# @repo https://github.com/ajeetdsouza/zoxide

class Zoxide < Formula
  desc "Shell extension to navigate your filesystem faster"
  homepage "https://github.com/ajeetdsouza/zoxide"
  license "MIT"
  version "0.9.9"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.9/zoxide-0.9.9-x86_64-apple-darwin.tar.gz"
    sha256 "364249cff18354397c72ebb6b8f7358404c051c486e0f2f7a46e36c86c16f8c7"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.9/zoxide-0.9.9-aarch64-apple-darwin.tar.gz"
    sha256 "57e733d0436309dae2ed97e46bba43937209395298e1d88812d4e893900cb40a"
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
