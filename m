From: Len Brown <lenb@kernel.org>
Subject: [PATCH 072/112] DMI: remove duplicate helper routine
Date: Thu,  7 Feb 2008 04:34:34 -0500
Message-ID: <e6298c6d60838495978cdbe5555dc290785bb961.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754971AbYBGJgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:31 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Use existing dmi_get_system_info(),
Delete duplicate dmi_get_slot()

Spotted-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c          |   12 ++++++------
 drivers/firmware/dmi_scan.c |    9 ---------
 include/linux/dmi.h         |    2 --
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e53fb51..347cda2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1220,17 +1220,17 @@ int acpi_dmi_dump(void)
 		return -1;
 
 	printk(KERN_NOTICE PREFIX "DMI System Vendor: %s\n",
-		dmi_get_slot(DMI_SYS_VENDOR));
+		dmi_get_system_info(DMI_SYS_VENDOR));
 	printk(KERN_NOTICE PREFIX "DMI Product Name: %s\n",
-		dmi_get_slot(DMI_PRODUCT_NAME));
+		dmi_get_system_info(DMI_PRODUCT_NAME));
 	printk(KERN_NOTICE PREFIX "DMI Product Version: %s\n",
-		dmi_get_slot(DMI_PRODUCT_VERSION));
+		dmi_get_system_info(DMI_PRODUCT_VERSION));
 	printk(KERN_NOTICE PREFIX "DMI Board Name: %s\n",
-		dmi_get_slot(DMI_BOARD_NAME));
+		dmi_get_system_info(DMI_BOARD_NAME));
 	printk(KERN_NOTICE PREFIX "DMI BIOS Vendor: %s\n",
-		dmi_get_slot(DMI_BIOS_VENDOR));
+		dmi_get_system_info(DMI_BIOS_VENDOR));
 	printk(KERN_NOTICE PREFIX "DMI BIOS Date: %s\n",
-		dmi_get_slot(DMI_BIOS_DATE));
+		dmi_get_system_info(DMI_BIOS_DATE));
 
 	return 0;
 }
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 9008ed5..e0bade7 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -489,12 +489,3 @@ int dmi_get_year(int field)
 
 	return year;
 }
-
-/**
- *	dmi_get_slot - return dmi_ident[slot]
- *	@slot:	index into dmi_ident[]
- */
-char *dmi_get_slot(int slot)
-{
-	return(dmi_ident[slot]);
-}
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 5b42a65..b1251b2 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -79,7 +79,6 @@ extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
 extern int dmi_name_in_vendors(const char *str);
 extern int dmi_available;
-extern char *dmi_get_slot(int slot);
 
 #else
 
@@ -90,7 +89,6 @@ static inline const struct dmi_device * dmi_find_device(int type, const char *na
 static inline int dmi_get_year(int year) { return 0; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 #define dmi_available 0
-static inline char *dmi_get_slot(int slot) { return NULL; }
 
 #endif
 
-- 
1.5.4.23.gef5b9

