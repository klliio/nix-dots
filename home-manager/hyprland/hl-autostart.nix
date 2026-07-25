{ pkgs, inputs, config, lib, ... } :
    let
        # utility
        notification = "${pkgs.mako}/bin/mako";
        polkit = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";

        lua = lib.generators.mkLuaInline;
        on = event: body: {
            _args = [
                event(lua ''function() ${body} end'')
            ];
        };
        exec = cmd: ''hl.exec_cmd("${cmd}")'';
    in {
        wayland.windowManager.hyprland.settings = {
            on = [
                (on "hyprland.start" ''
                    ${exec notification}
                    ${exec polkit}
                    ${exec "systemctl --user restart pipewire.service"}
                '')
            ];
        };
}
