class Librarian < Formula
  desc "Rust GAPIC client generator (googleapis/librarian)"
  homepage "https://github.com/the-protobuf-project/gapic"
  license "Apache-2.0"
  version "0.53.0"

  on_macos do
    on_arm do
      url "https://github.com/the-protobuf-project/gapic/releases/download/rs-v0.53.0/librarian_0.53.0_darwin_arm64.tar.gz"
      sha256 "4abb08207466ee8db2b799e5f2b1653aa386ac51a521adb99a53c4090ab43cfc"
    end
    on_intel do
      url "https://github.com/the-protobuf-project/gapic/releases/download/rs-v0.53.0/librarian_0.53.0_darwin_amd64.tar.gz"
      sha256 "03f04e70ad6a53053c39ce9577f746939be4ee3c22960068873540db2022b581"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/the-protobuf-project/gapic/releases/download/rs-v0.53.0/librarian_0.53.0_linux_arm64.tar.gz"
      sha256 "b9e8343a4f0425978a8af51666526ed81bc97858f3bf38142fef4f6f2309adfb"
    end
    on_intel do
      url "https://github.com/the-protobuf-project/gapic/releases/download/rs-v0.53.0/librarian_0.53.0_linux_amd64.tar.gz"
      sha256 "26c035467dcc9f9a5a1e3f80cf0e8abf88ebd78ced443e6392a5e168b6d11830"
    end
  end

  def install
    bin.install "librarian"
  end

  test do
    assert_predicate bin/"librarian", :executable?
  end
end
