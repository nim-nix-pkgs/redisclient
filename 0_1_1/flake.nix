{
  description = ''Redis client for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-redisclient-0_1_1.flake = false;
  inputs.src-redisclient-0_1_1.ref   = "refs/tags/0.1.1";
  inputs.src-redisclient-0_1_1.owner = "xmonader";
  inputs.src-redisclient-0_1_1.repo  = "nim-redisclient";
  inputs.src-redisclient-0_1_1.type  = "github";
  
  inputs."redisparser".owner = "nim-nix-pkgs";
  inputs."redisparser".ref   = "master";
  inputs."redisparser".repo  = "redisparser";
  inputs."redisparser".dir   = "0_1_1";
  inputs."redisparser".type  = "github";
  inputs."redisparser".inputs.nixpkgs.follows = "nixpkgs";
  inputs."redisparser".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-redisclient-0_1_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-redisclient-0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}