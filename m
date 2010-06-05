From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] PNPACPI: cope with invalid device IDs
Date: Fri, 04 Jun 2010 19:24:04 -0700
Message-ID: <20100605022404.25768.77841.stgit@localhost.localdomain>
References: <20100605022058.25768.77560.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38306 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab0FECYJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 22:24:09 -0400
In-Reply-To: <20100605022058.25768.77560.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

If primary ID (HID) is invalid try locating first valid ID on compatible
ID list before giving up.

This helps, for example, to recognize i8042 AUX port on Sony Vaio VPCZ1
which uses SNYSYN0003 as HID. Without the patch users are forced to
boot with i8042.nopnp to make use of their touchpads.

Tested-by: Jan-Hendrik Zab <jan@jhz.name>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/pnp/pnpacpi/core.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index f7ff628..2029cb5 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -28,7 +28,7 @@
 #include "../base.h"
 #include "pnpacpi.h"
 
-static int num = 0;
+static int num;
 
 /* We need only to blacklist devices that have already an acpi driver that
  * can't use pnp layer. We don't need to blacklist device that are directly
@@ -157,11 +157,24 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
+static char *pnpacpi_get_id(struct acpi_device *device)
+{
+	struct acpi_hardware_id *id;
+
+	list_for_each_entry(id, &device->pnp.ids, list) {
+		if (ispnpidacpi(id->id))
+			return id->id;
+	}
+
+	return NULL;
+}
+
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
 	acpi_handle temp = NULL;
 	acpi_status status;
 	struct pnp_dev *dev;
+	char *pnpid;
 	struct acpi_hardware_id *id;
 
 	/*
@@ -169,11 +182,17 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	 * driver should not be loaded.
 	 */
 	status = acpi_get_handle(device->handle, "_CRS", &temp);
-	if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
-	    is_exclusive_device(device) || (!device->status.present))
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	pnpid = pnpacpi_get_id(device);
+	if (!pnpid)
+		return 0;
+
+	if (!is_exclusive_device(device) || !device->status.present)
 		return 0;
 
-	dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));
+	dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid);
 	if (!dev)
 		return -ENOMEM;
 
@@ -204,7 +223,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 		pnpacpi_parse_resource_option_data(dev);
 
 	list_for_each_entry(id, &device->pnp.ids, list) {
-		if (!strcmp(id->id, acpi_device_hid(device)))
+		if (!strcmp(id->id, pnpid))
 			continue;
 		if (!ispnpidacpi(id->id))
 			continue;

