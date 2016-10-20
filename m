From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] watchdog: wdat_wdt: Ping the watchdog on resume
Date: Thu, 20 Oct 2016 18:03:36 +0300
Message-ID: <20161020150336.97791-1-mika.westerberg@linux.intel.com>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It turns out we need to ping the watchdog hardware on resume when we
re-program it. Otherwise this results inadvertent reset to trigger right
after the resume is completed.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/watchdog/wdat_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index e473e3b23720..6d1fbda0f461 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -499,6 +499,10 @@ static int wdat_wdt_resume_noirq(struct device *dev)
 		ret = wdat_wdt_enable_reboot(wdat);
 		if (ret)
 			return ret;
+
+		ret = wdat_wdt_ping(&wdat->wdd);
+		if (ret)
+			return ret;
 	}
 
 	return wdat_wdt_start(&wdat->wdd);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
