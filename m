From: yakui.zhao@intel.com
Subject: [PATCH] ACPI: Add the check of ADR flag in course of finding ACPI handle for PCI device
Date: Tue, 13 Jul 2010 11:36:08 +0800
Message-ID: <1278992168-7457-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab0GMDmF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Jul 2010 23:42:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The _ADR object is used to provide OSPM with the address of one device on its
parent bus. In course of finding ACPI handle for the corresponding PCI device,
we will firstly evaluate the _ADR object and then compare the two addresses to
see whether it is the target ACPI device. But for one PCI device(0000:00:00.0)
under the PCI root bridge, the corresponding address will be constructed as
zero.In such case maybe the ACPI device without _ADR object will be misdetected
and then be used to create the relationship between PCI device and ACPI device.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/glue.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 4af6301..78b0164 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -100,7 +100,8 @@ do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_SUCCESS(status)) {
-		if (info->address == find->address)
+		if ((info->address == find->address)
+			&& (info->valid & ACPI_VALID_ADR))
 			find->handle = handle;
 		kfree(info);
 	}
-- 
1.5.4.5

