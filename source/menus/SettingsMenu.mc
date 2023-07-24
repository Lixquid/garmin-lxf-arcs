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
                case :layout:
                    LayoutMenu.show(self);
                    break;
                case :hourMarks:
                    HourMarksMenu.show(self);
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
                case :segmentedArcs:
                    Data.Settings.segmentedArcs = !Data.Settings.segmentedArcs;
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
                    Data.Strings.Map.colors.hasKey(Data.Settings.background)
                        ? Data.Strings.Map.colors[Data.Settings.background]
                        : Data.Settings.background.format("%06X"),
                    :background,
                    null
                )
            );
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_Foreground,
                    Data.Strings.Map.colors.hasKey(Data.Settings.foreground)
                        ? Data.Strings.Map.colors[Data.Settings.foreground]
                        : Data.Settings.foreground.format("%06X"),
                    :foreground,
                    null
                )
            );
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_Layout,
                    Data.Strings.Map.layouts[Data.Settings.layout],
                    :layout,
                    null
                )
            );
            menu.addItem(
                new WatchUi.MenuItem(
                    Data.Strings.Setting_HourMarks,
                    Data.Strings.Map.hourMarks[Data.Settings.hourMarks],
                    :hourMarks,
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
            menu.addItem(
                new WatchUi.ToggleMenuItem(
                    Data.Strings.Setting_SegmentedArcs,
                    null,
                    :segmentedArcs,
                    Data.Settings.segmentedArcs,
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
