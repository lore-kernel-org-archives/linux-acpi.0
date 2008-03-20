From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH] ACPI: fix a regression of ACPI device driver autoloading
Date: Thu, 20 Mar 2008 16:40:32 +0800
Message-ID: <1206002432.3171.90.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54833 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbYCTIyZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Mar 2008 04:54:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, kasievers@novell.com, fseidel@suse.de, "Brown, Len" <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

From: Zhang Rui <rui.zhang@intel.com>

Fix a regression of ACPI driver autoloading.

commit 3620f2f2f39e7870cf1a4fb2e34063a142f28716 sets the cid of
ACPI video/dock/bay device and leaves the hid empty.
As a result, "modalias" should export the cid for
devices which don't have a hid.

ACPI Video driver is not autoloaded with
commit 3620f2f2f39e7870cf1a4fb2e34063a142f28716 applied.
"cat /sys/.../device:03(acpi video bus)/modalias" shows nothing.

ACPI Video driver is autoloaded after revert that commit.
"cat /sys/.../LNXVIDEO:0x/modalias" shows "acpi:LNXVIDEO:"

ACPI Video driver is autoloaded with commit
3620f2f2f39e7870cf1a4fb2e34063a142f28716 and this patch applied.
"cat /sys/.../device:03(acpi video bus)/modalias"
shows "acpi:LNXVIDEO:"

CC: Thomas Renninger <trenn@novell.com>
CC: Kay Sievers <kasievers@novell.com>
CC: Frank Seidel <fseidel@suse.de>
CC: Len Brown: <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -39,20 +39,26 @@ static int create_modalias(struct acpi_d
 			   int size)
 {
 	int len;
+	int count;
 
-	if (!acpi_dev->flags.hardware_id)
+	if (!acpi_dev->flags.hardware_id && !acpi_dev->flags.compatible_ids)
 		return -ENODEV;
 
-	len = snprintf(modalias, size, "acpi:%s:",
-		       acpi_dev->pnp.hardware_id);
-	if (len < 0 || len >= size)
-		return -EINVAL;
+	len = snprintf(modalias, size, "acpi:");
 	size -= len;
 
+	if (acpi_dev->flags.hardware_id) {
+		count = snprintf(&modalias[len], size, "%s:",
+				 acpi_dev->pnp.hardware_id);
+		if (count < 0 || count >= size)
+			return -EINVAL;
+		len += count;
+		size -= count;
+	}
+
 	if (acpi_dev->flags.compatible_ids) {
 		struct acpi_compatible_id_list *cid_list;
 		int i;
-		int count;
 
 		cid_list = acpi_dev->pnp.cid_list;
 		for (i = 0; i < cid_list->count; i++) {


