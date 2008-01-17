From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] ACPI: use dmi_dump_entries() instead of requesting dmidecode output
Date: Thu, 17 Jan 2008 05:24:48 -0500
Message-ID: <879cd034c7713e797496bda87dd5a7c54095dd9f.1200565331.git.len.brown@intel.com>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:4525 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754477AbYAQKZB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 05:25:01 -0500
In-Reply-To: <1200565490-29619-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Dump DMI data to console instead of asking users to run dmidecode.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e3a673a..3c767e7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1141,6 +1141,18 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
+/*
+ * The DMI entries to dump to the screeen
+ * for easy DMI blacklist creation from dmesg.
+ */
+#define DMI_INTERESTING_ENTRIES (\
+	(1 << DMI_BIOS_VENDOR) | \
+	(1 << DMI_BIOS_DATE) | \
+	(1 << DMI_SYS_VENDOR) | \
+	(1 << DMI_PRODUCT_NAME) | \
+	(1 << DMI_PRODUCT_VERSION) | \
+	(1 << DMI_BOARD_NAME))
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_interface
@@ -1162,10 +1174,13 @@ acpi_os_validate_interface (char *interface)
 	if (!strcmp("Linux", interface)) {
 		printk(KERN_WARNING PREFIX
 			"System BIOS is requesting _OSI(Linux)\n");
+		if (dmi_dump_entries(DMI_INTERESTING_ENTRIES))
+			printk(KERN_WARNING
+			"[please extract dmidecode output]\n");
 		printk(KERN_WARNING PREFIX
 			"If \"acpi_osi=Linux\" works better,\n"
-			"Please send dmidecode "
-			"to linux-acpi@vger.kernel.org\n");
+			"Please send DMI info above to "
+			"linux-acpi@vger.kernel.org\n");
 		if(osi_linux)
 			return AE_OK;
 	}
-- 
1.5.4.rc3.14.g44397

