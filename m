From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/8] introduce device async shutdown
Date: Wed, 15 Jul 2009 15:38:38 +0800
Message-ID: <1247643518.26272.79.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15075 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbZGOHhy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 03:37:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


introduce device async shutdown.

If boot option "dev_async_action" is added,
devices can be shutdown asynchronously.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/core.c       |    7 +++++--
 include/linux/async_dev.h |    4 +++-
 drivers/base/async_dev.c        |    4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/base/core.c
===================================================================
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -1715,14 +1715,17 @@ void device_shutdown(void)
 				kobj.entry) {
 		if (dev->bus && dev->bus->shutdown) {
 			dev_dbg(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
+			dev_async_schedule(dev, dev->bus->shutdown, NULL,
+							DEV_ASYNC_SHUTDOWN);
 		} else if (dev->driver && dev->driver->shutdown) {
 			dev_dbg(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
+			dev_async_schedule(dev, dev->driver->shutdown, NULL,
+							DEV_ASYNC_SHUTDOWN);
 		}
 	}
 	kobject_put(sysfs_dev_char_kobj);
 	kobject_put(sysfs_dev_block_kobj);
 	kobject_put(dev_kobj);
+	dev_async_synchronization();
 	async_synchronize_full();
 }
Index: linux-2.6/include/linux/async_dev.h
===================================================================
--- linux-2.6.orig/include/linux/async_dev.h
+++ linux-2.6/include/linux/async_dev.h
@@ -30,8 +30,10 @@ struct dev_async_struct {
 
 #define DEV_ASYNC_SUSPEND	1
 #define DEV_ASYNC_RESUME	2
+#define DEV_ASYNC_SHUTDOWN	4
 #define DEV_ASYNC_ACTIONS_ALL	(DEV_ASYNC_SUSPEND |	\
-				DEV_ASYNC_RESUME)
+				DEV_ASYNC_RESUME |	\
+				DEV_ASYNC_SHUTDOWN)
 
 extern int dev_async_schedule(struct device *, void *,
 			void *, int);
Index: linux-2.6/drivers/base/async_dev.c
===================================================================
--- linux-2.6.orig/drivers/base/async_dev.c
+++ linux-2.6/drivers/base/async_dev.c
@@ -18,6 +18,7 @@ static LIST_HEAD(dev_async_list);
 static int dev_async_enabled;
 
 typedef int (*dev_async_suspend)(struct device *, pm_message_t);
+typedef void (*dev_async_shutdown) (struct device *);
 
 struct dev_async_context {
 	struct device *dev;
@@ -39,6 +40,9 @@ static int dev_action(struct device *dev
 	case DEV_ASYNC_RESUME:
 		error = ((dev_async_suspend)func)(dev, *((pm_message_t *)data));
 		break;
+	case DEV_ASYNC_SHUTDOWN:
+		((dev_async_shutdown)func)(dev);
+		break;
 	default:
 		return -EINVAL;
 	}


