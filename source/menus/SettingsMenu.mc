import Toybox.WatchUi;

module SettingsMenu {
    var colorMap = {
        0xffffff => Data.Strings.Color_White,
        0xaaaaaa => Data.Strings.Color_Gray,
        0x000000 => Data.Strings.Color_Black,
        0xff0000 => Data.Strings.Color_Red,
        0xffaa00 => Data.Strings.Color_Orange,
        0xffff00 => Data.Strings.Color_Yellow,
        0x00aa00 => Data.Strings.Color_Green,
        0x0055ff => Data.Strings.Color_Blue,
        0xaa00ff => Data.Strings.Color_Purple,
        0xff55ff => Data.Strings.Color_Pink,
    };

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
                    colorMap.hasKey(Data.Settings.background)
                        ? colorMap[Data.Settings.background]
                        : Data.Settings.background,
                    :background,
                    null
                )
            );
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_Foreground,
                    colorMap.hasKey(Data.Settings.foreground)
                        ? colorMap[Data.Settings.foreground]
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
                    Data.Strings.Setting_CutoutMode,
                    null,
                    :cutoutMode,
                    Data.Settings.cutoutMode,
                    null
                )
            );
        }
    }
}
