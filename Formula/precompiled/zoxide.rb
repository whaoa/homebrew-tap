# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/z/zoxide.rb

class Zoxide < Formula
  desc "Shell extension to navigate your filesystem faster"
  homepage "https://github.com/ajeetdsouza/zoxide"
  license "MIT"
  version "0.9.8"

  depends_on :macos

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1467f17fb6fc40689476e7a23c899ce2d7d1973ef3185befbd23bf700cbbc33b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6cea8e6116f5dcc487213bc9f1013447ba766967294c091f479858969764ebfa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "414ab1396110a83c89418c22c1b818be4e63e129b9cb62417684af9ee67af857"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5e9391352600b9256d830f483a689290bdb037cebb883e9f04c8f1790a8ae8ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "26b19beed6f0572caef1415bdc74f295410526de07b1f95c345e5a441b26a1ba"
    sha256 cellar: :any_skip_relocation, ventura:       "dc21a28b1f3959472ffdc6bf60cde72bb1625ab95de744175901d908a98500cd"
  end

  if Hardware::CPU.intel?
    url "https://ghfast.top/https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.8/zoxide-0.9.8-x86_64-apple-darwin.tar.gz"
    sha256 "cfa865ffd1ba87df2962f40ebd80c366f1d2b484f0c05b6da6b0104f50822f86"
  elsif Hardware::CPU.arm?
    url "https://ghfast.top/https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.8/zoxide-0.9.8-aarch64-apple-darwin.tar.gz"
    sha256 "3d1ec4af7f3d351629f500b432e6c735caf3216ab3eaa76dbe8ffbc8f3006f5a"
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
