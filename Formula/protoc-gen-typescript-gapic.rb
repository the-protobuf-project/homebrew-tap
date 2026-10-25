class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v5.3.0/protoc-gen-typescript_gapic_5.3.0.tar.gz"
  sha256 "12f3d19f747882c46c2ad39f741b483f4e4b2bf7ba29ad9527b81d170fcce737"
  license "Apache-2.0"
  version "5.3.0"

  depends_on "node"

  # The 5.3.0 tarball is missing nunjucks (upstream lists it as a devDependency,
  # so the release's `npm prune --omit=dev` dropped it), which the templater
  # imports at runtime. Versions match the upstream package-lock.json.
  resource "nunjucks" do
    url "https://registry.npmjs.org/nunjucks/-/nunjucks-3.2.4.tgz"
    sha256 "3c060c7bd5be36c3a2b0cdf01d6589253a5efb3c66e5e06257dd8b08acc2f16f"
  end

  resource "a-sync-waterfall" do
    url "https://registry.npmjs.org/a-sync-waterfall/-/a-sync-waterfall-1.0.1.tgz"
    sha256 "1f014a7a019f7b5fd13adbb1cf61bc6e247417a627305912c181fd722ad3e00c"
  end

  resource "asap" do
    url "https://registry.npmjs.org/asap/-/asap-2.0.6.tgz"
    sha256 "5ab440764cf46d8d4783d3f1173c0269e4bf9ebf013ae5a9d4bc0197cd89ccde"
  end

  resource "commander" do
    url "https://registry.npmjs.org/commander/-/commander-5.1.0.tgz"
    sha256 "c2e7c6dc8c54e4159bf2e65b314f595d1c7ee98f7529b4b6ef1d0979b4834564"
  end

  def install
    libexec.install Dir["*"]
    resources.each do |r|
      r.stage { (libexec/"node_modules"/r.name).install Dir["*"] }
    end
    (bin/"protoc-gen-typescript_gapic").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/build/typescript/src/protoc-plugin.js" "$@"
    SH
  end

  test do
    assert_predicate bin/"protoc-gen-typescript_gapic", :executable?
    # Loading the templater fails if a runtime dependency is missing.
    system Formula["node"].opt_bin/"node", "--input-type=module", "-e",
           "await import('#{libexec}/build/typescript/src/templater.js')"
  end
end
