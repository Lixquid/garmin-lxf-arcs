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

    enum HOURMARK {
        HOURMARK_NONE = 0,
        HOURMARK_STICK = 10,
        HOURMARK_DOT = 11,
        HOURMARK_SMALLNUMBERS = 20,
        HOURMARK_LARGENUMBERS = 21,
    }

    module Strings {
        var SettingsMenu_Title as String = "";

        var Setting_Background as String = "";
        var Setting_Foreground as String = "";
        var Setting_Layout as String = "";
        var Setting_HourMarks as String = "";
        var Setting_ShowDate as String = "";
        var Setting_ShowBattery as String = "";
        var Setting_CutoutMode as String = "";
        var Setting_SegmentedArcs as String = "";

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

        var Layout_12HrMinSec as String = "";
        var Layout_12HrMin as String = "";
        var Layout_24HrMinSec as String = "";
        var Layout_24HrMin as String = "";
        var Layout_24Hr as String = "";

        var HourMark_None as String = "";
        var HourMark_Stick as String = "";
        var HourMark_Dot as String = "";
        var HourMark_SmallNumbers as String = "";
        var HourMark_LargeNumbers as String = "";

        module Map {
            (:initialized)
            var colors as Dictionary<Number, String>;
            (:initialized)
            var layouts as Dictionary<LAYOUT, String>;
            (:initialized)
            var hourMarks as Dictionary<HOURMARK, String>;
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
            Setting_HourMarks = Application.loadResource(
                $.Rez.Strings.Setting_HourMarks
            );
            Setting_ShowDate = Application.loadResource(
                $.Rez.Strings.Setting_ShowDate
            );
            Setting_ShowBattery = Application.loadResource(
                $.Rez.Strings.Setting_ShowBattery
            );
            Setting_CutoutMode = Application.loadResource(
                $.Rez.Strings.Setting_CutoutMode
            );
            Setting_SegmentedArcs = Application.loadResource(
                $.Rez.Strings.Setting_SegmentedArcs
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

            Layout_12HrMinSec = Application.loadResource(
                $.Rez.Strings.Layout_12HrMinSec
            );
            Layout_12HrMin = Application.loadResource(
                $.Rez.Strings.Layout_12HrMin
            );
            Layout_24HrMinSec = Application.loadResource(
                $.Rez.Strings.Layout_24HrMinSec
            );
            Layout_24HrMin = Application.loadResource(
                $.Rez.Strings.Layout_24HrMin
            );
            Layout_24Hr = Application.loadResource($.Rez.Strings.Layout_24Hr);

            HourMark_None = Application.loadResource(
                $.Rez.Strings.HourMark_None
            );
            HourMark_Stick = Application.loadResource(
                $.Rez.Strings.HourMark_Stick
            );
            HourMark_Dot = Application.loadResource($.Rez.Strings.HourMark_Dot);
            HourMark_SmallNumbers = Application.loadResource(
                $.Rez.Strings.HourMark_SmallNumbers
            );
            HourMark_LargeNumbers = Application.loadResource(
                $.Rez.Strings.HourMark_LargeNumbers
            );

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
                LAYOUT_12HRMINSEC => Layout_12HrMinSec,
                LAYOUT_12HRMIN => Layout_12HrMin,
                LAYOUT_24HRMINSEC => Layout_24HrMinSec,
                LAYOUT_24HRMIN => Layout_24HrMin,
                LAYOUT_24HR => Layout_24Hr,
            };
            Map.hourMarks = {
                HOURMARK_NONE => HourMark_None,
                HOURMARK_STICK => HourMark_Stick,
                HOURMARK_DOT => HourMark_Dot,
                HOURMARK_SMALLNUMBERS => HourMark_SmallNumbers,
                HOURMARK_LARGENUMBERS => HourMark_LargeNumbers,
            };
        }
    }

    module Settings {
        var background as Number = 0;
        var foreground as Number = 0;
        var layout as LAYOUT = LAYOUT_12HRMINSEC;
        var hourMarks as HOURMARK = HOURMARK_NONE;
        var showDate as Boolean = false;
        var showBattery as Boolean = false;
        var cutoutMode as Boolean = false;
        var segmentedArcs as Boolean = false;

        function load() {
            background = Properties.getValue("Setting_Background");
            foreground = Properties.getValue("Setting_Foreground");
            layout = Properties.getValue("Setting_Layout") as LAYOUT;
            hourMarks = Properties.getValue("Setting_HourMarks") as HOURMARK;
            showDate = Properties.getValue("Setting_ShowDate");
            showBattery = Properties.getValue("Setting_ShowBattery");
            cutoutMode = Properties.getValue("Setting_CutoutMode");
            segmentedArcs = Properties.getValue("Setting_SegmentedArcs");
        }

        function save() {
            Properties.setValue("Setting_Background", background);
            Properties.setValue("Setting_Foreground", foreground);
            Properties.setValue("Setting_Layout", layout);
            Properties.setValue("Setting_HourMarks", hourMarks);
            Properties.setValue("Setting_ShowDate", showDate);
            Properties.setValue("Setting_ShowBattery", showBattery);
            Properties.setValue("Setting_CutoutMode", cutoutMode);
            Properties.setValue("Setting_SegmentedArcs", segmentedArcs);
        }
    }
}
