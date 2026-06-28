class ProtocGenTypescriptGapic < Formula
  desc "GAPIC protoc plugin for TypeScript/Node (protoc-gen-typescript_gapic)"
  homepage "https://github.com/the-protobuf-project/gapic"
  url "https://github.com/the-protobuf-project/gapic/releases/download/ts-v4.12.1/protoc-gen-typescript_gapic_4.12.1.tar.gz"
  sha256 "513913127dac1afe9ef3909c070d31f4c1580c8cc920ae75c1689a8e6b553463"
  license "Apache-2.0"
  version "4.12.1"

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
