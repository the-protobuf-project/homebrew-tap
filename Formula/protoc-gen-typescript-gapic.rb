class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v5.3.0/protoc-gen-typescript_gapic_5.3.0.tar.gz"
  sha256 "12f3d19f747882c46c2ad39f741b483f4e4b2bf7ba29ad9527b81d170fcce737"
  license "Apache-2.0"
  version "5.3.0"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (bin/"protoc-gen-typescript_gapic").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/build/typescript/src/protoc-plugin.js" "$@"
    SH
  end

  test do
    assert_predicate bin/"protoc-gen-typescript_gapic", :executable?
  end
end
