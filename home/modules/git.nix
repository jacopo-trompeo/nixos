{ pkgs, ... }:

let
  workGitignore = pkgs.writeText "gitignore-work" ''
    .direnv/
    .envrc
    shell.nix
  '';
in
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Jacopo Trompeo";
        email = "github@trompeo.com";
        signingKey = "~/.ssh/home-gh-personal.pub";
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      init.defaultBranch = "main";
      commit.gpgsign = true;
      gpg.format = "ssh";
      fetch.prune = true;
      rerere.enabled = true;
      merge.conflictStyle = "zdiff3";
      diff.algorithm = "histogram";
    };

    includes = [
      {
        condition = "gitdir:~/Work/";
        contents = {
          user.email = "jacopo.trompeo@synesthesia.it";
          user.signingKey = "~/.ssh/home-gh-work.pub";
          core.excludesFile = "${workGitignore}";
        };
      }
    ];
  };
}
