import Toybox.WatchUi;

module SettingsMenu {
    module LayoutMenu {
        class Delegate extends WatchUi.Menu2InputDelegate {
            (:initialized)
            private var _parentMenu as SettingsMenu.Delegate;

            function initialize(parentMenu as SettingsMenu.Delegate) {
                Menu2InputDelegate.initialize();
                _parentMenu = parentMenu;
            }

            function onSelect(item as MenuItem) {
                Data.Settings.layout = item.getId() as Data.LAYOUT;
                Data.Settings.save();
                _parentMenu.rebuild();
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
            }
        }

        function create() {
            var menu = new WatchUi.Menu2({
                :title => Data.Strings.Setting_Layout,
            });

            var layouts = Data.Strings.Map.layouts.keys();
            for (var i = 0; i < layouts.size(); i++) {
                menu.addItem(
                    new WatchUi.MenuItem(
                        Data.Strings.Map.layouts[layouts[i]],
                        null,
                        layouts[i],
                        null
                    )
                );
            }

            return menu;
        }

        function show(parentMenu as SettingsMenu.Delegate) {
            WatchUi.pushView(
                create(),
                new Delegate(parentMenu),
                WatchUi.SLIDE_LEFT
            );
        }
    }
}
