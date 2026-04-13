# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/f/fnm.rb

class Fnm < Formula
  desc "Fast and simple Node.js version manager"
  homepage "https://github.com/Schniz/fnm"
  license "GPL-3.0-only"
  version "1.38.1"

  depends_on :macos

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "64782e66d6b171629e37d30437799aeada431a3c6be452f263656753433b37df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e9803d57adb2d02e7880b8bd607248edcf60a2f1987d2a43c12bf42ceae62a0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c9ed0f6e703bc246c9f9728c26948f4d7671e3b79ff42e0e44a455be57b3e5fd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "69b22dacd824d71438a318fe052ea47e0e1b21fa1ce018e582f0466025fceac2"
    sha256 cellar: :any_skip_relocation, sonoma:        "356ec74426ac56b9f1072243bbee635fa9b799c815cf1d613e37ad40161d3f4e"
    sha256 cellar: :any_skip_relocation, ventura:       "a64ba998422c590b865e0a4f22f1b907b5696e6c1d7559f07b0329252a83d6c0"
  end

  url "https://ghfast.top/https://github.com/Schniz/fnm/releases/download/v1.38.1/fnm-macos.zip"
  sha256 "80deb3db3db45598f25aea594c10936a7658f70826104fe37e33b4072a5e11f9"

  def install
    bin.install "fnm"
    generate_completions_from_executable(bin/"fnm", "completions", "--shell")
  end

  test do
    system "#{bin}/fnm --version"
  end
end
