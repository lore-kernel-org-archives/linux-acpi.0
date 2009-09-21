From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 14/17] ACPI: use acpi_walk_namespace() to enumerate devices
Date: Mon, 21 Sep 2009 13:29:56 -0600
Message-ID: <20090921192955.21322.35834.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:36100 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbZIUT3w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:52 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

acpi_bus_scan() currently walks the namespace manually.  This patch changes
it to use acpi_walk_namespace() instead.

Besides removing some complicated code, this means we take advantage of the
namespace locking done by acpi_walk_namespace().  The locking isn't so
important at boot-time, but I hope to eventually use this same path to
handle hot-addition of devices, when it will be important.

Note that acpi_walk_namespace() does not actually visit the starting node
first, so we need to do that by hand first.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |  196 +++++++++++++++++++--------------------------------
 1 files changed, 74 insertions(+), 122 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0b5aaf0..ed2b5f9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1393,123 +1393,92 @@ end:
 	return result;
 }
 
-static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops)
+static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
+				      void *context, void **return_value)
 {
 	acpi_status status = AE_OK;
-	struct acpi_device *parent = NULL;
-	struct acpi_device *child = NULL;
-	acpi_handle phandle = NULL;
-	acpi_handle chandle = NULL;
+	struct acpi_device *device = NULL;
 	acpi_object_type type = 0;
-	u32 level = 1;
-	int ret;
+	struct acpi_bus_ops *ops = context;
 
-	/*
-	 * We must have an acpi_device for the starting node already, and
-	 * we scan its children.
-	 */
-	phandle = handle;
-	ret = acpi_bus_get_device(phandle, &parent);
-	if (ret)
-		return ret;
+	status = acpi_get_type(handle, &type);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
 
 	/*
-	 * Parse through the ACPI namespace, identify all 'devices', and
-	 * create a new 'struct acpi_device' for each.
+	 * We're only interested in objects that we consider 'devices'.
 	 */
-	while ((level > 0) && parent) {
+	switch (type) {
+	case ACPI_TYPE_ANY:		/* for ACPI_ROOT_OBJECT */
+	case ACPI_TYPE_DEVICE:
+		type = ACPI_BUS_TYPE_DEVICE;
+		break;
+	case ACPI_TYPE_PROCESSOR:
+		type = ACPI_BUS_TYPE_PROCESSOR;
+		break;
+	case ACPI_TYPE_THERMAL:
+		type = ACPI_BUS_TYPE_THERMAL;
+		break;
+	case ACPI_TYPE_POWER:
+		type = ACPI_BUS_TYPE_POWER;
+		break;
+	default:
+		return AE_OK;
+	}
 
-		status = acpi_get_next_object(ACPI_TYPE_ANY, phandle,
-					      chandle, &chandle);
+	if (ops->acpi_op_add)
+		status = acpi_add_single_object(&device, handle, type, ops);
+	else
+		status = acpi_bus_get_device(handle, &device);
 
-		/*
-		 * If this scope is exhausted then move our way back up.
-		 */
-		if (ACPI_FAILURE(status)) {
-			level--;
-			chandle = phandle;
-			acpi_get_parent(phandle, &phandle);
-			if (parent->parent)
-				parent = parent->parent;
-			continue;
-		}
+	if (ACPI_FAILURE(status))
+		return AE_CTRL_DEPTH;
 
-		status = acpi_get_type(chandle, &type);
+	if (ops->acpi_op_start && !(ops->acpi_op_add)) {
+		status = acpi_start_single_object(device);
 		if (ACPI_FAILURE(status))
-			continue;
-
-		/*
-		 * If this is a scope object then parse it (depth-first).
-		 */
-		if (type == ACPI_TYPE_LOCAL_SCOPE) {
-			level++;
-			phandle = chandle;
-			chandle = NULL;
-			continue;
-		}
+			return AE_CTRL_DEPTH;
+	}
 
-		/*
-		 * We're only interested in objects that we consider 'devices'.
-		 */
-		switch (type) {
-		case ACPI_TYPE_DEVICE:
-			type = ACPI_BUS_TYPE_DEVICE;
-			break;
-		case ACPI_TYPE_PROCESSOR:
-			type = ACPI_BUS_TYPE_PROCESSOR;
-			break;
-		case ACPI_TYPE_THERMAL:
-			type = ACPI_BUS_TYPE_THERMAL;
-			break;
-		case ACPI_TYPE_POWER:
-			type = ACPI_BUS_TYPE_POWER;
-			break;
-		default:
-			continue;
-		}
+	/*
+	 * If the device is present, enabled, and functioning then
+	 * parse its scope (depth-first).  Note that we need to
+	 * represent absent devices to facilitate PnP notifications
+	 * -- but only the subtree head (not all of its children,
+	 * which will be enumerated when the parent is inserted).
+	 *
+	 * TBD: Need notifications and other detection mechanisms
+	 *      in place before we can fully implement this.
+	 *
+	 * When the device is not present but functional, it is also
+	 * necessary to scan the children of this device.
+	 */
+	if (!device->status.present && !device->status.functional)
+		return AE_CTRL_DEPTH;
 
-		if (ops->acpi_op_add)
-			status = acpi_add_single_object(&child, chandle, type,
-							ops);
-		else
-			status = acpi_bus_get_device(chandle, &child);
+	if (!*return_value)
+		*return_value = device;
+	return AE_OK;
+}
 
-		if (ACPI_FAILURE(status))
-			continue;
+static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops,
+			 struct acpi_device **child)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	void *device = NULL;
 
-		if (ops->acpi_op_start && !(ops->acpi_op_add)) {
-			status = acpi_start_single_object(child);
-			if (ACPI_FAILURE(status))
-				continue;
-		}
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	printk(KERN_INFO PREFIX "Enumerating devices from [%s]\n",
+	       (char *) buffer.pointer);
 
-		/*
-		 * If the device is present, enabled, and functioning then
-		 * parse its scope (depth-first).  Note that we need to
-		 * represent absent devices to facilitate PnP notifications
-		 * -- but only the subtree head (not all of its children,
-		 * which will be enumerated when the parent is inserted).
-		 *
-		 * TBD: Need notifications and other detection mechanisms
-		 *      in place before we can fully implement this.
-		 */
-		 /*
-		 * When the device is not present but functional, it is also
-		 * necessary to scan the children of this device.
-		 */
-		if (child->status.present || (!child->status.present &&
-					child->status.functional)) {
-			status = acpi_get_next_object(ACPI_TYPE_ANY, chandle,
-						      NULL, NULL);
-			if (ACPI_SUCCESS(status)) {
-				level++;
-				phandle = chandle;
-				chandle = NULL;
-				parent = child;
-			}
-		}
-	}
+	status = acpi_bus_check_add(handle, 0, ops, &device);
+	if (ACPI_SUCCESS(status))
+		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
+				    acpi_bus_check_add, ops, &device);
 
+	if (child)
+		*child = device;
 	return 0;
 }
 
@@ -1517,33 +1486,25 @@ int
 acpi_bus_add(struct acpi_device **child,
 	     struct acpi_device *parent, acpi_handle handle, int type)
 {
-	int result;
 	struct acpi_bus_ops ops;
 
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_add = 1;
 
-	result = acpi_add_single_object(child, handle, type, &ops);
-	if (!result)
-		result = acpi_bus_scan((*child)->handle, &ops);
-
-	return result;
+	acpi_bus_scan(handle, &ops, child);
+	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_add);
 
 int acpi_bus_start(struct acpi_device *device)
 {
-	int result;
 	struct acpi_bus_ops ops;
 
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_start = 1;
 
-	result = acpi_start_single_object(device);
-	if (!result)
-		result = acpi_bus_scan(device->handle, &ops);
-
-	return result;
+	acpi_bus_scan(device->handle, &ops, NULL);
+	return 0;
 }
 EXPORT_SYMBOL(acpi_bus_start);
 
@@ -1646,17 +1607,9 @@ int __init acpi_scan_init(void)
 	}
 
 	/*
-	 * Create the root device in the bus's device tree
-	 */
-	result = acpi_add_single_object(&acpi_root, ACPI_ROOT_OBJECT,
-					ACPI_BUS_TYPE_DEVICE, &ops);
-	if (result)
-		goto Done;
-
-	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-	result = acpi_bus_scan(acpi_root->handle, &ops);
+	result = acpi_bus_scan(ACPI_ROOT_OBJECT, &ops, &acpi_root);
 
 	if (!result)
 		result = acpi_bus_scan_fixed();
@@ -1664,6 +1617,5 @@ int __init acpi_scan_init(void)
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
 
-Done:
 	return result;
 }

