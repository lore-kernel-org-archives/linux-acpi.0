From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 10/19] ACPI: remove redundant "type" arguments
Date: Mon, 31 Aug 2009 16:32:56 -0600
Message-ID: <20090831223256.11814.86376.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:10705 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZHaWct (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:49 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

We now save the ACPI bus "device_type" in the acpi_device structure, so
we don't need to pass it around explicitly anymore.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 42324a0..f86dee8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -911,7 +911,7 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_device_get_busid(struct acpi_device *device, int type)
+static void acpi_device_get_busid(struct acpi_device *device)
 {
 	char bus_id[5] = { '?', 0 };
 	struct acpi_buffer buffer = { sizeof(bus_id), bus_id };
@@ -923,7 +923,7 @@ static void acpi_device_get_busid(struct acpi_device *device, int type)
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	switch (type) {
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_SYSTEM:
 		strcpy(device->pnp.bus_id, "ACPI");
 		break;
@@ -1050,7 +1050,7 @@ acpi_add_cid(
 	return cid;
 }
 
-static void acpi_device_set_id(struct acpi_device *device, int type)
+static void acpi_device_set_id(struct acpi_device *device)
 {
 	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
@@ -1059,7 +1059,7 @@ static void acpi_device_set_id(struct acpi_device *device, int type)
 	char *cid_add = NULL;
 	acpi_status status;
 
-	switch (type) {
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		status = acpi_get_object_info(device->handle, &info);
 		if (ACPI_FAILURE(status)) {
@@ -1117,7 +1117,7 @@ static void acpi_device_set_id(struct acpi_device *device, int type)
 	 * Fix for the system root bus device -- the only root-level device.
 	 */
 	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
-	     (type == ACPI_BUS_TYPE_DEVICE)) {
+	     (device->device_type == ACPI_BUS_TYPE_DEVICE)) {
 		hid = ACPI_BUS_HID;
 		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
 		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
@@ -1234,7 +1234,7 @@ acpi_add_single_object(struct acpi_device **child,
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
 
-	acpi_device_get_busid(device, type);
+	acpi_device_get_busid(device);
 
 	/*
 	 * Flags
@@ -1297,7 +1297,7 @@ acpi_add_single_object(struct acpi_device **child,
 	 * Hardware ID, Unique ID, & Bus Address
 	 * -------------------------------------
 	 */
-	acpi_device_set_id(device, type);
+	acpi_device_set_id(device);
 
 	/*
 	 * The ACPI device is attached to acpi handle before getting

