import Toybox.WatchUi;

module SettingsMenu {
    module HourMarksMenu {
        class Delegate extends WatchUi.Menu2InputDelegate {
            (:initialized)
            private var _parentMenu as SettingsMenu.Delegate;

            function initialize(parentMenu as SettingsMenu.Delegate) {
                Menu2InputDelegate.initialize();
                _parentMenu = parentMenu;
            }

            function onSelect(item as MenuItem) {
                Data.Settings.hourMarks = item.getId() as Data.HOURMARK;
                Data.Settings.save();
                _parentMenu.rebuild();
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
            }
        }

        function create() {
            var menu = new WatchUi.Menu2({
                :title => Data.Strings.Setting_HourMarks,
            });

            var hourMarks = Data.Strings.Map.hourMarks.keys();
            for (var i = 0; i < hourMarks.size(); i++) {
                menu.addItem(
                    new WatchUi.MenuItem(
                        Data.Strings.Map.hourMarks[hourMarks[i]],
                        null,
                        hourMarks[i],
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
