From: Len Brown <lenb@kernel.org>
Subject: [PATCH 104/112] ACPI: cleanup acpi.h
Date: Thu,  7 Feb 2008 04:35:06 -0500
Message-ID: <ee1ce6fcb383ba1da9d16e1ba902f592211aa508.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758526AbYBGJg5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:57 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <jdelvare@suse.de>

Two cleanups to <linux/acpi.h>:
* Stop defining acpi_mp_config, it isn't used anywhere.
* Discard nested "#ifdef CONFIG_ACPI", they are useless and
  error-prone.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/acpi.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 63f2e6e..ff68f13 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -43,8 +43,6 @@
 #include <linux/dmi.h>
 
 
-#ifdef CONFIG_ACPI
-
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
@@ -116,20 +114,12 @@ int acpi_unmap_lsapic(int cpu);
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
 int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
 
-extern int acpi_mp_config;
-
 extern struct acpi_mcfg_allocation *pci_mmcfg_config;
 extern int pci_mmcfg_config_num;
 
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
 
-#else	/* !CONFIG_ACPI */
-
-#define acpi_mp_config	0
-
-#endif 	/* !CONFIG_ACPI */
-
 int acpi_register_gsi (u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
@@ -145,8 +135,6 @@ extern int acpi_get_override_irq(int bus_irq, int *trigger, int *polarity);
  */
 void acpi_unregister_gsi (u32 gsi);
 
-#ifdef CONFIG_ACPI
-
 struct acpi_prt_entry {
 	struct list_head	node;
 	struct acpi_pci_id	id;
@@ -179,8 +167,6 @@ struct acpi_pci_driver {
 int acpi_pci_register_driver(struct acpi_pci_driver *driver);
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
-#endif /* CONFIG_ACPI */
-
 #ifdef CONFIG_ACPI_EC
 
 extern int ec_read(u8 addr, u8 *val);
-- 
1.5.4.23.gef5b9

