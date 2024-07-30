{ pkgs, config, ... }:
    let
       termColours = {
          black = "\\[\\e[0;30m\\]";
          red = "\\[\\e[0;31m\\]";
          green = "\\[\\e[0;32m\\]";
          yellow = "\\[\\e[0;33m\\]";
          blue = "\\[\\e[0;34m\\]";
          purple = "\\[\\e[0;35m\\]";
          teal = "\\[\\e[0;36m\\]";
          grey = "\\[\\e[0;37m\\]";

          bBlack = "\\[\\e[1;30m\\]";
          bRed = "\\[\\e[1;31m\\]";
          bGreen = "\\[\\e[1;32m\\]";
          bYellow = "\\[\\e[1;33m\\]";
          bBlue = "\\[\\e[1;34m\\]";
          bPurple = "\\[\\e[1;35m\\]";
          bTeal = "\\[\\e[1;36m\\]";
          bGrey = "\\[\\e[1;37m\\]";

          close = "\\[\\e[m\\]";
        };
     
      misc = {
        downRight = "\\342\\224\\217";
        upRight = "\\342\\224\\227";
        leftRight = "\\342\\224\\201";
      };
      shellAliases = {
        # ls
        "ls" = "ls --si --color=auto";
        "lsa" = "ls -a";
        "lsl" = "ls -l";
        "lsal" = "ls -al";
        "lsla" = "ls -al";
  
        # alacritty
        "new" = "alacritty msg create-window --working-directory '$(pwd)'";

        # git
        "gp" = "git push";
        "gc" = "git commit";
        "gca" = "git commit -a";
        "gco" = "git checkout";
        "gr" = "git rebase";
        "gb" = "git branch";
        "gm" = "git merge";
        "gl" = "git log";

        "suco" = "sudo";
      };
    in {
    programs.bash = { 
      enable = true;
      historyControl = ["ignoreboth" "erasedups"];
      inherit shellAliases;

      # initExtra = "SHELL=${pkgs.bash}";
      bashrcExtra = ''
          if [ "$(tty | grep -i tty)" = "" ]; then
              PS1="\n${termColours.blue}${misc.downRight}${termColours.close}${termColours.yellow}boo${termColours.close} ${termColours.teal}\w${termColours.close}\n${termColours.blue}${misc.upRight}${misc.leftRight}${termColours.close} "
          else
            PS1="\n\u@\h: \w\n > "
          fi
        '';

    };
}
