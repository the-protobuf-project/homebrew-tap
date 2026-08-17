class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v5.0.1/protoc-gen-typescript_gapic_5.0.1.tar.gz"
  sha256 "0f0f5fa0e303bdd21a717ff62c4395aa3de78e8806302711341f7fcc1b6012a8"
  license "Apache-2.0"
  version "5.0.1"

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
