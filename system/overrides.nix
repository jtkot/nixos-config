final: prev: {
  openrgb-beta = prev.openrgb.overrideAttrs (
    old:
    let
      commit = "a6b890a48d75325d47587131c74764b8e9a06a53";
    in
    {
      version = builtins.substring 0 8 commit;
      src = final.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = commit;
        hash = "sha256-54rkkwgxLOseRJru3RkX2aYE6y4ryzFUCHR423+Ni/I=";
      };
      patches = [ ];
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh --replace-fail "/usr/bin/env chmod" "${final.coreutils}/bin/chmod"
      '';
    }
  );
}
