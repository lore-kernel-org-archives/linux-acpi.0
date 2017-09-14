From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 1/5] clk: Increment assigned-clocks index for empty phandles
Date: Thu, 14 Sep 2017 15:29:10 +0300
Message-ID: <20170914122914.14122-2-sakari.ailus@linux.intel.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170914122914.14122-1-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If the assigned-clocks property contains an empty phandle, skip the index
rather than trying it over on the next iteration (with an related clock
rate related to another clock).

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/clk/clk-conf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 49819b546134..7b7113d86875 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -91,10 +91,12 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 					"#clock-cells",	index, &clkspec);
 			if (rc < 0) {
 				/* skip empty (null) phandles */
-				if (rc == -ENOENT)
+				if (rc == -ENOENT) {
+					index++;
 					continue;
-				else
+				} else {
 					return rc;
+				}
 			}
 			if (clkspec.np == node && !clk_supplier)
 				return 0;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
