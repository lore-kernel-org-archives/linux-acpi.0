From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] device property: Make it possible to use secondary firmware nodes
Date: Fri, 03 Apr 2015 16:03:27 +0200
Message-ID: <4319396.BzsUBIbBMA@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <1594911.7FXIhSfjIv@vostro.rjw.lan> <1845472.ky0kR6YsnQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52252 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751702AbbDCNlS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2015 09:41:18 -0400
In-Reply-To: <1845472.ky0kR6YsnQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a "secondary" pointer to struct fwnode_handle so as to make it
possible for a device to have two firmware nodes associated with
it at the same time, for example, an ACPI node and a node with
a set of properties provided by platform initialization code.

In the future that will allow device property lookup to fall back
from the primary firmware node to the secondary one if the given
property is not present there to make it easier to provide defaults
for device properties used by device drivers.

Introduce two helper routines, set_primary_fwnode() and
set_secondary_fwnode() allowing callers to add a primary/secondary
firmware node to the given device in such a way that

 (1) If there's only one firmware node for that device, it will be
     pointed to by the device's firmware node pointer.
 (2) If both the primary and secondary firmware nodes are present,
     the primary one will be pointed to by the device's firmware
     node pointer, while the secondary one will be pointed to by the
     primary node's secondary pointer.
 (3) If one of these nodes is removed (by calling one of the new
     nelpers with NULL as the second argument), the other one will
     be preserved.

Make ACPI use set_primary_fwnode() for attaching its firmware nodes
to devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Greg, any objections here?

---
 drivers/base/core.c    |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h   |    4 +--
 include/linux/device.h |    3 ++
 include/linux/fwnode.h |    1 
 4 files changed, 57 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/fwnode.h
===================================================================
--- linux-pm.orig/include/linux/fwnode.h
+++ linux-pm/include/linux/fwnode.h
@@ -20,6 +20,7 @@ enum fwnode_type {
 
 struct fwnode_handle {
 	enum fwnode_type type;
+	struct fwnode_handle *secondary;
 };
 
 #endif
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -940,6 +940,9 @@ extern void unlock_device_hotplug(void);
 extern int lock_device_hotplug_sysfs(void);
 extern int device_offline(struct device *dev);
 extern int device_online(struct device *dev);
+extern void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+extern void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
+
 /*
  * Root device objects for grouping under /sys/devices
  */
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -54,8 +54,8 @@ static inline acpi_handle acpi_device_ha
 }
 
 #define ACPI_COMPANION(dev)		acpi_node((dev)->fwnode)
-#define ACPI_COMPANION_SET(dev, adev)	(dev)->fwnode = (adev) ? \
-	acpi_fwnode_handle(adev) : NULL
+#define ACPI_COMPANION_SET(dev, adev)	set_primary_fwnode(dev, (adev) ? \
+	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
 static inline bool has_acpi_companion(struct device *dev)
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/fwnode.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -2132,4 +2133,54 @@ define_dev_printk_level(dev_warn, KERN_W
 define_dev_printk_level(dev_notice, KERN_NOTICE);
 define_dev_printk_level(_dev_info, KERN_INFO);
 
+static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
+{
+	return fwnode && !IS_ERR(fwnode->secondary);
+}
+
+/**
+ * set_primary_fwnode - Change the primary firmware node of a given device.
+ * @dev: Device to handle.
+ * @fwnode: New primary firmware node of the device.
+ *
+ * Set the device's firmware node pointer to @fwnode, but if a secondary
+ * firmware node of the device is present, preserve it.
+ */
+void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
+{
+	if (fwnode) {
+		struct fwnode_handle *fn = dev->fwnode;
+
+		if (fwnode_is_primary(fn))
+			fn = fn->secondary;
+
+		fwnode->secondary = fn;
+		dev->fwnode = fwnode;
+	} else {
+		dev->fwnode = fwnode_is_primary(dev->fwnode) ?
+			dev->fwnode->secondary : NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(set_primary_fwnode);
+
+/**
+ * set_secondary_fwnode - Change the secondary firmware node of a given device.
+ * @dev: Device to handle.
+ * @fwnode: New secondary firmware node of the device.
+ *
+ * If a primary firmware node of the device is present, set its secondary
+ * pointer to @fwnode.  Otherwise, set the device's firmware node pointer to
+ * @fwnode.
+ */
+void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
+{
+	if (fwnode)
+		fwnode->secondary = ERR_PTR(-ENODEV);
+
+	if (fwnode_is_primary(dev->fwnode))
+		dev->fwnode->secondary = fwnode;
+	else
+		dev->fwnode = fwnode;
+}
+
 #endif

