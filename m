From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 06/19] ACPI: remove redundant "handle" and "parent" arguments
Date: Mon, 31 Aug 2009 16:32:36 -0600
Message-ID: <20090831223236.11814.41533.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:10581 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZHaWc3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:29 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
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
 drivers/acpi/scan.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 177f1b4..38742d7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -470,12 +470,12 @@ struct bus_type acpi_bus_type = {
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
@@ -520,7 +520,7 @@ static int acpi_device_register(struct acpi_device *device,
 	mutex_unlock(&acpi_device_lock);
 
 	if (device->parent)
-		device->dev.parent = &parent->dev;
+		device->dev.parent = &device->parent->dev;
 	device->dev.bus = &acpi_bus_type;
 	device->dev.release = &acpi_device_release;
 	result = device_register(&device->dev);
@@ -913,8 +913,7 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_device_get_busid(struct acpi_device *device,
-				  acpi_handle handle, int type)
+static void acpi_device_get_busid(struct acpi_device *device, int type)
 {
 	char bus_id[5] = { '?', 0 };
 	struct acpi_buffer buffer = { sizeof(bus_id), bus_id };
@@ -937,7 +936,7 @@ static void acpi_device_get_busid(struct acpi_device *device,
 		strcpy(device->pnp.bus_id, "SLPF");
 		break;
 	default:
-		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+		acpi_get_name(device->handle, ACPI_SINGLE_NAME, &buffer);
 		/* Clean up trailing underscores (if any) */
 		for (i = 3; i > 1; i--) {
 			if (bus_id[i] == '_')
@@ -1053,9 +1052,7 @@ acpi_add_cid(
 	return cid;
 }
 
-static void acpi_device_set_id(struct acpi_device *device,
-			       struct acpi_device *parent, acpi_handle handle,
-			       int type)
+static void acpi_device_set_id(struct acpi_device *device, int type)
 {
 	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
@@ -1066,7 +1063,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
-		status = acpi_get_object_info(handle, &info);
+		status = acpi_get_object_info(device->handle, &info);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
 			return;
@@ -1121,7 +1118,8 @@ static void acpi_device_set_id(struct acpi_device *device,
 	 * ----
 	 * Fix for the system root bus device -- the only root-level device.
 	 */
-	if (((acpi_handle)parent == ACPI_ROOT_OBJECT) && (type == ACPI_BUS_TYPE_DEVICE)) {
+	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
+	     (type == ACPI_BUS_TYPE_DEVICE)) {
 		hid = ACPI_BUS_HID;
 		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
 		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
@@ -1239,8 +1237,7 @@ acpi_add_single_object(struct acpi_device **child,
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
 
-
-	acpi_device_get_busid(device, handle, type);
+	acpi_device_get_busid(device, type);
 
 	/*
 	 * Flags
@@ -1303,7 +1300,7 @@ acpi_add_single_object(struct acpi_device **child,
 	 * Hardware ID, Unique ID, & Bus Address
 	 * -------------------------------------
 	 */
-	acpi_device_set_id(device, parent, handle, type);
+	acpi_device_set_id(device, type);
 
 	/*
 	 * The ACPI device is attached to acpi handle before getting
@@ -1345,8 +1342,7 @@ acpi_add_single_object(struct acpi_device **child,
 			goto end;
 	}
 
-
-	result = acpi_device_register(device, parent);
+	result = acpi_device_register(device);
 
 	/*
 	 * Bind _ADR-Based Devices when hot add

