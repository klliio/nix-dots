import { sh, range } from '../utils.js';

const hyprland = await Service.import('hyprland');

const dispatch = (arg) => {
    sh(`hyprctl dispatch workspace ${arg}`);
};

export const Workspaces = (ws) =>
    Widget.Box({
        class_name: 'workspaces',
        children: range(ws || 20).map((i) =>
            Widget.EventBox({
                class_name: 'workspace',
                attribute: i,
                vpack: 'center',
                child: Widget.Box(),
                on_primary_click: (self) => dispatch(self.attribute),
                on_scroll_up: () => dispatch("m+1"),
                on_scroll_down: () => dispatch("m-1"),
                setup: (self) =>
                    self.hook(hyprland, () => {
                        self.toggleClassName(
                            'active',
                            hyprland.active.workspace.id === i
                        );
                        self.toggleClassName(
                            'occupied',
                            (hyprland.getWorkspace(i)?.windows || 0) > 0
                        );
                    }),
            })
        ),
        setup: (box) => {
            if (ws === 0) {
                box.hook(hyprland.active.workspace, () =>
                    box.children.map((btn) => {
                        btn.visible = hyprland.workspaces.some(
                            (ws) => ws.id === btn.attribute
                        );
                    })
                );
            }
        },
    });
