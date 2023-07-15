import Toybox.Application.Properties;

module Data {
    module Strings {
        var SettingsMenu_Title = "Settings";

        var Setting_Background = "Background Color";
        var Setting_Foreground = "Foreground Color";

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
        var background = 0x000000;
        var foreground = 0xffffff;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
        }
    }
}
