From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/7] ACPI: Introduce static func: cid_add to add IDs as
	compatible IDs to a device - snd version
Date: Tue, 13 May 2008 20:30:42 +0200
Message-ID: <1210703442.6350.32.camel@hammer1.suse.de>
References: <1208371949.1784.343.camel@queen.suse.de>
	 <1208422963.7844.13.camel@yakui_zhao.sh.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34554 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757059AbYEMQav (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2008 12:30:51 -0400
In-Reply-To: <1208422963.7844.13.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Hi Yakui,

On Thu, 2008-04-17 at 17:02 +0800, Zhao Yakui wrote:
> On Wed, 2008-04-16 at 20:52 +0200, Thomas Renninger wrote:
> > ACPI: Introduce static func: cid_add to add IDs as compatible IDs to a device
> > 
> > Rip the functionality out of acpi_device_set_id, it is needed elsewhere in
> > the code on follow-up patches.
> > 
> It seems that the cid_add function will be called twice for some
> devices. 
> For example: VIDEO device
>     When the CID object exists, the cid_add function will be called to
> add the compatible_list.
>     When it is identified as the VIDEO device, the cid_add function will
> be called again to add the compatible_list.
> 
> In such case the compatible_list pointer will be replaced directly by
> new pointer and the memory pointed by compatible_list can't be free.

Can you give this another review, pls.

Thanks,

   Thomas

ACPI: Introduce static func: cid_add to add IDs as compatible IDs to a device

Cleanup: Introduce a new function to add CIDs (single or in a list).

Fix a memleak: cid_list must not be allocated


Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/scan.c |   99 +++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
===================================================================
--- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/scan.c
+++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/scan.c
@@ -44,6 +44,12 @@ static int create_modalias(struct acpi_d
 	if (!acpi_dev->flags.hardware_id && !acpi_dev->flags.compatible_ids)
 		return -ENODEV;
 
+	/* This could happen if _CID is available, but for some reason, the
+	   content has not been added */
+	if (acpi_dev->flags.compatible_ids && !acpi_dev->pnp.cid_list) {
+		return -ENODEV;
+	}
+
 	len = snprintf(modalias, size, "acpi:");
 	size -= len;
 
@@ -994,6 +1000,48 @@ static int acpi_dock_match(struct acpi_d
 	return acpi_get_handle(device->handle, "_DCK", &tmp);
 }
 
+/* Add a single Compatible ID or a whole list of CIDs to a device */
+static void cid_add(struct acpi_device *device, const char *cid_add,
+		    const struct acpi_compatible_id_list *cid_list) {
+
+	struct acpi_compatible_id_list *list = NULL;
+	struct acpi_compatible_id_list tmp_list;
+	int size = 0;
+	int count = 0;
+
+	if (!cid_list && !cid_add)
+		return;
+
+	if (cid_list) {
+		size = cid_list->size;
+	} else {
+		size = sizeof(struct acpi_compatible_id_list);
+		tmp_list.count = 0;
+		tmp_list.size = size;
+	}
+	if (cid_add)
+		size += sizeof(struct acpi_compatible_id);
+	list = kzalloc(size, GFP_KERNEL);
+
+	if (list) {
+		if (cid_list) {
+			memcpy(list, cid_list, cid_list->size);
+			count = cid_list->count;
+		}
+		if (cid_add) {
+			strncpy(list->id[count].value, cid_add,
+				ACPI_MAX_CID_LENGTH);
+			count++;
+			device->flags.compatible_ids = 1;
+		}
+		list->size = size;
+		list->count = count;
+		kfree(device->pnp.cid_list);
+		device->pnp.cid_list = list;
+	} else
+		printk(KERN_ERR PREFIX "Memory allocation error\n");
+}
+
 static void acpi_device_set_id(struct acpi_device *device,
 			       struct acpi_device *parent, acpi_handle handle,
 			       int type)
@@ -1002,8 +1050,6 @@ static void acpi_device_set_id(struct ac
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	char *hid = NULL;
 	char *uid = NULL;
-	struct acpi_compatible_id_list *cid_list = NULL;
-	const char *cid_add = NULL;
 	acpi_status status;
 
 	switch (type) {
@@ -1020,7 +1066,7 @@ static void acpi_device_set_id(struct ac
 		if (info->valid & ACPI_VALID_UID)
 			uid = info->unique_id.value;
 		if (info->valid & ACPI_VALID_CID)
-			cid_list = &info->compatibility_id;
+			cid_add(device, NULL, &info->compatibility_id);
 		if (info->valid & ACPI_VALID_ADR) {
 			device->pnp.bus_address = info->address;
 			device->flags.bus_address = 1;
@@ -1032,11 +1078,11 @@ static void acpi_device_set_id(struct ac
 		   against another driver.
 		*/
 		if (ACPI_SUCCESS(acpi_video_bus_match(device)))
-			cid_add = ACPI_VIDEO_HID;
+			cid_add(device, ACPI_VIDEO_HID, NULL);
 		else if (ACPI_SUCCESS(acpi_bay_match(device)))
-			cid_add = ACPI_BAY_HID;
+			cid_add(device, ACPI_BAY_HID, NULL);
 		else if (ACPI_SUCCESS(acpi_dock_match(device)))
-			cid_add = ACPI_DOCK_HID;
+			cid_add(device, ACPI_DOCK_HID, NULL);;
 
 		break;
 	case ACPI_BUS_TYPE_POWER:
@@ -1078,47 +1124,6 @@ static void acpi_device_set_id(struct ac
 		strcpy(device->pnp.unique_id, uid);
 		device->flags.unique_id = 1;
 	}
-	if (cid_list || cid_add) {
-		struct  acpi_compatible_id_list *list;
-		int size = 0;
-		int count = 0;
-
-		if (cid_list) {
-			size = cid_list->size;
-		} else if (cid_add) {
-			size = sizeof(struct acpi_compatible_id_list);
-			cid_list = ACPI_ALLOCATE_ZEROED((acpi_size) size);
-			if (!cid_list) {
-				printk(KERN_ERR "Memory allocation error\n");
-				kfree(buffer.pointer);
-				return;
-			} else {
-				cid_list->count = 0;
-				cid_list->size = size;
-			}
-		}
-		if (cid_add)
-			size += sizeof(struct acpi_compatible_id);
-		list = kmalloc(size, GFP_KERNEL);
-
-		if (list) {
-			if (cid_list) {
-				memcpy(list, cid_list, cid_list->size);
-				count = cid_list->count;
-			}
-			if (cid_add) {
-				strncpy(list->id[count].value, cid_add,
-					ACPI_MAX_CID_LENGTH);
-				count++;
-				device->flags.compatible_ids = 1;
-			}
-			list->size = size;
-			list->count = count;
-			device->pnp.cid_list = list;
-		} else
-			printk(KERN_ERR PREFIX "Memory allocation error\n");
-	}
-
 	kfree(buffer.pointer);
 }
 


