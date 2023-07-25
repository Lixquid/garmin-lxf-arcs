import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class WatchFace extends WatchUi.WatchFace {
    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc as Dc) {
        WatchFace.onUpdate(dc);

        var w = dc.getWidth();
        var h = dc.getHeight();
        var m = min(w, h);
        var l = Data.Settings.layout;
        var now = Time.now();
        var timeInfo = Time.Gregorian.info(now, Time.FORMAT_SHORT);
        var dayProgress = now.subtract(Time.today()).value() / 86400d;
        var hr24 =
            l == Data.LAYOUT_24HR ||
            l == Data.LAYOUT_24HRMIN ||
            l == Data.LAYOUT_24HRMINSEC;
        dc.setColor(Data.Settings.foreground, Data.Settings.background);
        if (dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }
        dc.clear();

        var arcs =
            l == Data.LAYOUT_24HRMINSEC || l == Data.LAYOUT_12HRMINSEC
                ? 3
                : l == Data.LAYOUT_24HRMIN || l == Data.LAYOUT_12HRMIN
                ? 2
                : 1;
        var hr = 0.0;
        var hw = 0.08;
        var mr = 0.0;
        var mw = 0.04;
        var sr = 0.0;
        var sw = 0.02;

        if (Data.Settings.dynamicArcWidths) {
            // Space capacity
            var c = arcs == 3 ? 0.18 : arcs == 2 ? 0.14 : 0.08;
            // Actual computed space
            var s = Data.Settings.hourMarks == Data.HOURMARK_NONE ? 0.32 : 0.18;

            hr = (0.04 / c) * s + 0.16;
            hw = (0.08 / c) * s;
            mr = (0.12 / c) * s + 0.16;
            mw = (0.04 / c) * s;
            sr = (0.17 / c) * s + 0.16;
            sw = (0.02 / c) * s;
        } else {
            var p = Data.Settings.hourMarks == Data.HOURMARK_NONE ? 0.48 : 0.34;

            // Draw seconds arc
            if (arcs == 3) {
                sr = p - 0.01;
                p -= 0.04;
            }

            // Draw minutes arc
            if (arcs > 1) {
                mr = p - 0.02;
                p -= 0.06;
            }

            // Draw hour arc
            hr = p - 0.04;
        }

        // Draw seconds arc
        if (arcs == 3) {
            var secondProgress = timeInfo.sec / 60d;
            dc.setPenWidth(intMin1(m * sw));
            arcOrCutout(dc, w / 2, h / 2, m * sr, secondProgress, 2);
        }

        // Draw minutes arc
        if (arcs > 1) {
            var minuteProgress = rem(dayProgress * 24d, 1d);
            dc.setPenWidth(intMin1(m * mw));
            arcOrCutout(dc, w / 2, h / 2, m * mr, minuteProgress, 3);
        }

        // Draw hour arc
        dc.setPenWidth(intMin1(m * hw));
        if (hr24) {
            var hourProgress = rem(dayProgress, 1d);
            arcOrCutout(dc, w / 2, h / 2, m * hr, hourProgress, 5);
        } else {
            var hourProgress = rem(dayProgress * 2d, 1d);
            arcOrCutout(dc, w / 2, h / 2, m * hr, hourProgress, 5);
        }

        var hr24_ang = hr24 ? 15 : 30;

        // Arc segments
        if (Data.Settings.segmentedArcs) {
            dc.setColor(Data.Settings.background, Graphics.COLOR_TRANSPARENT);
            for (var i = 1; i <= (hr24 ? 24 : 12); i++) {
                dc.setPenWidth(i % 3 == 0 ? 3 : 1);
                dc.drawLine(
                    w / 2,
                    h / 2,
                    w / 2 + m * 0.5 * Math.sin((i * hr24_ang * Math.PI) / 180),
                    h / 2 - m * 0.5 * Math.cos((i * hr24_ang * Math.PI) / 180)
                );
            }
        }

        // Indices
        dc.setColor(Data.Settings.foreground, Graphics.COLOR_TRANSPARENT);
        switch (Data.Settings.hourMarks) {
            case Data.HOURMARK_STICK:
                for (var i = 1; i <= (hr24 ? 24 : 12); i++) {
                    dc.setPenWidth(i % 3 == 0 ? 4 : 2);
                    dc.drawLine(
                        w / 2 +
                            m * 0.4 * Math.sin((i * hr24_ang * Math.PI) / 180),
                        h / 2 -
                            m * 0.4 * Math.cos((i * hr24_ang * Math.PI) / 180),
                        w / 2 +
                            m * 0.45 * Math.sin((i * hr24_ang * Math.PI) / 180),
                        h / 2 -
                            m * 0.45 * Math.cos((i * hr24_ang * Math.PI) / 180)
                    );
                }
                break;
            case Data.HOURMARK_DOT:
                for (var i = 1; i <= (hr24 ? 24 : 12); i++) {
                    dc.fillCircle(
                        w / 2 +
                            m * 0.43 * Math.sin((i * hr24_ang * Math.PI) / 180),
                        h / 2 -
                            m * 0.43 * Math.cos((i * hr24_ang * Math.PI) / 180),
                        2
                    );
                }
                break;
            case Data.HOURMARK_SMALLNUMBERS:
                for (var i = 1; i <= (hr24 ? 24 : 12); i++) {
                    dc.drawText(
                        w / 2 +
                            m * 0.43 * Math.sin((i * hr24_ang * Math.PI) / 180),
                        h / 2 -
                            m * 0.43 * Math.cos((i * hr24_ang * Math.PI) / 180),
                        Graphics.FONT_TINY,
                        i.toString(),
                        Graphics.TEXT_JUSTIFY_CENTER |
                            Graphics.TEXT_JUSTIFY_VCENTER
                    );
                }
                break;
            case Data.HOURMARK_LARGENUMBERS:
                for (var i = 1; i <= (hr24 ? 24 : 12); i++) {
                    dc.drawText(
                        w / 2 +
                            m * 0.43 * Math.sin((i * hr24_ang * Math.PI) / 180),
                        h / 2 -
                            m * 0.43 * Math.cos((i * hr24_ang * Math.PI) / 180),
                        Graphics.FONT_MEDIUM,
                        i.toString(),
                        Graphics.TEXT_JUSTIFY_CENTER |
                            Graphics.TEXT_JUSTIFY_VCENTER
                    );
                }
                break;
        }

        drawCenter(dc, w, h, m, timeInfo);
    }

    (:watchArmsNo)
    private function drawCenter(
        dc as Dc,
        w as Number,
        h as Number,
        m as Number,
        timeInfo as Time.Gregorian.Info
    ) {
        // Draw date
        if (Data.Settings.showDate) {
            dc.drawText(
                w / 2,
                h / 2,
                Graphics.FONT_SMALL,
                timeInfo.day.toString(),
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );
        }

        // Draw battery level
        if (Data.Settings.showBattery) {
            var sys = System.getSystemStats();
            dc.setPenWidth(1);
            dc.drawArc(w / 2, h / 2, m * 0.1, Graphics.ARC_CLOCKWISE, 0, 180);
            dc.setPenWidth(intMin1(m * 0.02));
            dc.drawArc(
                w / 2,
                h / 2,
                m * 0.1,
                Graphics.ARC_CLOCKWISE,
                0,
                sys.battery * -1.8
            );
        }
    }

    (:watchArmsYes)
    private function drawCenter(
        dc as Dc,
        w as Number,
        h as Number,
        m as Number,
        timeInfo as Time.Gregorian.Info
    ) {
        var cx = (w * 5) / 6;

        // Draw background cutout
        dc.setColor(Data.Settings.background, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(cx, h / 2, m * 0.14);
        dc.setColor(Data.Settings.foreground, Data.Settings.background);

        // Draw date
        if (Data.Settings.showDate) {
            dc.drawText(
                cx,
                h / 2,
                Graphics.FONT_SMALL,
                timeInfo.day.toString(),
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );
        }

        // Draw battery level
        if (Data.Settings.showBattery) {
            var sys = System.getSystemStats();
            dc.setPenWidth(1);
            dc.drawArc(cx, h / 2, m * 0.1, Graphics.ARC_CLOCKWISE, 0, 180);
            dc.setPenWidth(intMin1(m * 0.02));
            dc.drawArc(
                cx,
                h / 2,
                m * 0.1,
                Graphics.ARC_CLOCKWISE,
                0,
                sys.battery * -1.8
            );
        }
    }

    private function rem(a as Double, b as Double) as Double {
        return a - Math.floor(a / b) * b;
    }

    private function intMin1(a as Float) as Number {
        var v = a.toNumber();
        return v < 1 ? 1 : v;
    }

    private function min(a as Number, b as Number) as Number {
        return a < b ? a : b;
    }

    private function arcOrCutout(
        dc as Dc,
        x as Number,
        y as Number,
        r as Float,
        a as Double,
        gap as Number
    ) {
        if (Data.Settings.cutoutMode) {
            dc.drawArc(
                x,
                y,
                r,
                Graphics.ARC_CLOCKWISE,
                90 - gap - a * 360,
                90 + gap - a * 360
            );
        } else {
            dc.drawArc(x, y, r, Graphics.ARC_CLOCKWISE, 90, 90 - a * 360);
        }
    }
}
