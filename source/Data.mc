import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;

module Data {
    var colors as Dictionary<Number, String> = {
        0xffffff => Strings.Color_White,
        0xaaaaaa => Strings.Color_Gray,
        0x555555 => Strings.Color_DarkGray,
        0x000000 => Strings.Color_Black,
        0xaa0000 => Strings.Color_Red,
        0xffaa00 => Strings.Color_Orange,
        0xffff00 => Strings.Color_Yellow,
        0x55aa00 => Strings.Color_Green,
        0x0055ff => Strings.Color_Blue,
        0xaa00ff => Strings.Color_Purple,
        0xff55ff => Strings.Color_Pink,
    };

    module Strings {
        var SettingsMenu_Title = "Settings";

        var Setting_Background = "Background Color";
        var Setting_Foreground = "Foreground Color";
        var Setting_ShowSeconds = "Show Seconds";
        var Setting_ShowDate = "Show Date";
        var Setting_ShowBattery = "Show Battery";
        var Setting_NumericHourMarks = "Numeric Hour Marks";
        var Setting_CutoutMode = "Cutout Mode";

        var Color_White = "White";
        var Color_Gray = "Gray";
        var Color_DarkGray = "Dark Gray";
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
            Setting_NumericHourMarks = Application.loadResource(
                $.Rez.Strings.Setting_NumericHourMarks
            );
            Setting_CutoutMode = Application.loadResource(
                $.Rez.Strings.Setting_CutoutMode
            );

            Color_White = Application.loadResource($.Rez.Strings.Color_White);
            Color_Gray = Application.loadResource($.Rez.Strings.Color_Gray);
            Color_DarkGray = Application.loadResource(
                $.Rez.Strings.Color_DarkGray
            );
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
        var numericHourMarks = false;
        var cutoutMode = false;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
            showSeconds = Properties.getValue("Setting_ShowSeconds");
            showDate = Properties.getValue("Setting_ShowDate");
            showBattery = Properties.getValue("Setting_ShowBattery");
            numericHourMarks = Properties.getValue("Setting_NumericHourMarks");
            cutoutMode = Properties.getValue("Setting_CutoutMode");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
            Properties.setValue("Setting_ShowSeconds", showSeconds);
            Properties.setValue("Setting_ShowDate", showDate);
            Properties.setValue("Setting_ShowBattery", showBattery);
            Properties.setValue("Setting_NumericHourMarks", numericHourMarks);
            Properties.setValue("Setting_CutoutMode", cutoutMode);
        }
    }
}
