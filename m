From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/10] ACPI: remove acpi_device_uid() and related stuff
Date: Mon, 24 Aug 2009 10:39:16 -0600
Message-ID: <20090824163916.28131.28482.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:46775 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZHXQjL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:39:11 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Nobody uses acpi_device_uid(), so this patch removes it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |   12 ------------
 include/acpi/acpi_bus.h |    6 +-----
 2 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c181728..a776018 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1017,7 +1017,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 	struct acpi_device_info *info;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	char *hid = NULL;
-	char *uid = NULL;
 	struct acpi_compatible_id_list *cid_list = NULL;
 	const char *cid_add = NULL;
 	acpi_status status;
@@ -1045,8 +1044,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 		info = buffer.pointer;
 		if (info->valid & ACPI_VALID_HID)
 			hid = info->hardware_id.value;
-		if (info->valid & ACPI_VALID_UID)
-			uid = info->unique_id.value;
 		if (info->valid & ACPI_VALID_CID)
 			cid_list = &info->compatibility_id;
 		if (info->valid & ACPI_VALID_ADR) {
@@ -1096,10 +1093,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 
 	if (hid)
 		acpi_add_id(device, hid);
-	if (uid) {
-		strcpy(device->pnp.unique_id, uid);
-		device->flags.unique_id = 1;
-	}
 	if (cid_list)
 		for (i = 0; i < cid_list->count; i++)
 			acpi_add_id(device, cid_list->id[i].value);
@@ -1194,11 +1187,6 @@ static int acpi_add_single_object(struct acpi_device **child,
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
index 7b353b7..d8b93a2 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -144,7 +144,6 @@ struct acpi_device_status {
 struct acpi_device_flags {
 	u32 dynamic_status:1;
 	u32 bus_address:1;
-	u32 unique_id:1;
 	u32 removable:1;
 	u32 ejectable:1;
 	u32 lockable:1;
@@ -153,7 +152,7 @@ struct acpi_device_flags {
 	u32 performance_manageable:1;
 	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
 	u32 force_power_state:1;
-	u32 reserved:21;
+	u32 reserved:22;
 };
 
 /* File System */
@@ -168,7 +167,6 @@ struct acpi_device_dir {
 
 typedef char acpi_bus_id[8];
 typedef unsigned long acpi_bus_address;
-typedef char acpi_unique_id[9];
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
@@ -181,7 +179,6 @@ struct acpi_device_pnp {
 	acpi_bus_id bus_id;	/* Object name */
 	acpi_bus_address bus_address;	/* _ADR */
 	struct list_head ids;		/* _HID and _CIDs */
-	acpi_unique_id unique_id;	/* _UID */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
 };
@@ -189,7 +186,6 @@ struct acpi_device_pnp {
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
 char *acpi_device_hid(struct acpi_device *device);
-#define acpi_device_uid(d)	((d)->pnp.unique_id)
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)
 

