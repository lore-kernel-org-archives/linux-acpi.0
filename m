From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v2 7/8] ACPI: remove acpi_device_uid() and related stuff
Date: Mon, 31 Aug 2009 16:47:20 -0600
Message-ID: <20090831224720.12236.33721.stgit@bob.kio>
References: <20090831224535.12236.61350.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32230 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZHaWrO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:47:14 -0400
In-Reply-To: <20090831224535.12236.61350.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Nobody uses acpi_device_uid(), so this patch removes it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |   17 -----------------
 include/acpi/acpi_bus.h |    4 +---
 2 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 08e4750..f19a935 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1016,7 +1016,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 {
 	struct acpi_device_info *info = NULL;
 	char *hid = NULL;
-	char *uid = NULL;
 	struct acpica_device_id_list *cid_list = NULL;
 	char *cid_add = NULL;
 	acpi_status status;
@@ -1043,8 +1042,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 		if (info->valid & ACPI_VALID_HID)
 			hid = info->hardware_id.string;
-		if (info->valid & ACPI_VALID_UID)
-			uid = info->unique_id.string;
 		if (info->valid & ACPI_VALID_CID)
 			cid_list = &info->compatible_id_list;
 		if (info->valid & ACPI_VALID_ADR) {
@@ -1094,15 +1091,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 	if (hid)
 		acpi_add_id(device, hid);
-	if (uid) {
-		device->pnp.unique_id = ACPI_ALLOCATE_ZEROED(strlen (uid) + 1);
-		if (device->pnp.unique_id) {
-			strcpy(device->pnp.unique_id, uid);
-			device->flags.unique_id = 1;
-		}
-	} else
-		device->pnp.unique_id = NULL;
-
 	if (cid_list)
 		for (i = 0; i < cid_list->count; i++)
 			acpi_add_id(device, cid_list->ids[i].string);
@@ -1197,11 +1185,6 @@ static int acpi_add_single_object(struct acpi_device **child,
 	 * -----------------
 	 * TBD: Synch with Core's enumeration/initialization process.
 	 */
-
-	/*
-	 * Hardware ID, Unique ID, & Bus Address
-	 * -------------------------------------
-	 */
 	acpi_device_set_id(device);
 
 	/*
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 012be7d..49c414e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -142,7 +142,6 @@ struct acpi_device_status {
 struct acpi_device_flags {
 	u32 dynamic_status:1;
 	u32 bus_address:1;
-	u32 unique_id:1;
 	u32 removable:1;
 	u32 ejectable:1;
 	u32 lockable:1;
@@ -151,7 +150,7 @@ struct acpi_device_flags {
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
 	u32 force_power_state:1;
-	u32 reserved:21;
+	u32 reserved:22;
 };
 
 /* File System */
@@ -186,7 +185,6 @@ struct acpi_device_pnp {
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
 char *acpi_device_hid(struct acpi_device *device);
-#define acpi_device_uid(d)	((d)->pnp.unique_id)
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)
 

