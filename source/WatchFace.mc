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
        dc.setColor(Data.Settings.foreground, Data.Settings.background);
        if (dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }
        dc.clear();

        var p = 0.34;

        if (Data.Settings.hourMarks == Data.HOURMARK_NONE) {
            // If no hour marks, use more space for arcs
            p = 0.48;
        }

        // Draw seconds arc
        if (l == Data.LAYOUT_24HRMINSEC || l == Data.LAYOUT_12HRMINSEC) {
            var secondProgress = timeInfo.sec / 60d;
            dc.setPenWidth(intMin1(m * 0.02));
            arcOrCutout(dc, w / 2, h / 2, m * (p - 0.01), secondProgress, 2);
            p -= 0.04;
        }

        // Draw minutes arc
        if (
            l == Data.LAYOUT_24HRMIN ||
            l == Data.LAYOUT_24HRMINSEC ||
            l == Data.LAYOUT_12HRMIN ||
            l == Data.LAYOUT_12HRMINSEC
        ) {
            var minuteProgress = rem(dayProgress * 24d, 1d);
            dc.setPenWidth(intMin1(m * 0.04));
            arcOrCutout(dc, w / 2, h / 2, m * (p - 0.02), minuteProgress, 3);
            p -= 0.06;
        }

        // Draw hour arc
        if (l == Data.LAYOUT_12HRMIN || l == Data.LAYOUT_12HRMINSEC) {
            var hourProgress = rem(dayProgress * 2d, 1d);
            dc.setPenWidth(intMin1(m * 0.08));
            arcOrCutout(dc, w / 2, h / 2, m * (p - 0.04), hourProgress, 5);
            p -= 0.1;
        } else {
            var hourProgress = rem(dayProgress, 1d);
            dc.setPenWidth(intMin1(m * 0.08));
            arcOrCutout(dc, w / 2, h / 2, m * (p - 0.04), hourProgress, 5);
            p -= 0.1;
        }

        var hr24 =
            l == Data.LAYOUT_24HR ||
            l == Data.LAYOUT_24HRMIN ||
            l == Data.LAYOUT_24HRMINSEC;
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
