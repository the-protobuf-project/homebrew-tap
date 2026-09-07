class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v5.2.0/protoc-gen-typescript_gapic_5.2.0.tar.gz"
  sha256 "28ad3209fa321619a9b5fa17fd182f5ee0222c8851e2cb52e2bca5a8f5d590e2"
  license "Apache-2.0"
  version "5.2.0"

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
