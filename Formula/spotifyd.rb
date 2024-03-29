class Spotifyd < Formula
  desc " A spotify daemon "
  homepage "https://github.com/Spotifyd/spotifyd"
  url "https://github.com/Spotifyd/spotifyd/releases/download/v0.3.3/spotifyd-macos-full.tar.gz"
  sha256 "3a9803452e1fe9fa16eeb292808add57169688cf4ba49591416b5a575a830c19"

  depends_on "dbus"
  depends_on "portaudio"

  def install
    bin.install "spotifyd"
    # https://github.com/Spotifyd/spotifyd#configuration-file
    (buildpath/"spotifyd.conf").write <<~EOS
      [global]
      # Your Spotify account name.
      username = username

      # Your Spotify account password.
      password = password

      # A command that gets executed and can be used to
      # retrieve your password.
      # The command should return the password on stdout.
      #
      # This is an alternative to the `password` field. Both
      # can't be used simultaneously.
      password_cmd = command_that_writes_password_to_stdout

      # If set to true, `spotifyd` tries to look up your
      # password in the system's password storage.
      #
      # This is an alternative to the `password` field. Both
      # can't be used simultaneously.
      use_keyring = true

      # The audio backend used to play the your music. To get
      # a list of possible backends, run `spotifyd --help`.
      backend = alsa

      # The alsa audio device to stream audio to. To get a
      # list of valid devices, run `aplay -L`,
      device = alsa_audio_device  # omit for macOS

      # The alsa control device. By default this is the same
      # name as the `device` field.
      control = alsa_audio_device  # omit for macOS

      # The alsa mixer used by `spotifyd`.
      mixer = PCM

      # The volume controller. Each one behaves different to
      # volume increases. For possible values, run
      # `spotifyd --help`.
      volume_controller = alsa  # use softvol for macOS

      # A command that gets executed in your shell after each song changes.
      on_song_change_hook = command_to_run_on_playback_events

      # The name that gets displayed under the connect tab on
      # official clients. Spaces are not allowed!
      device_name = device_name_in_spotify_connect

      # The audio bitrate. 96, 160 or 320 kbit/s
      bitrate = 160

      # The director used to cache audio data. This setting can save
      # a lot of bandwidth when activated, as it will avoid re-downloading
      # audio files when replaying them.
      #
      # Note: The file path does not get expanded. Environment variables and
      # shell placeholders like $HOME or ~ don't work!
      cache_path = cache_directory

      # If set to true, audio data does NOT get cached.
      no_audio_cache = true

      # If set to true, enables volume normalisation between songs.
      volume_normalisation = true

      # The normalisation pregain that is applied for each song.
      normalisation_pregain = -10

      # The port `spotifyd` uses to announce its service over the network.
      zeroconf_port = 1234

      # The proxy `spotifyd` will use to connect to spotify.
      proxy = http://proxy.example.org:8080

      # The displayed device type in Spotify clients.
      # Can be unknown, computer, tablet, smartphone, speaker, tv,
      # avr (Audio/Video Receiver), stb (Set-Top Box), and audiodongle.
      device_type = speaker
    EOS
    (pkgshare/"examples").install "#{buildpath}/spotifyd.conf"
  end

  plist_options :manual => "spotifyd"

  # https://github.com/Spotifyd/spotifyd#on-macos
  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>rustlang.spotifyd</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{HOMEBREW_PREFIX}/bin/spotifyd</string>
        <string>--config-path=#{ENV['HOME']}/.config/spotifyd/spotifyd.conf</string>
        <string>--no-daemon</string>
     </array>
     <key>UserName</key>
     <string>#{ENV['USER']}</string>
     <key>KeepAlive</key>
     <true/>
     <key>ThrottleInterval</key>
     <integer>30</integer>
    </dict>
   </plist>
    EOS
  end

  def caveats
    s = <<~EOS
    You need to create a spotifyd configuration file.
    Copy the example configuration into your home directory:
      mkdir ~/.config/spotifyd
      cp #{opt_pkgshare}/examples/spotifyd.conf ~/.config/spotifyd/

    For more info see: https://github.com/Spotifyd/spotifyd#configuration-file
    EOS
    s
  end

  test do
    system "#{bin}/spotifyd", "--version"
  end
end
