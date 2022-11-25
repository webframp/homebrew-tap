cask "finch" do
  version "0.1.0"
  sha256 "b2a37b7e0225018017838d34339a699f3a52df9c34b33637283ef402fcb9c55c"

  url "https://github.com/runfinch/finch/releases/download/v#{version}/Finch-v#{version}-x86_64.pkg"
  appcast 'https://github.com/runfinch/finch/releases.atom'
  name "finch"
  desc "The Finch CLI an open source client for container development"
  homepage "https://github.com/runfinch/finch"

  pkg "Finch-v#{version}-x86_64.pkg"
end
