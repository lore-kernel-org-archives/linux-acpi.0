From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2 2/6] drivers core: Prepare support for multiple platform notifications
Date: Fri,  9 Nov 2018 17:21:34 +0300
Message-ID: <20181109142138.54770-3-heikki.krogerus@linux.intel.com>
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Since it should be possible to support several hardware
description models at the same time (at least in theory),
for example ACPI and devicetree on a running system, the
platform notifications need to be handled differently.

For now a single "platform_notify" callback function was
used to notify the underlying base system which is in charge
of the hardware description when a new device entry was
added to the system, but that callback is available to only
a single base system at the time. This will add a function
device_platform_notify() and replace all direct
platform_notify() calls with it.

device_platform_notify() will first simply call the
platform_notify() callback, so this commit has no functional
affect, however, the idea is that individual base systems
will put their direct notification calls there instead of
using the platform_notify function pointer.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..3972ef3f080b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -728,6 +728,16 @@ static inline int device_is_not_partition(struct device *dev)
 }
 #endif
 
+static int
+device_platform_notify(struct device *dev, enum kobject_action action)
+{
+	if (platform_notify && action == KOBJ_ADD)
+		platform_notify(dev);
+	else if (platform_notify_remove && action == KOBJ_REMOVE)
+		platform_notify_remove(dev);
+	return 0;
+}
+
 /**
  * dev_driver_string - Return a device's driver name, if at all possible
  * @dev: struct device to get the name of
@@ -1883,8 +1893,9 @@ int device_add(struct device *dev)
 	}
 
 	/* notify platform of device entry */
-	if (platform_notify)
-		platform_notify(dev);
+	error = device_platform_notify(dev, KOBJ_ADD);
+	if (error)
+		goto platform_error;
 
 	error = device_create_file(dev, &dev_attr_uevent);
 	if (error)
@@ -1960,6 +1971,8 @@ int device_add(struct device *dev)
  SymlinkError:
 	device_remove_file(dev, &dev_attr_uevent);
  attrError:
+	device_platform_notify(dev, KOBJ_REMOVE);
+platform_error:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
@@ -2077,14 +2090,10 @@ void device_del(struct device *dev)
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
+	device_platform_notify(dev, KOBJ_REMOVE);
 	device_remove_properties(dev);
 	device_links_purge(dev);
 
-	/* Notify the platform of the removal, in case they
-	 * need to do anything...
-	 */
-	if (platform_notify_remove)
-		platform_notify_remove(dev);
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
-- 
2.19.1
