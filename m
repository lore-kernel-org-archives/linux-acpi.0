From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 13/19] ACPI: convert acpi_bus_scan() to operate on an
	acpi_handle
Date: Fri, 31 Jul 2009 15:37:39 -0600
Message-ID: <20090731213739.29930.86177.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32636 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbZGaVhk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:37:40 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch changes acpi_bus_scan() to take an acpi_handle rather than an
acpi_device pointer.  I plan to use acpi_bus_scan() in the hotplug path,
and I'd rather not assume that notifications only go to nodes that already
have acpi_devices.

This will also help remove the special case for adding the root node.  We
currently add the root by hand before acpi_bus_scan(), but using a handle
here means we can start the acpi_bus_scan() directly with the root even
though it doesn't have an acpi_device yet.

Note that acpi_bus_scan() currently adds and/or starts the *children* of
its device argument.  It doesn't do anything with the device itself.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a57a7ae..afd10b5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1343,7 +1343,7 @@ end:
 	return result;
 }
 
-static int acpi_bus_scan(struct acpi_device *start, struct acpi_bus_ops *ops)
+static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops)
 {
 	acpi_status status = AE_OK;
 	struct acpi_device *parent = NULL;
@@ -1352,13 +1352,16 @@ static int acpi_bus_scan(struct acpi_device *start, struct acpi_bus_ops *ops)
 	acpi_handle chandle = NULL;
 	acpi_object_type type = 0;
 	u32 level = 1;
+	int ret;
 
-
-	if (!start)
-		return -EINVAL;
-
-	parent = start;
-	phandle = start->handle;
+	/*
+	 * We must have an acpi_device for the starting node already, and
+	 * we scan its children.
+	 */
+	phandle = handle;
+	ret = acpi_bus_get_device(phandle, &parent);
+	if (ret)
+		return ret;
 
 	/*
 	 * Parse through the ACPI namespace, identify all 'devices', and
@@ -1472,7 +1475,7 @@ acpi_bus_add(struct acpi_device **child,
 
 	result = acpi_add_single_object(child, handle, type, &ops);
 	if (!result)
-		result = acpi_bus_scan(*child, &ops);
+		result = acpi_bus_scan((*child)->handle, &ops);
 
 	return result;
 }
@@ -1483,16 +1486,13 @@ int acpi_bus_start(struct acpi_device *device)
 	int result;
 	struct acpi_bus_ops ops;
 
-
-	if (!device)
-		return -EINVAL;
+	memset(&ops, 0, sizeof(ops));
+	ops.acpi_op_start = 1;
 
 	result = acpi_start_single_object(device);
-	if (!result) {
-		memset(&ops, 0, sizeof(ops));
-		ops.acpi_op_start = 1;
-		result = acpi_bus_scan(device, &ops);
-	}
+	if (!result)
+		result = acpi_bus_scan(device->handle, &ops);
+
 	return result;
 }
 EXPORT_SYMBOL(acpi_bus_start);
@@ -1609,7 +1609,7 @@ int __init acpi_scan_init(void)
 	result = acpi_bus_scan_fixed();
 
 	if (!result)
-		result = acpi_bus_scan(acpi_root, &ops);
+		result = acpi_bus_scan(acpi_root->handle, &ops);
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);

