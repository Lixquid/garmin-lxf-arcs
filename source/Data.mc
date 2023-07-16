import Toybox.Application;
import Toybox.Application.Properties;

module Data {
    module Strings {
        var SettingsMenu_Title = "Settings";

        var Setting_Background = "Background Color";
        var Setting_Foreground = "Foreground Color";
        var Setting_ShowSeconds = "Show Seconds";
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

        function load() {
            SettingsMenu_Title = Application.loadResource(
                $.Rez.Strings.SettingsTitle
            );

            Setting_Background = Application.loadResource(
                $.Rez.Strings.Setting_Background
            );
            Setting_Foreground = Application.loadResource(
                $.Rez.Strings.Setting_Foreground
            );
            Setting_ShowSeconds = Application.loadResource(
                $.Rez.Strings.Setting_ShowSeconds
            );
            Setting_ShowDate = Application.loadResource(
                $.Rez.Strings.Setting_ShowDate
            );
            Setting_ShowBattery = Application.loadResource(
                $.Rez.Strings.Setting_ShowBattery
            );

            Color_White = Application.loadResource($.Rez.Strings.Color_White);
            Color_Gray = Application.loadResource($.Rez.Strings.Color_Gray);
            Color_Black = Application.loadResource($.Rez.Strings.Color_Black);
            Color_Red = Application.loadResource($.Rez.Strings.Color_Red);
            Color_Orange = Application.loadResource($.Rez.Strings.Color_Orange);
            Color_Yellow = Application.loadResource($.Rez.Strings.Color_Yellow);
            Color_Green = Application.loadResource($.Rez.Strings.Color_Green);
            Color_Blue = Application.loadResource($.Rez.Strings.Color_Blue);
            Color_Purple = Application.loadResource($.Rez.Strings.Color_Purple);
            Color_Pink = Application.loadResource($.Rez.Strings.Color_Pink);
        }
    }

    module Settings {
        var background = 0xff00ff;
        var foreground = 0xff00ff;
        var showSeconds = false;
        var showDate = false;
        var showBattery = false;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
            showSeconds = Properties.getValue("Setting_ShowSeconds");
            showDate = Properties.getValue("Setting_ShowDate");
            showBattery = Properties.getValue("Setting_ShowBattery");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
            Properties.setValue("Setting_ShowSeconds", showSeconds);
            Properties.setValue("Setting_ShowDate", showDate);
            Properties.setValue("Setting_ShowBattery", showBattery);
        }
    }
}
