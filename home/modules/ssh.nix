{ ... }:

{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
      };

      "github-personal" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/home-gh-personal";
        IdentitiesOnly = true;
      };
      "github-work" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/home-gh-work";
        IdentitiesOnly = true;
      };
      "ssh.dev.azure.com" = {
        IdentityFile = "~/.ssh/home-azure";
        IdentitiesOnly = true;
        LogLevel = "ERROR";
      };
    };
  };
}
