# References: https://github.com/Homebrew/homebrew-core/blob/d1828e15baf4350467cac0b53050ad2d337229ed/Formula/g/go.rb

class Go < Formula
  desc "Open source programming language to build simple/reliable/efficient software"
  homepage "https://go.dev/"
  license "BSD-3-Clause"
  version "1.25.6"

  depends_on macos: :monterey

  if Hardware::CPU.intel?
    url "https://go.dev/dl/go1.25.6.darwin-amd64.tar.gz"
    sha256 "e2b5b237f5c262931b8e280ac4b8363f156e19bfad5270c099998932819670b7"
  elsif Hardware::CPU.arm?
    url "https://go.dev/dl/go1.25.6.darwin-arm64.tar.gz"
    sha256 "984521ae978a5377c7d782fd2dd953291840d7d3d0bd95781a1f32f16d94a006"
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
