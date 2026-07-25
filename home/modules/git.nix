{ ... }:

{
  programs.git = {
    enable = true;

    ignores = [ ".direnv/" ".envrc" "shell.nix" ];

    settings = {
      user = {
        name = "Jacopo Trompeo";
        email = "jacopo.trompeo@gmail.com";
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      init.defaultBranch = "main";
    };

    includes = [
      {
        condition = "gitdir:~/Work/";
        contents.user.email = "jacopo.trompeo@synesthesia.it";
      }
    ];
  };
}
