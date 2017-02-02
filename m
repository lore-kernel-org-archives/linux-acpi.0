From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 09/16] driver core: Arrange headers alphabetically
Date: Thu,  2 Feb 2017 18:22:19 +0200
Message-ID: <1486052546-19257-10-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 020ea7f..bd87807 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -13,19 +13,19 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
+#include <linux/genhd.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/kallsyms.h>
 #include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/genhd.h>
-#include <linux/kallsyms.h>
-#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
-#include <linux/netdevice.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 
 #include "base.h"
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
