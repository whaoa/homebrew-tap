# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/y/yq.rb
# @repo https://github.com/mikefarah/yq

class Yq < Formula
  desc "Process YAML, JSON, XML, CSV and properties documents from the CLI"
  homepage "https://github.com/mikefarah/yq"
  license "MIT"
  version "4.52.5"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.52.5/yq_darwin_amd64.tar.gz"
    sha256 "672029a24f3038f29fe5fb5a15d600c00ab6affbd5a92e880d3319d629fdee9e"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.52.5/yq_darwin_arm64.tar.gz"
    sha256 "4613600ee3416000a223f28b5323d3f003ee5bb4c18c5fa916450d31d686aecb"
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
