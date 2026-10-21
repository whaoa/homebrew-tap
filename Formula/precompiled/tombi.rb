# https://github.com/Homebrew/homebrew-core/blob/6182eb4c55d3aec45ca2446b93de6e3bf87cefca/Formula/t/tombi.rb
# @repohttps://github.com/tombi-toml/tombi

class Tombi < Formula
  desc "TOML formatter, linter and language server"
  homepage "https://github.com/tombi-toml/tombi"
  license "MIT"
  version "1.8.9"

  depends_on :macos

  if Hardware::CPU.intel?
    url "https://gh-proxy.com/https://github.com/tombi-toml/tombi/releases/download/v1.8.9/tombi-cli-1.8.9-x86_64-apple-darwin.tar.gz"
    sha256 "c566db7e0d1b98b75ebdbd080d75407140039eb52a7af503e3028e318f01f8f2"
  elsif Hardware::CPU.arm?
    url "https://gh-proxy.com/https://github.com/tombi-toml/tombi/releases/download/v1.8.9/tombi-cli-1.8.9-aarch64-apple-darwin.tar.gz"
    sha256 "287d02319d42d997237cab16a9876c0c116ea654be82f31e19c10c0a24159a60"
  end

  def install
    bin.install "tombi"
    generate_completions_from_executable(bin/"tombi", "completion", shells: [:bash, :zsh, :fish, :pwsh])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tombi --version")

    require "open3"

    json = <<~JSON
      {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "initialize",
        "params": {
          "rootUri": null,
          "capabilities": {}
        }
      }
    JSON

    Open3.popen3(bin/"tombi", "lsp") do |stdin, stdout|
      stdin.write "Content-Length: #{json.size}\r\n\r\n#{json}"
      sleep 1
      assert_match(/^Content-Length: \d+/i, stdout.readline)
    end
  end
end
