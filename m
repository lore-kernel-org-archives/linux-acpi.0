From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] PNPACPI: cope with invalid device IDs
Date: Fri, 04 Jun 2010 01:04:32 -0700
Message-ID: <20100604080432.16068.31159.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57595 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0FDIEj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 04:04:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

If primary ID (HID) is invalid try locating first valid ID on compatible
ID list before giving up. This helps, for example, to recognize i8042 AUX
port on Sony Vaio VPCZ1 which uses SNYSYN0003 as HID.

Tested-by: Jan-Hendrik Zab <jan@jhz.name>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/pnp/pnpacpi/core.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index f7ff628..1bf1677 100644
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
 

