From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ACPI: Cleanup <linux/acpi.h>
Date: Wed, 7 Nov 2007 14:20:56 +0100
Message-ID: <200711071420.56688.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59674 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbXKGNTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2007 08:19:14 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>

Two cleanups to <linux/acpi.h>:
* Stop defining acpi_mp_config, it isn't used anywhere.
* Discard nested "#ifdef CONFIG_ACPI", they are useless and
  error-prone.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Len, Andrew, this cleanup should go before the patches sent by
Thomas Renninger. I'll send updated patches in a moment so that
we no longer break the build for CONFIG_ACPI=n.

 include/linux/acpi.h |   14 --------------
 1 file changed, 14 deletions(-)

--- linux-2.6.24-rc2.orig/include/linux/acpi.h	2007-11-07 13:22:12.000000000 +0100
+++ linux-2.6.24-rc2/include/linux/acpi.h	2007-11-07 14:09:30.000000000 +0100
@@ -42,8 +42,6 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI
-
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
@@ -115,20 +113,12 @@ int acpi_unmap_lsapic(int cpu);
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
 
@@ -139,8 +129,6 @@ int acpi_gsi_to_irq (u32 gsi, unsigned i
  */
 void acpi_unregister_gsi (u32 gsi);
 
-#ifdef CONFIG_ACPI
-
 struct acpi_prt_entry {
 	struct list_head	node;
 	struct acpi_pci_id	id;
@@ -173,8 +161,6 @@ struct acpi_pci_driver {
 int acpi_pci_register_driver(struct acpi_pci_driver *driver);
 void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
-#endif /* CONFIG_ACPI */
-
 #ifdef CONFIG_ACPI_EC
 
 extern int ec_read(u8 addr, u8 *val);

-- 
Jean Delvare
Suse L3
