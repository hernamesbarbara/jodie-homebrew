class Jodie < Formula
  include Language::Python::Virtualenv

  desc "Jodie lets you add contacts to Contacts.app on macOS from command line"
  homepage "https://github.com/hernamesbarbara/jodie"
  url "https://github.com/hernamesbarbara/jodie/archive/refs/heads/main.zip"
  version "0.1.0"
  sha256 "9a19c61ef1855c6ece08311f0b5774a44add3e2424a513db823d84b36ce7be01"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
    
    system "python3", "-m", "build", "--sdist"
    Dir.glob("dist/jodie-*.tar.gz") { |file| system "tar", "-ztvf", file }
    
    system libexec/"bin/pip", "install", "pyinstaller==6.5.0"
    
    Dir.chdir("dist") do
      sdist_tar = Dir.glob("jodie-*.tar.gz").first
      system "tar", "-xvf", sdist_tar
      
      Dir.glob("jodie-*") do |dir|
        Dir.chdir(dir) do
          # Assuming the entitlements file is at the root of the sdist
          entitlements_path = Pathname.pwd/"jodie-entitlements"
          # Assuming APPLE_DEVELOPER_ID_APPLICATION is set as an environment variable for the formula
          apple_developer_id = ENV["APPLE_DEVELOPER_ID_APPLICATION"]
          
          # Building the application with PyInstaller
          system libexec/"bin/pyinstaller", \
                 "--name", "jodie", \
                 "--onedir", "jodie/__main__.py", \
                 "--osx-entitlements-file", entitlements_path.to_s, \
                 "--codesign-identity", apple_developer_id
        end
      end
    end
    
    # Update the path according to where PyInstaller outputs the final binary/executable
    bin.install "dist/jodie/dist/jodie"
  end
end
