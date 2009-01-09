From: Len Brown <lenb@kernel.org>
Subject: [PATCH 78/94] ACPI: remove private acpica headers from driver files
Date: Fri, 09 Jan 2009 04:27:20 -0500
Message-ID: <ea7e96e0f2277107d9ea14c3f16c86ba82b2e560.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbZAIJ2r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:47 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EWS6BIQ6T2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:31 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

External driver files should not include any private acpica headers.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/include/asm/acpi-ext.h   |    1 -
 arch/ia64/include/asm/sn/acpi.h    |    2 --
 arch/ia64/sn/kernel/io_acpi_init.c |    1 -
 arch/ia64/sn/kernel/io_common.c    |    1 -
 drivers/acpi/cm_sbs.c              |    3 ---
 drivers/acpi/debug.c               |    1 -
 drivers/acpi/ec.c                  |    1 -
 drivers/acpi/numa.c                |    1 -
 drivers/acpi/sbshc.c               |    1 -
 drivers/acpi/scan.c                |    1 -
 drivers/acpi/sleep/wakeup.c        |    1 -
 drivers/ata/libata-acpi.c          |    6 ------
 drivers/ata/pata_acpi.c            |    6 ------
 drivers/char/tpm/tpm_bios.c        |    2 --
 drivers/ide/ide-acpi.c             |    6 ------
 drivers/misc/tc1100-wmi.c          |    1 -
 drivers/misc/thinkpad_acpi.c       |    1 -
 drivers/pci/hotplug/acpi_pcihp.c   |    1 -
 drivers/pci/hotplug/pciehp.h       |    1 -
 drivers/pci/pci-acpi.c             |    2 --
 drivers/pnp/pnpacpi/core.c         |    1 -
 include/linux/pci_hotplug.h        |    1 -
 22 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/ia64/include/asm/acpi-ext.h b/arch/ia64/include/asm/acpi-ext.h
index 734d137..7f8362b 100644
--- a/arch/ia64/include/asm/acpi-ext.h
+++ b/arch/ia64/include/asm/acpi-ext.h
@@ -14,7 +14,6 @@
 #define _ASM_IA64_ACPI_EXT_H
 
 #include <linux/types.h>
-#include <acpi/actypes.h>
 
 extern acpi_status hp_acpi_csr_space (acpi_handle, u64 *base, u64 *length);
 
diff --git a/arch/ia64/include/asm/sn/acpi.h b/arch/ia64/include/asm/sn/acpi.h
index 9ce2801..fd480db 100644
--- a/arch/ia64/include/asm/sn/acpi.h
+++ b/arch/ia64/include/asm/sn/acpi.h
@@ -9,8 +9,6 @@
 #ifndef _ASM_IA64_SN_ACPI_H
 #define _ASM_IA64_SN_ACPI_H
 
-#include "acpi/acglobal.h"
-
 extern int sn_acpi_rev;
 #define SN_ACPI_BASE_SUPPORT()   (sn_acpi_rev >= 0x20101)
 
diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 4c8bc8e..c5a2140 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -13,7 +13,6 @@
 #include <asm/sn/sn_sal.h>
 #include "xtalk/hubdev.h"
 #include <linux/acpi.h>
-#include <acpi/acnamesp.h>
 
 
 /*
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index e1917ed..0d4ffa4 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -26,7 +26,6 @@
 #include <linux/acpi.h>
 #include <asm/sn/sn2/sn_hwperf.h>
 #include <asm/sn/acpi.h>
-#include "acpi/acglobal.h"
 
 extern void sn_init_cpei_timer(void);
 extern void register_sn_procfs(void);
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 307963b..332fe4b 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -27,9 +27,6 @@
 #include <linux/seq_file.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/acmacros.h>
-#include <acpi/actypes.h>
-#include <acpi/acutils.h>
 
 ACPI_MODULE_NAME("cm_sbs");
 #define ACPI_AC_CLASS		"ac_adapter"
diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index c483968..20223cb 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -9,7 +9,6 @@
 #include <linux/moduleparam.h>
 #include <asm/uaccess.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/acglobal.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("debug");
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2cbc2c9..3105e04 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -42,7 +42,6 @@
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/actypes.h>
 
 #define ACPI_EC_CLASS			"embedded_controller"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 25ceae9..c5e292a 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -29,7 +29,6 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/acmacros.h>
 
 #define ACPI_NUMA	0x80000000
 #define _COMPONENT	ACPI_NUMA
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index e53e590..0619734 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -10,7 +10,6 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/actypes.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 39b7233..c54d7b6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -10,7 +10,6 @@
 #include <linux/kthread.h>
 
 #include <acpi/acpi_drivers.h>
-#include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("scan");
diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
index db325c2..2d34806 100644
--- a/drivers/acpi/sleep/wakeup.c
+++ b/drivers/acpi/sleep/wakeup.c
@@ -8,7 +8,6 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <acpi/acevents.h>
 #include "sleep.h"
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c012307..246987f 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -19,12 +19,6 @@
 #include "libata.h"
 
 #include <acpi/acpi_bus.h>
-#include <acpi/acnames.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
-#include <acpi/acexcep.h>
-#include <acpi/acmacros.h>
-#include <acpi/actypes.h>
 
 enum {
 	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index e2e332d..8b77a98 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -13,12 +13,6 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/acnames.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
-#include <acpi/acexcep.h>
-#include <acpi/acmacros.h>
-#include <acpi/actypes.h>
 
 #include <linux/libata.h>
 #include <linux/ata.h>
diff --git a/drivers/char/tpm/tpm_bios.c b/drivers/char/tpm/tpm_bios.c
index 68f052b..ed306eb 100644
--- a/drivers/char/tpm/tpm_bios.c
+++ b/drivers/char/tpm/tpm_bios.c
@@ -23,8 +23,6 @@
 #include <linux/security.h>
 #include <linux/module.h>
 #include <acpi/acpi.h>
-#include <acpi/actypes.h>
-#include <acpi/actbl.h>
 #include "tpm.h"
 
 #define TCG_EVENT_NAME_LEN_MAX	255
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 244a8a0..9e8d52a 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -18,12 +18,6 @@
 #include <linux/dmi.h>
 
 #include <acpi/acpi_bus.h>
-#include <acpi/acnames.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acparser.h>
-#include <acpi/acexcep.h>
-#include <acpi/acmacros.h>
-#include <acpi/actypes.h>
 
 #define REGS_PER_GTF		7
 struct taskfile_array {
diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
index f25e4c9..b4a4aa9 100644
--- a/drivers/misc/tc1100-wmi.c
+++ b/drivers/misc/tc1100-wmi.c
@@ -30,7 +30,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <acpi/acpi.h>
-#include <acpi/actypes.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/platform_device.h>
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 899766e..3478453 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -76,7 +76,6 @@
 #include <linux/workqueue.h>
 
 #include <acpi/acpi_drivers.h>
-#include <acpi/acnamesp.h>
 
 #include <linux/pci_ids.h>
 
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index e17ef54..2c981cb 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -33,7 +33,6 @@
 #include <linux/pci-acpi.h>
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/actypes.h>
 
 #define MY_NAME	"acpi_pcihp"
 
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index b2801a7..7072952 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -217,7 +217,6 @@ struct hpc_ops {
 #ifdef CONFIG_ACPI
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/actypes.h>
 #include <linux/pci-acpi.h>
 
 static inline int pciehp_get_hp_hw_control_from_firmware(struct pci_dev *dev)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ae5ec76..9d976d5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -13,8 +13,6 @@
 #include <linux/module.h>
 #include <linux/pci-aspm.h>
 #include <acpi/acpi.h>
-#include <acpi/acnamesp.h>
-#include <acpi/acresrc.h>
 #include <acpi/acpi_bus.h>
 
 #include <linux/pci-acpi.h>
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 383e47c..2834846 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -23,7 +23,6 @@
 #include <linux/pnp.h>
 #include <linux/mod_devicetable.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/actypes.h>
 
 #include "../base.h"
 #include "pnpacpi.h"
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index a00bd1a..c2d1a7d 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -223,7 +223,6 @@ struct hotplug_params {
 #ifdef CONFIG_ACPI
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
-#include <acpi/actypes.h>
 extern acpi_status acpi_get_hp_params_from_firmware(struct pci_bus *bus,
 				struct hotplug_params *hpp);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *dev, u32 flags);
-- 
1.5.6.6

