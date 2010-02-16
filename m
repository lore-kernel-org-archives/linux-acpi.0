From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/10] ACPI: acpi_bus_{scan,bus,add}: return -ENODEV if no
 device was found
Date: Tue, 16 Feb 2010 04:46:04 -0500
Message-ID: <7779688fc3d1ceddad84846a7b0affbe8e78ec6e.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:47906 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab0BPJq1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX00LV9HT3KIR4@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:18 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Callers (acpi_memhotplug.c, dock.c and others) check for the return
value of acpi_bus_add() and assume a valid device was returned in
case zero was returned.

Thus return -ENODEV if no device was found in acpi_bus_scan and
propagate this through acpi_bus_add and acpi_bus_start.

Also remove a confusing comment in acpiphp_glue.c, acpi_bus_scan
will and cannot invoke if acpi_bus_add returns no valid device.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c                |   24 +++++++++++++++++++-----
 drivers/pci/hotplug/acpiphp_glue.c |    6 ------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8044583..3e00967 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1336,9 +1336,25 @@ static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops,
 
 	if (child)
 		*child = device;
-	return 0;
+
+	if (device)
+		return 0;
+	else
+		return -ENODEV;
 }
 
+/*
+ * acpi_bus_add and acpi_bus_start
+ *
+ * scan a given ACPI tree and (probably recently hot-plugged)
+ * create and add or starts found devices.
+ *
+ * If no devices were found -ENODEV is returned which does not
+ * mean that this is a real error, there just have been no suitable
+ * ACPI objects in the table trunk from which the kernel could create
+ * a device and add/start an appropriate driver.
+ */
+
 int
 acpi_bus_add(struct acpi_device **child,
 	     struct acpi_device *parent, acpi_handle handle, int type)
@@ -1348,8 +1364,7 @@ acpi_bus_add(struct acpi_device **child,
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 
-	acpi_bus_scan(handle, &ops, child);
-	return 0;
+	return acpi_bus_scan(handle, &ops, child);
 }
 EXPORT_SYMBOL(acpi_bus_add);
 
@@ -1363,8 +1378,7 @@ int acpi_bus_start(struct acpi_device *device)
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_start = 1;
 
-	acpi_bus_scan(device->handle, &ops, NULL);
-	return 0;
+	return acpi_bus_scan(device->handle, &ops, NULL);
 }
 EXPORT_SYMBOL(acpi_bus_start);
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 8e952fd..cb2fd01 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -720,12 +720,6 @@ static int acpiphp_bus_add(struct acpiphp_func *func)
 			-ret_val);
 		goto acpiphp_bus_add_out;
 	}
-	/*
-	 * try to start anyway.  We could have failed to add
-	 * simply because this bus had previously been added
-	 * on another add.  Don't bother with the return value
-	 * we just keep going.
-	 */
 	ret_val = acpi_bus_start(device);
 
 acpiphp_bus_add_out:
-- 
1.6.0.6

