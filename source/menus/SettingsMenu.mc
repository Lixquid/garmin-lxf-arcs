import Toybox.Lang;
import Toybox.WatchUi;

module SettingsMenu {
    class Delegate extends WatchUi.Menu2InputDelegate {
        (:initialized)
        private var _menu as Menu2;

        function initialize(menu as Menu2) {
            Menu2InputDelegate.initialize();
            _menu = menu;
        }

        function onSelect(item as MenuItem) {
            switch (item.getId()) {
                case :foreground:
                    ColorMenu.show(self, false);
                    break;
                case :background:
                    ColorMenu.show(self, true);
                    break;
                case :showSeconds:
                    Data.Settings.showSeconds = !Data.Settings.showSeconds;
                    Data.Settings.save();
                    break;
                case :showDate:
                    Data.Settings.showDate = !Data.Settings.showDate;
                    Data.Settings.save();
                    break;
                case :showBattery:
                    Data.Settings.showBattery = !Data.Settings.showBattery;
                    Data.Settings.save();
                    break;
                case :numericHourMarks:
                    Data.Settings.numericHourMarks =
                        !Data.Settings.numericHourMarks;
                    Data.Settings.save();
                    break;
                case :cutoutMode:
                    Data.Settings.cutoutMode = !Data.Settings.cutoutMode;
                    Data.Settings.save();
                    break;
            }
        }

        function rebuild() {
            _Private.fillMenu(_menu);
        }
    }

    function create() {
        var menu = new WatchUi.Menu2({
            :title => Data.Strings.SettingsMenu_Title,
        });
        _Private.fillMenu(menu);
        return menu;
    }

    module _Private {
        function fillMenu(menu as Menu2) {
            // Clear Menu
            var item = menu.getItem(0);
            while (item != null) {
                menu.deleteItem(0);
                item = menu.getItem(0);
            }

            // Add Items
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_Background,
                    Data.colors.hasKey(Data.Settings.background)
                        ? Data.colors[Data.Settings.background]
                        : Data.Settings.background,
                    :background,
                    null
                )
            );
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_Foreground,
                    Data.colors.hasKey(Data.Settings.foreground)
                        ? Data.colors[Data.Settings.foreground]
                        : Data.Settings.foreground,
                    :foreground,
                    null
                )
            );

            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_ShowSeconds,
                    null,
                    :showSeconds,
                    Data.Settings.showSeconds,
                    null
                )
            );
            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_ShowDate,
                    null,
                    :showDate,
                    Data.Settings.showDate,
                    null
                )
            );
            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_ShowBattery,
                    null,
                    :showBattery,
                    Data.Settings.showBattery,
                    null
                )
            );
            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_NumericHourMarks,
                    null,
                    :numericHourMarks,
                    Data.Settings.numericHourMarks,
                    null
                )
            );
            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_CutoutMode,
                    null,
                    :cutoutMode,
                    Data.Settings.cutoutMode,
                    null
                )
            );

            menu.addItem(
                new WatchUi.MenuItem(
                    WatchUi.loadResource($.Rez.Strings.AppName),
                    WatchUi.loadResource($.Rez.Strings.AppVersion),
                    0,
                    null
                )
            );
        }
    }
}
