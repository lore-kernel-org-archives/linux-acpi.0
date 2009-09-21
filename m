From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 10/17] ACPI: add acpi_bus_get_parent() and remove "parent"
	arguments
Date: Mon, 21 Sep 2009 13:29:35 -0600
Message-ID: <20090921192935.21322.94526.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:17539 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbZIUTba (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:31:30 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch adds acpi_bus_get_parent(), which ascends the namespace until
it finds a parent with an acpi_device.

Then we use acpi_bus_get_parent() in acpi_add_single_object(), so callers
don't have to figure out or keep track of the parent acpi_device.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   50 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f2e2834..f205b36 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -662,6 +662,33 @@ EXPORT_SYMBOL(acpi_bus_unregister_driver);
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
+static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
+{
+	acpi_status status;
+	int ret;
+	struct acpi_device *device;
+
+	/*
+	 * Fixed hardware devices do not appear in the namespace and do not
+	 * have handles, but we fabricate acpi_devices for them, so we have
+	 * to deal with them specially.
+	 */
+	if (handle == NULL)
+		return acpi_root;
+
+	do {
+		status = acpi_get_parent(handle, &handle);
+		if (status == AE_NULL_ENTRY)
+			return NULL;
+		if (ACPI_FAILURE(status))
+			return acpi_root;
+
+		ret = acpi_bus_get_device(handle, &device);
+		if (ret == 0)
+			return device;
+	} while (1);
+}
+
 acpi_status
 acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
 {
@@ -1217,10 +1244,9 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 	return 0;
 }
 
-static int
-acpi_add_single_object(struct acpi_device **child,
-		       struct acpi_device *parent, acpi_handle handle, int type,
-			struct acpi_bus_ops *ops)
+static int acpi_add_single_object(struct acpi_device **child,
+				  acpi_handle handle, int type,
+				  struct acpi_bus_ops *ops)
 {
 	int result;
 	struct acpi_device *device;
@@ -1234,7 +1260,7 @@ acpi_add_single_object(struct acpi_device **child,
 
 	device->device_type = type;
 	device->handle = handle;
-	device->parent = parent;
+	device->parent = acpi_bus_get_parent(handle);
 	device->bus_ops = *ops; /* workround for not call .start */
 
 	acpi_device_get_busid(device);
@@ -1434,8 +1460,8 @@ static int acpi_bus_scan(struct acpi_device *start, struct acpi_bus_ops *ops)
 		}
 
 		if (ops->acpi_op_add)
-			status = acpi_add_single_object(&child, parent,
-				chandle, type, ops);
+			status = acpi_add_single_object(&child, chandle, type,
+							ops);
 		else
 			status = acpi_bus_get_device(chandle, &child);
 
@@ -1488,7 +1514,7 @@ acpi_bus_add(struct acpi_device **child,
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 
-	result = acpi_add_single_object(child, parent, handle, type, &ops);
+	result = acpi_add_single_object(child, handle, type, &ops);
 	if (!result)
 		result = acpi_bus_scan(*child, &ops);
 
@@ -1584,15 +1610,13 @@ static int acpi_bus_scan_fixed(void)
 	 * Enumerate all fixed-feature devices.
 	 */
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON) == 0) {
-		result = acpi_add_single_object(&device, acpi_root,
-						NULL,
+		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_POWER_BUTTON,
 						&ops);
 	}
 
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON) == 0) {
-		result = acpi_add_single_object(&device, acpi_root,
-						NULL,
+		result = acpi_add_single_object(&device, NULL,
 						ACPI_BUS_TYPE_SLEEP_BUTTON,
 						&ops);
 	}
@@ -1618,7 +1642,7 @@ int __init acpi_scan_init(void)
 	/*
 	 * Create the root device in the bus's device tree
 	 */
-	result = acpi_add_single_object(&acpi_root, NULL, ACPI_ROOT_OBJECT,
+	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
 					ACPI_BUS_TYPE_SYSTEM, &ops);
 	if (result)
 		goto Done;

