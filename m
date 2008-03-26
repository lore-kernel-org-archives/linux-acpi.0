From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/6] ACPI: fix a regression of ACPI device driver autoloading
Date: Wed, 26 Mar 2008 01:13:37 -0400
Message-ID: <5c9fcb5deef4d3a49798d76c48b726d2e3c7df72.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:44118 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342AbYCZFVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:21:35 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
In-Reply-To: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

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

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 57570ac..e6ce262 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -39,20 +39,26 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
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
-- 
1.5.5.rc1.6.g5cc8f

