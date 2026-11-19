cask "protoc-gen-http" do
  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "protoc-gen-http"], chdir: "."
    end
  end

  version "0.2.1"

  on_macos do
    on_arm do
      sha256 "548dbc38a85ab7a6f7ae3b4364699ec092d387ac95431aca80311a79a136820a"
      url "https://github.com/the-protobuf-project/http/releases/download/v#{version}/protoc-gen-http-v#{version}-darwin-arm64.tar.gz"
    end
    on_intel do
      sha256 "1ddf5ec183cef3eff22f302c6ae6f99cb2b58a709d7b1feb33b4d759f46b657f"
      url "https://github.com/the-protobuf-project/http/releases/download/v#{version}/protoc-gen-http-v#{version}-darwin-amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "72956fb6666495c30d6d78f4b9a346f9e0827f4bb47ecd95b2fd5bd9bc93e546"
      url "https://github.com/the-protobuf-project/http/releases/download/v#{version}/protoc-gen-http-v#{version}-linux-arm64.tar.gz"
    end
    on_intel do
      sha256 "835364eaaa99a610f057da24031fb20ea3534da6f745429ee6a7977a2ca1890b"
      url "https://github.com/the-protobuf-project/http/releases/download/v#{version}/protoc-gen-http-v#{version}-linux-amd64.tar.gz"
    end
  end

  name "protoc-gen-http"
  desc "Generate HTTP/JSON transcoding for gRPC services from google.api.http"
  homepage "https://github.com/the-protobuf-project/http"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "protoc-gen-http"

  zap :not_required
end
