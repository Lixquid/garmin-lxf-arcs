import Toybox.Lang;
import Toybox.WatchUi;

module SettingsMenu {
    module ColorMenu {
        class Delegate extends WatchUi.Menu2InputDelegate {
            private var _background = false;
            (:initialized)
            private var _parentMenu as SettingsMenu.Delegate;

            function initialize(
                parentMenu as SettingsMenu.Delegate,
                background as Boolean
            ) {
                Menu2InputDelegate.initialize();
                _parentMenu = parentMenu;
                _background = background;
            }

            function onSelect(item as MenuItem) {
                if (_background) {
                    Data.Settings.background = item.getId();
                } else {
                    Data.Settings.foreground = item.getId();
                }
                Data.Settings.save();
                _parentMenu.rebuild();
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
            }
        }

        function create(background as Boolean) {
            var menu = new WatchUi.Menu2({
                // TODO: Localize
                :title => background
                    ? Data.Strings.Setting_Background
                    : Data.Strings.Setting_Foreground,
            });

            var colors = Data.colors.keys();
            for (var i = 0; i < colors.size(); i++) {
                menu.addItem(
                    new WatchUi.MenuItem(
                        Data.colors[colors[i]],
                        null,
                        colors[i],
                        null
                    )
                );
            }

            return menu;
        }

        function show(
            parentMenu as SettingsMenu.Delegate,
            background as Boolean
        ) {
            WatchUi.pushView(
                create(background),
                new Delegate(
                    parentMenu as SettingsMenu.Delegate,
                    background as Boolean
                ),
                WatchUi.SLIDE_LEFT
            );
        }
    }
}
