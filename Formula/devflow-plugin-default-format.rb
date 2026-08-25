class DevflowPluginDefaultFormat < Formula
  desc "devflow plugin: Default Format"
  homepage "<your-plugin-homepage>"
  url "<release-url-to-default_format.py>"
  sha256 "<sha256-of-default_format.py>"
  version "0.1.1"

  depends_on "captainwonderwall/devflow/devflow"

  def install
    lib.install "default_format.py"
    vendor = lib/"vendor"
    vendor.mkpath
    Dir["vendor/*.whl"].each { |whl| vendor.install whl }
  end

  def post_install
    system "#{HOMEBREW_PREFIX}/bin/devflow-plugin",
           "register", "default-format",
           "#{opt_lib}/default_format.py",
           "--formula", "<your-tap>/default-format"
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/devflow-plugin", "list"
  end
end
