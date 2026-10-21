# References: https://github.com/Homebrew/homebrew-core/blob/d89a759a2b2e3bfd35c1dc39eb4aa549dc14f078/Formula/y/yq.rb
# @repo https://github.com/mikefarah/yq

class Yq < Formula
  desc "Process YAML, JSON, XML, CSV and properties documents from the CLI"
  homepage "https://github.com/mikefarah/yq"
  license "MIT"
  version "4.54.1"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.54.1/yq_darwin_amd64.tar.gz"
    sha256 "b2cc367e9f5491b3b9b191aa19ba3a3163daf99d84f90bc7bd8918010a66e69a"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/mikefarah/yq/releases/download/v4.54.1/yq_darwin_arm64.tar.gz"
    sha256 "60d0c91aa8bf4030d38e80bb05f84c20be2e955f24d62b2e55d15ad643fa7afa"
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
