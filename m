From: Len Brown <lenb@kernel.org>
Subject: [PATCH 127/140] ACPICA: reduce conflicts with Altix patch series
Date: Wed,  7 Feb 2007 13:52:21 -0500
Message-ID: <11708745443731-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <647fb47dfabeffd2f1706013ebf5cfc92b70d273.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:10552 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422828AbXBGSzs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:48 -0500
In-Reply-To: <11708745433849-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Syntax only -- no functional changes.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/io_common.c |   18 ++++++++++++------
 arch/ia64/sn/kernel/iomv.c      |    5 ++---
 include/asm-ia64/sn/acpi.h      |   18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 include/asm-ia64/sn/acpi.h

diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 65979f1..75f0379 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -25,6 +25,7 @@
 #include "xtalk/xwidgetdev.h"
 #include <linux/acpi.h>
 #include <asm/sn/sn2/sn_hwperf.h>
+#include <asm/sn/acpi.h>
 
 extern void sn_init_cpei_timer(void);
 extern void register_sn_procfs(void);
@@ -36,6 +37,7 @@ extern void sn_legacy_pci_window_fixup(struct pci_controller *, u64, u64);
 extern void sn_io_acpi_init(void);
 extern void sn_io_init(void);
 
+
 static struct list_head sn_sysdata_list;
 
 /* sysdata list struct */
@@ -48,7 +50,7 @@ int sn_ioif_inited;		/* SN I/O infrastructure initialized? */
 
 struct sn_pcibus_provider *sn_pci_provider[PCIIO_ASIC_MAX_TYPES];	/* indexed by asic type */
 
-int sn_acpi_base_support()
+int sn_acpi_base_support(void)
 {
 	struct acpi_table_header *header;
 	(void)acpi_get_table_by_index(ACPI_TABLE_INDEX_DSDT, &header);
@@ -293,7 +295,7 @@ void sn_pci_fixup_slot(struct pci_dev *dev)
 	list_add_tail(&pcidev_info->pdi_list,
 		      &(SN_PLATFORM_DATA(dev->bus)->pcidev_info));
 
-	if (sn_acpi_base_support())
+	if (SN_ACPI_BASE_SUPPORT())
 		sn_acpi_slot_fixup(dev, pcidev_info);
 	else
 		sn_more_slot_fixup(dev, pcidev_info);
@@ -505,7 +507,7 @@ void __devinit
 sn_pci_fixup_bus(struct pci_bus *bus)
 {
 
-	if (sn_acpi_base_support())
+	if (SN_ACPI_BASE_SUPPORT())
 		sn_acpi_bus_fixup(bus);
 	else
 		sn_bus_fixup(bus);
@@ -551,9 +553,13 @@ sn_io_early_init(void)
 	register_sn_procfs();
 #endif
 
-	printk(KERN_INFO "ACPI  DSDT OEM Rev 0x%x\n",
-	       acpi_gbl_DSDT->oem_revision);
-	if (sn_acpi_base_support())
+	{
+		struct acpi_table_header *header;
+		(void)acpi_get_table_by_index(ACPI_TABLE_INDEX_DSDT, &header);
+		printk(KERN_INFO "ACPI  DSDT OEM Rev 0x%x\n",
+			header->oem_revision);
+	}
+	if (SN_ACPI_BASE_SUPPORT())
 		sn_io_acpi_init();
 	else
 		sn_io_init();
diff --git a/arch/ia64/sn/kernel/iomv.c b/arch/ia64/sn/kernel/iomv.c
index b1a47da..ab7e2fd 100644
--- a/arch/ia64/sn/kernel/iomv.c
+++ b/arch/ia64/sn/kernel/iomv.c
@@ -16,6 +16,7 @@
 #include <asm/sn/pda.h>
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/shub_mmr.h>
+#include <asm/sn/acpi.h>
 
 #define IS_LEGACY_VGA_IOPORT(p) \
 	(((p) >= 0x3b0 && (p) <= 0x3bb) || ((p) >= 0x3c0 && (p) <= 0x3df))
@@ -29,8 +30,6 @@
  * SN i/o address.  Used by sn_in*() and sn_out*().
  */
 
-extern int sn_acpi_base_support();
-
 void *sn_io_addr(unsigned long port)
 {
 	if (!IS_RUNNING_ON_SIMULATOR()) {
@@ -39,7 +38,7 @@ void *sn_io_addr(unsigned long port)
 		/* On sn2, legacy I/O ports don't point at anything */
 		if (port < (64 * 1024))
 			return NULL;
-		if (sn_acpi_base_support())
+		if (SN_ACPI_BASE_SUPPORT())
 			return (__ia64_mk_io_addr(port));
 		else
 			return ((void *)(port | __IA64_UNCACHED_OFFSET));
diff --git a/include/asm-ia64/sn/acpi.h b/include/asm-ia64/sn/acpi.h
new file mode 100644
index 0000000..7d6cb3b
--- /dev/null
+++ b/include/asm-ia64/sn/acpi.h
@@ -0,0 +1,18 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#ifndef _ASM_IA64_SN_ACPI_H
+#define _ASM_IA64_SN_ACPI_H
+
+#include "acpi/acglobal.h"
+
+#define SN_ACPI_BASE_SUPPORT()   sn_acpi_base_support()
+
+extern int sn_acpi_base_support(void);
+
+#endif /* _ASM_IA64_SN_ACPI_H */
-- 
1.5.0.rc3.39.gec804
