{ pkgs, userInfo, inputs, ... } : {
	home.sessionVariables = {
		BROWSER = "firefox";
	};

	programs.firefox =  {
        enable = true;
        profiles = {
            ${userInfo.username} = {
                id = 0;
                name = "${userInfo.username}";
                isDefault = true;
                extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
                    ublock-origin
                    firemonkey
                    keepassxc-browser
                    sponsorblock
                ];
                settings.extensions.autoDisableScopes = 0;
                userChrome = "${builtins.readFile ../firefox/userChrome.css}";
                # userContent = "${builtins.readFile ../firefox/userContent.css}";
                extraConfig = "${builtins.readFile ../firefox/user.js}";
            };
        };
	};
}
