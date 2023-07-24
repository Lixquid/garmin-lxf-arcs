import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;

module Data {
    enum LAYOUT {
        LAYOUT_12HRMINSEC = 0,
        LAYOUT_12HRMIN = 1,
        LAYOUT_24HRMINSEC = 2,
        LAYOUT_24HRMIN = 3,
        LAYOUT_24HR = 4,
    }

    module Strings {
        var SettingsMenu_Title as String = "";

        var Setting_Background as String = "";
        var Setting_Foreground as String = "";
        var Setting_Layout as String = "";
        var Setting_ShowDate as String = "";
        var Setting_ShowBattery as String = "";
        var Setting_NumericHourMarks as String = "";
        var Setting_CutoutMode as String = "";
        var Setting_SegmentedArcs as String = "";

        var Setting_Layout_12HrMinSec as String = "";
        var Setting_Layout_12HrMin as String = "";
        var Setting_Layout_24HrMinSec as String = "";
        var Setting_Layout_24HrMin as String = "";
        var Setting_Layout_24Hr as String = "";

        var Color_White as String = "";
        var Color_Gray as String = "";
        var Color_DarkGray as String = "";
        var Color_Black as String = "";
        var Color_Red as String = "";
        var Color_Orange as String = "";
        var Color_Yellow as String = "";
        var Color_Green as String = "";
        var Color_Blue as String = "";
        var Color_Purple as String = "";
        var Color_Pink as String = "";

        module Map {
            (:initialized)
            var colors as Dictionary<Number, String>;
            (:initialized)
            var layouts as Dictionary<LAYOUT, String>;
        }

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
            Setting_Layout = Application.loadResource(
                $.Rez.Strings.Setting_Layout
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
            Setting_SegmentedArcs = Application.loadResource(
                $.Rez.Strings.Setting_SegmentedArcs
            );

            Setting_Layout_12HrMinSec = Application.loadResource(
                $.Rez.Strings.Setting_Layout_12HrMinSec
            );
            Setting_Layout_12HrMin = Application.loadResource(
                $.Rez.Strings.Setting_Layout_12HrMin
            );
            Setting_Layout_24HrMinSec = Application.loadResource(
                $.Rez.Strings.Setting_Layout_24HrMinSec
            );
            Setting_Layout_24HrMin = Application.loadResource(
                $.Rez.Strings.Setting_Layout_24HrMin
            );
            Setting_Layout_24Hr = Application.loadResource(
                $.Rez.Strings.Setting_Layout_24Hr
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

            Map.colors = {
                0xffffff => Color_White,
                0xaaaaaa => Color_Gray,
                0x555555 => Color_DarkGray,
                0x000000 => Color_Black,
                0xaa0000 => Color_Red,
                0xffaa00 => Color_Orange,
                0xffff00 => Color_Yellow,
                0x55aa00 => Color_Green,
                0x0055ff => Color_Blue,
                0xaa00ff => Color_Purple,
                0xff55ff => Color_Pink,
            };
            Map.layouts = {
                LAYOUT_12HRMINSEC => Setting_Layout_12HrMinSec,
                LAYOUT_12HRMIN => Setting_Layout_12HrMin,
                LAYOUT_24HRMINSEC => Setting_Layout_24HrMinSec,
                LAYOUT_24HRMIN => Setting_Layout_24HrMin,
                LAYOUT_24HR => Setting_Layout_24Hr,
            };
        }
    }

    module Settings {
        var background = 0xff00ff;
        var foreground = 0xff00ff;
        var layout = LAYOUT_12HRMINSEC;
        var showDate = false;
        var showBattery = false;
        var numericHourMarks = false;
        var cutoutMode = false;
        var segmentedArcs = false;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
            layout = Properties.getValue("Setting_Layout");
            showDate = Properties.getValue("Setting_ShowDate");
            showBattery = Properties.getValue("Setting_ShowBattery");
            numericHourMarks = Properties.getValue("Setting_NumericHourMarks");
            cutoutMode = Properties.getValue("Setting_CutoutMode");
            segmentedArcs = Properties.getValue("Setting_SegmentedArcs");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
            Properties.setValue("Setting_Layout", layout);
            Properties.setValue("Setting_ShowDate", showDate);
            Properties.setValue("Setting_ShowBattery", showBattery);
            Properties.setValue("Setting_NumericHourMarks", numericHourMarks);
            Properties.setValue("Setting_CutoutMode", cutoutMode);
            Properties.setValue("Setting_SegmentedArcs", segmentedArcs);
        }
    }
}
