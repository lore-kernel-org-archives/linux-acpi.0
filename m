From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 08/17] ACPI: remove redundant "type" arguments
Date: Mon, 21 Sep 2009 13:29:25 -0600
Message-ID: <20090921192925.21322.28072.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:45616 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbZIUT3W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:22 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
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
index 44383fe..6c83342 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -916,7 +916,7 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_device_get_busid(struct acpi_device *device, int type)
+static void acpi_device_get_busid(struct acpi_device *device)
 {
 	char bus_id[5] = { '?', 0 };
 	struct acpi_buffer buffer = { sizeof(bus_id), bus_id };
@@ -928,7 +928,7 @@ static void acpi_device_get_busid(struct acpi_device *device, int type)
 	 * The device's Bus ID is simply the object name.
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
-	switch (type) {
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_SYSTEM:
 		strcpy(device->pnp.bus_id, "ACPI");
 		break;
@@ -1055,7 +1055,7 @@ acpi_add_cid(
 	return cid;
 }
 
-static void acpi_device_set_id(struct acpi_device *device, int type)
+static void acpi_device_set_id(struct acpi_device *device)
 {
 	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
@@ -1064,7 +1064,7 @@ static void acpi_device_set_id(struct acpi_device *device, int type)
 	char *cid_add = NULL;
 	acpi_status status;
 
-	switch (type) {
+	switch (device->device_type) {
 	case ACPI_BUS_TYPE_DEVICE:
 		status = acpi_get_object_info(device->handle, &info);
 		if (ACPI_FAILURE(status)) {
@@ -1122,7 +1122,7 @@ static void acpi_device_set_id(struct acpi_device *device, int type)
 	 * Fix for the system root bus device -- the only root-level device.
 	 */
 	if (((acpi_handle)device->parent == ACPI_ROOT_OBJECT) &&
-	     (type == ACPI_BUS_TYPE_DEVICE)) {
+	     (device->device_type == ACPI_BUS_TYPE_DEVICE)) {
 		hid = ACPI_BUS_HID;
 		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
 		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
@@ -1241,7 +1241,7 @@ acpi_add_single_object(struct acpi_device **child,
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
 
-	acpi_device_get_busid(device, type);
+	acpi_device_get_busid(device);
 
 	/*
 	 * Flags
@@ -1304,7 +1304,7 @@ acpi_add_single_object(struct acpi_device **child,
 	 * Hardware ID, Unique ID, & Bus Address
 	 * -------------------------------------
 	 */
-	acpi_device_set_id(device, type);
+	acpi_device_set_id(device);
 
 	/*
 	 * Power Management

