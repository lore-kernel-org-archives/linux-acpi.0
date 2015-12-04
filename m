From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
Date: Fri,  4 Dec 2015 23:49:17 +0200
Message-ID: <1449265765-9393-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The users of BUS_NOTIFY_BIND_DRIVER have no chance to do any cleanup in case of
a probe failure. In the result there might be problems, such as some resources
that had been allocated will continue to be allocated and therefore lead to a
resource leak.

Introduce a new notification to inform the subscriber that ->probe() failed. Do
the same in case of failed device_bind_driver() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c      | 10 ++++++++--
 include/linux/device.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8d4eb4d..7399be7 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -299,6 +299,9 @@ int device_bind_driver(struct device *dev)
 	ret = driver_sysfs_add(dev);
 	if (!ret)
 		driver_bound(dev);
+	else if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
@@ -332,7 +335,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
-		goto probe_failed;
+		goto pinctrl_bind_failed;
 
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
@@ -376,6 +379,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+pinctrl_bind_failed:
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
@@ -749,7 +756,6 @@ static void __device_release_driver(struct device *dev)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
-
 	}
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b8f411b..f627ba2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -191,6 +191,7 @@ extern int bus_unregister_notifier(struct bus_type *bus,
 						      unbound */
 #define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
 						      from the device */
+#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
 extern struct klist *bus_get_device_klist(struct bus_type *bus);
-- 
2.6.2
