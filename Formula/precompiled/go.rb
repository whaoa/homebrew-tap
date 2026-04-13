# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/g/go.rb

class Go < Formula
  desc "Open source programming language to build simple/reliable/efficient software"
  homepage "https://go.dev/"
  license "BSD-3-Clause"
  version "1.26.2"

  depends_on macos: :monterey

  if Hardware::CPU.intel?
    url "https://mirrors.aliyun.com/golang/go1.26.2.darwin-amd64.tar.gz"
    sha256 "bc3f1500d9968c36d705442d90ba91addf9271665033748b82532682e90a7966"
  elsif Hardware::CPU.arm?
    url "https://mirrors.aliyun.com/golang/go1.26.2.darwin-arm64.tar.gz"
    sha256 "32af1522bf3e3ff3975864780a429cc0b41d190ec7bf90faa661d6d64566e7af"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/go*"]

    # Remove useless files.
    # Breaks patchelf because folder contains weird debug/test files
    rm_r(libexec/"src/debug/elf/testdata")
    # Binaries built for an incompatible architecture
    rm_r(libexec/"src/runtime/pprof/testdata")
    # Remove testdata with binaries for non-native architectures.
    rm_r(libexec/"src/debug/dwarf/testdata")
  end

  test do
    system bin/"lsd", "--version"
  end
end
