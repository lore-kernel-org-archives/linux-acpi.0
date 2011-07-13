From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 01/17] ACPI, APEI, HEST, Detect duplicated hardware error source ID
Date: Wed, 13 Jul 2011 13:14:12 +0800
Message-ID: <1310534068-30547-2-git-send-email-ying.huang@intel.com>
References: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9791 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1GMFOd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jul 2011 01:14:33 -0400
In-Reply-To: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

The firmware on some machine will report duplicated hardware error
source ID in HEST.  This is considered a firmware bug.  To provide
better warning message, this patch adds duplicated hardware error
source ID detecting and corresponding printk.

This patch fixes #37412 on kernel bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=37412

Reported-by: marconifabio@ubuntu-it.org
Signed-off-by: Huang Ying <ying.huang@intel.com>
Tested-by: Mathias <janedo.spam@gmail.com>
---
 drivers/acpi/apei/hest.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -139,13 +139,23 @@ static int __init hest_parse_ghes(struct
 {
 	struct platform_device *ghes_dev;
 	struct ghes_arr *ghes_arr = data;
-	int rc;
+	int rc, i;
 
 	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR)
 		return 0;
 
 	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
 		return 0;
+	for (i = 0; i < ghes_arr->count; i++) {
+		struct acpi_hest_header *hdr;
+		ghes_dev = ghes_arr->ghes_devs[i];
+		hdr = *(struct acpi_hest_header **)ghes_dev->dev.platform_data;
+		if (hdr->source_id == hest_hdr->source_id) {
+			pr_warning(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
+				   hdr->source_id);
+			return -EIO;
+		}
+	}
 	ghes_dev = platform_device_alloc("GHES", hest_hdr->source_id);
 	if (!ghes_dev)
 		return -ENOMEM;
