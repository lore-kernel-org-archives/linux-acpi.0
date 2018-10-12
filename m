From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [RFC PATCH 1/5] drivers core: Prepare support for multiple platform notifications
Date: Fri, 12 Oct 2018 14:39:30 +0300
Message-ID: <20181012113934.29942-2-heikki.krogerus@linux.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
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
 drivers/base/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..e42d6e7dd368 100644
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
@@ -2083,8 +2096,8 @@ void device_del(struct device *dev)
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
-	if (platform_notify_remove)
-		platform_notify_remove(dev);
+	device_platform_notify(dev, KOBJ_REMOVE);
+
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
-- 
2.19.1
