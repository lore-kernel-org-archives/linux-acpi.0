From: Len Brown <lenb@kernel.org>
Subject: [PATCH 001/171] ACPI: crosslink ACPI and "real" device nodes
Date: Tue, 29 Apr 2008 04:43:52 -0400
Message-ID: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:5527 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757344AbYD2Ioi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:38 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: David Brownell <david-b@pacbell.net>

Add cross-links between ACPI device and "real" devices in sysfs,
exposing otherwise-hidden interrelationships between the various
device nodes for ACPI stuff.  As a representative example, one
hardware device is exposed as two logical devices (PNP and ACPI):

  .../pnp0/00:06/
  .../LNXSYSTM:00/device:00/PNP0A03:00/device:15/PNP0B00:00/

The PNP device gets a "firmware_node" link pointing to the ACPI device,
and is what a Linux device driver binds to.  The ACPI device has instead
a "physical_node" link pointing back to the PNP device.  Other firmware
frameworks, like OpenFirmware, could do the same thing to couple their
firmware tables to the rest of the system.

(Based on a patch from Zhang Rui.  This version is modified to not
depend on the patch makig ACPI initialize driver model wakeup flags.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index eda0978..06f8634 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -142,6 +142,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
 
 static int acpi_bind_one(struct device *dev, acpi_handle handle)
 {
+	struct acpi_device *acpi_dev;
 	acpi_status status;
 
 	if (dev->archdata.acpi_handle) {
@@ -157,6 +158,16 @@ static int acpi_bind_one(struct device *dev, acpi_handle handle)
 	}
 	dev->archdata.acpi_handle = handle;
 
+	status = acpi_bus_get_device(handle, &acpi_dev);
+	if (!ACPI_FAILURE(status)) {
+		int ret;
+
+		ret = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
+				"firmware_node");
+		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
+				"physical_node");
+	}
+
 	return 0;
 }
 
@@ -165,8 +176,17 @@ static int acpi_unbind_one(struct device *dev)
 	if (!dev->archdata.acpi_handle)
 		return 0;
 	if (dev == acpi_get_physical_device(dev->archdata.acpi_handle)) {
+		struct acpi_device *acpi_dev;
+
 		/* acpi_get_physical_device increase refcnt by one */
 		put_device(dev);
+
+		if (!acpi_bus_get_device(dev->archdata.acpi_handle,
+					&acpi_dev)) {
+			sysfs_remove_link(&dev->kobj, "firmware_node");
+			sysfs_remove_link(&acpi_dev->dev.kobj, "physical_node");
+		}
+
 		acpi_detach_data(dev->archdata.acpi_handle,
 				 acpi_glue_data_handler);
 		dev->archdata.acpi_handle = NULL;
-- 
1.5.5.1.99.gf0ec4

