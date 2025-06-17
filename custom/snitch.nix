{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule {
  pname = "snitch";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "thegenem0";
    repo = "snitch";
    rev = "master";
    sha256 = "sha256-bQmcwFmD0C4oKWTsSA+palrTF0nQCydTylx+cuQnpEA=";
  };

  proxyVendor = true;
  vendorHash = "sha256-fGmoD4aEWNKs2OxlXA3xvUbC4ZxwtcoK9lUrWN5Gs5k=";

  meta = with lib; {
    description =
      "Language agnostic tool that collects TODOs in the source code and reports them as Issues";
    homepage = "https://github.com/thegenem0/snitch";
    license = licenses.mit;
    maintainers = with maintainers; [ thegenem0 ];
    platforms = platforms.all;
  };
}
