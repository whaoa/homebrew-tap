# References: https://github.com/Homebrew/homebrew-core/blob/6857a1c7cb9e13f1b757b5a4a26063feb1ef36f8/Formula/r/ruby-build.rb
# @patched remap the dependencies to this tap

# For those packages:
# - rbenv > ruby-build

class RubyBuild < Formula
  desc "Install various Ruby versions and implementations"
  homepage "https://rbenv.org/man/ruby-build.1"
  url "https://gh-proxy.com/https://github.com/rbenv/ruby-build/archive/refs/tags/v20260412.tar.gz"
  sha256 "7215fbadd7e57d9fa1b6939f478e50bb6929e9044226a50f405962c7aeb0c969"
  license "MIT"
  compatibility_version 1
  head "https://gh-proxy.com/https://github.com/rbenv/ruby-build.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "7906fda7fe12636225bd5a349c9753c5705d841685ac81514a568e3931a0beb3"
  end

  depends_on "autoconf"
  depends_on "libyaml"
  depends_on "whaoa/tap/openssl@3"
  depends_on "pkgconf"
  depends_on "whaoa/tap/readline"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "2.0.0", shell_output("#{bin}/ruby-build --definitions")
  end
end
