repo:
{ ... }:
{
  nixpkgs.overlays = [
    (
      final: prev:
      let
        pkgs = import repo {
          system = final.stdenv.hostPlatform.system;
          config = final.config;
        };
      in
      {
        backports = pkgs;
      }
    )
  ];
}
