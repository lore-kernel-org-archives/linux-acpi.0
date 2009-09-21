From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 04/17] ACPI: remove redundant "handle" and "parent"
	arguments
Date: Mon, 21 Sep 2009 13:29:05 -0600
Message-ID: <20090921192904.21322.43654.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:16467 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZIUT3C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:02 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

In several cases, functions take handle and parent device pointers in
addition to acpi_device pointers.  But the acpi_device structure contains
both the handle and the parent pointer, so it's pointless and error-prone
to pass them all.  This patch removes the unnecessary "handle" and "parent"
arguments.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0302dd4..ab5a264 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -474,12 +474,12 @@ struct bus_type acpi_bus_type = {
 	.uevent		= acpi_device_uevent,
 };
 
-static int acpi_device_register(struct acpi_device *device,
-				 struct acpi_device *parent)
+static int acpi_device_register(struct acpi_device *device)
 {
 	int result;
 	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
 	int found = 0;
+
 	/*
 	 * Linkage
 	 * -------
@@ -524,7 +524,7 @@ static int acpi_device_register(struct acpi_device *device,
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
-		device->dev.parent = &parent->dev;
+		device->dev.parent = &device->parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device->dev.release = &acpi_device_release;
 	result = device_register(&device->dev);
@@ -918,8 +918,7 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_device_get_busid(struct acpi_device *device,
-				  acpi_handle handle, int type)
+static void acpi_device_get_busid(struct acpi_device *device, int type)
 {
 	char bus_id[5] = { '?', 0 };
 	struct acpi_buffer buffer = { sizeof(bus_id), bus_id };
@@ -942,7 +941,7 @@ static void acpi_device_get_busid(struct acpi_device *device,
 		strcpy(device->pnp.bus_id, "SLPF");
 		break;
 	default:
-		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+		acpi_get_name(device->handle, ACPI_SINGLE_NAME, &buffer);
 		/* Clean up trailing underscores (if any) */
 		for (i = 3; i > 1; i--) {
 			if (bus_id[i] == '_')
@@ -1058,9 +1057,7 @@ acpi_add_cid(
 	return cid;
 }
 
-static void acpi_device_set_id(struct acpi_device *device,
-			       struct acpi_device *parent, acpi_handle handle,
-			       int type)
+static void acpi_device_set_id(struct acpi_device *device, int type)
 {
 	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
@@ -1071,7 +1068,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
-		status = acpi_get_object_info(handle, &info);
+		status = acpi_get_object_info(device->handle, &info);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
 			return;
@@ -1126,7 +1123,8 @@ static void acpi_device_set_id(struct acpi_device *device,
 	 * ----
 	 * Fix for the system root bus device -- the only root-level device.
 	 */
-	if (((acpi_handle)parent == ACPI_ROOT_OBJECT) && (type == ACPI_BUS_TYPE_DEVICE)) {
+	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
+	     (type == ACPI_BUS_TYPE_DEVICE)) {
 		hid = ACPI_BUS_HID;
 		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
 		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
@@ -1246,8 +1244,7 @@ acpi_add_single_object(struct acpi_device **child,
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
 
-
-	acpi_device_get_busid(device, handle, type);
+	acpi_device_get_busid(device, type);
 
 	/*
 	 * Flags
@@ -1310,7 +1307,7 @@ acpi_add_single_object(struct acpi_device **child,
 	 * Hardware ID, Unique ID, & Bus Address
 	 * -------------------------------------
 	 */
-	acpi_device_set_id(device, parent, handle, type);
+	acpi_device_set_id(device, type);
 
 	/*
 	 * Power Management
@@ -1345,7 +1342,7 @@ acpi_add_single_object(struct acpi_device **child,
 	if ((result = acpi_device_set_context(device, type)))
 		goto end;
 
-	result = acpi_device_register(device, parent);
+	result = acpi_device_register(device);
 
 	/*
 	 * Bind _ADR-Based Devices when hot add

