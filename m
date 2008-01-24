From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] ACPI: create acpi_dmi_dump()
Date: Wed, 23 Jan 2008 21:32:42 -0500
Message-ID: <5a4e143271b97dcaa113761a76942c4d4bc273a2.1201141721.git.len.brown@intel.com>
References: <1201141967-28134-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:21248 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751727AbYAXCdj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:33:39 -0500
In-Reply-To: <1201141967-28134-1-git-send-email-lenb@kernel.org>
In-Reply-To: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
References: <81b4e1f6269cea345f17d3aa349ec9beb31a8cd3.1201141721.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

A utility routine to print common entries used
for ACPI-related DMI blacklist entries.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e3a673a..93ad5f4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1141,6 +1141,34 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
+/**
+ *	acpi_dmi_dump - dump DMI slots needed for blacklist entry
+ *
+ *	Returns 0 on success
+ */
+int acpi_dmi_dump(void)
+{
+
+	if (!dmi_available)
+		return -1;
+
+	printk(KERN_NOTICE PREFIX "DMI System Vendor: %s\n",
+		dmi_get_slot(DMI_SYS_VENDOR));
+	printk(KERN_NOTICE PREFIX "DMI Product Name: %s\n",
+		dmi_get_slot(DMI_PRODUCT_NAME));
+	printk(KERN_NOTICE PREFIX "DMI Product Version: %s\n",
+		dmi_get_slot(DMI_PRODUCT_VERSION));
+	printk(KERN_NOTICE PREFIX "DMI Board Name: %s\n",
+		dmi_get_slot(DMI_BOARD_NAME));
+	printk(KERN_NOTICE PREFIX "DMI BIOS Vendor: %s\n",
+		dmi_get_slot(DMI_BIOS_VENDOR));
+	printk(KERN_NOTICE PREFIX "DMI BIOS Date: %s\n",
+		dmi_get_slot(DMI_BIOS_DATE));
+
+	return 0;
+}
+
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_interface
-- 
1.5.4.rc4.14.g6fc74

