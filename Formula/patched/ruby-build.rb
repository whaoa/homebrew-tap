# References: https://github.com/Homebrew/homebrew-core/blob/6857a1c7cb9e13f1b757b5a4a26063feb1ef36f8/Formula/r/ruby-build.rb
# @patched remap the dependencies to this tap

# For those packages:
# - rbenv > ruby-build

class RubyBuild < Formula
  desc "Install various Ruby versions and implementations"
  homepage "https://rbenv.org/man/ruby-build.1"
  url "https://ghfast.top/https://github.com/rbenv/ruby-build/archive/refs/tags/v20260121.tar.gz"
  sha256 "18589f7cdff5f10db3ccdce2a05ef8fb2c07b29e17d275670754123a61555ee0"
  license "MIT"
  head "https://ghfast.top/https://github.com/rbenv/ruby-build.git", branch: "master"

  no_autobump! because: :requires_manual_review

  bottle do
    sha256 cellar: :any_skip_relocation, all: "2c82d5f8a4840ff6560781852a9ba1fad5fc69b6eed4a30c7df6ec22ccc3a674"
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
