class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v4.12.2/protoc-gen-typescript_gapic_4.12.2.tar.gz"
  sha256 "fccfee6f63c0a7c6343441801a2667d861677044f4384fc2ecc499281cf8b0ca"
  license "Apache-2.0"
  version "4.12.2"

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
