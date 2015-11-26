From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/7] device core: add BUS_NOTIFY_BIND_DRIVER_ERROR notification
Date: Thu, 26 Nov 2015 17:19:07 +0200
Message-ID: <1448551153-84719-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

In case ->probe() fails the notifier does not inform a subscriber about this.
In the result it might happend that some resources that had been allocated will
stay allocated and therefore lead to resource leak.

Introduce a new notification to inform the subscriber that ->probe() failed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c      | 8 ++++++--
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a641cf3..ac071a5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -290,7 +290,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
-		goto probe_failed;
+		goto pinctrl_bind_failed;
 
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
@@ -334,6 +334,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
+	if (dev->bus)
+		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+					     BUS_NOTIFY_BIND_DRIVER_ERROR,
+					     dev);
+pinctrl_bind_failed:
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
@@ -701,7 +706,6 @@ static void __device_release_driver(struct device *dev)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBOUND_DRIVER,
 						     dev);
-
 	}
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b8f411b..87cf423 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -191,6 +191,7 @@ extern int bus_unregister_notifier(struct bus_type *bus,
 						      unbound */
 #define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
 						      from the device */
+#define BUS_NOTIFY_BIND_DRIVER_ERROR	0x80000004 /* driver fails to be bound */
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
 extern struct klist *bus_get_device_klist(struct bus_type *bus);
-- 
2.6.2
