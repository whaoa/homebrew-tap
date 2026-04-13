# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/y/yq.rb

class Yq < Formula
  desc "Process YAML, JSON, XML, CSV and properties documents from the CLI"
  homepage "https://github.com/mikefarah/yq"
  license "MIT"
  version "4.50.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.50.1/yq_darwin_amd64.tar.gz"
    sha256 "315a93772f66614f17dcbfe5dedf77b4ed6a210490f4ea7d1f730133f4e40143"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.50.1/yq_darwin_arm64.tar.gz"
    sha256 "dffadc64fd515f5fbe31e8c131e02536dbd288188acf077fb4aa19fe94b727d0"
  end

  def install
    if Hardware::CPU.intel?
      bin.install "yq_darwin_amd64" => "yq"
    elsif Hardware::CPU.arm?
      bin.install "yq_darwin_arm64" => "yq"
    end
    generate_completions_from_executable(bin/"yq", "shell-completion")
    man1.install "yq.1"
  end

  test do
    assert_equal "key: cat", shell_output("#{bin}/yq eval --null-input --no-colors '.key = \"cat\"'").chomp
    assert_equal "cat", pipe_output("#{bin}/yq eval .key -", "key: cat", 0).chomp
  end
end
