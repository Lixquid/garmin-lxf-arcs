import Toybox.Application.Properties;

module Data {
    module Strings {
        var SettingsMenu_Title = "Settings";

        var Setting_Background = "Background Color";
        var Setting_Foreground = "Foreground Color";
        var Setting_ShowDate = "Show Date";
        var Setting_ShowBattery = "Show Battery";

        var Color_White = "White";
        var Color_Gray = "Gray";
        var Color_Black = "Black";
        var Color_Red = "Red";
        var Color_Orange = "Orange";
        var Color_Yellow = "Yellow";
        var Color_Green = "Green";
        var Color_Blue = "Blue";
        var Color_Purple = "Purple";
        var Color_Pink = "Pink";

        // TODO: Load from strings file
    }

    module Settings {
        var background = 0xff00ff;
        var foreground = 0xff00ff;
        var showDate = false;
        var showBattery = false;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
            showDate = Properties.getValue("Setting_ShowDate");
            showBattery = Properties.getValue("Setting_ShowBattery");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
            Properties.setValue("Setting_ShowDate", showDate);
            Properties.setValue("Setting_ShowBattery", showBattery);
        }
    }
}
