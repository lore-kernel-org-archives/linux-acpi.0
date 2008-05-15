From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 5/5] pci-acpi: minor cleanups for _OSC
Date: Thu, 15 May 2008 15:23:13 +0900
Message-ID: <482BD6D1.2010303@jp.fujitsu.com>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51233 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYEOGZw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:25:52 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

Minor cleanup in pci-acpi.c.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2-git3.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
@@ -51,7 +51,8 @@ static struct acpi_osc_data *acpi_get_os
 	return data;
 }
 
-static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
+			  0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status acpi_run_osc(acpi_handle handle,
 				struct acpi_osc_args *osc_args)
@@ -87,7 +88,7 @@ static acpi_status acpi_run_osc(acpi_han
 		status = AE_TYPE;
 		goto out_kfree;
 	}
-	osc_dw0 = *((u32 *) out_obj->buffer.pointer);
+	osc_dw0 = *((u32 *)out_obj->buffer.pointer);
 	if (osc_dw0) {
 		if (osc_dw0 & OSC_REQUEST_ERROR)
 			printk(KERN_DEBUG "_OSC request fails\n"); 


