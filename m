From: Len Brown <lenb@kernel.org>
Subject: [PATCH 91/94] ACPI : Use RSDT instead of XSDT by adding boot option of
 "acpi=rsdt"
Date: Fri, 09 Jan 2009 04:27:33 -0500
Message-ID: <237889bf0a62f1399fb2ba0c2a259e6a96597131.1231492614.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44602 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbZAIJ2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7004SZ6BT2R3D@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:42 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

On some boxes there exist both RSDT and XSDT table. But unfortunately
sometimes there exists the following error when XSDT table is used:
   a. 32/64X address mismatch
   b. The 32/64X FACS address mismatch

   In such case the boot option of "acpi=rsdt" is provided so that
RSDT is tried instead of XSDT table when the system can't work well.

http://bugzilla.kernel.org/show_bug.cgi?id=8246

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc:Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    1 +
 arch/ia64/kernel/acpi.c             |    1 +
 arch/x86/kernel/acpi/boot.c         |    6 +++++-
 drivers/acpi/tables/tbutils.c       |    3 ++-
 include/acpi/acpixf.h               |    1 +
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c9115c1..136f028 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -139,6 +139,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			ht -- run only enough ACPI to enable Hyper Threading
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
+			rsdt -- prefer RSDT over (default) XSDT
 
 			See also Documentation/power/pm.txt, pci=noacpi
 
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index bd7acc7..c19b686 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off) (void);
 EXPORT_SYMBOL(pm_power_off);
 
+u32 acpi_rsdt_forced;
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4c51a2f..db1a90a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -47,7 +47,7 @@
 #endif
 
 static int __initdata acpi_force = 0;
-
+u32 acpi_rsdt_forced;
 #ifdef	CONFIG_ACPI
 int acpi_disabled = 0;
 #else
@@ -1783,6 +1783,10 @@ static int __init parse_acpi(char *arg)
 			disable_acpi();
 		acpi_ht = 1;
 	}
+	/* acpi=rsdt use RSDT instead of XSDT */
+	else if (strcmp(arg, "rsdt") == 0) {
+		acpi_rsdt_forced = 1;
+	}
 	/* "acpi=noirq" disables ACPI interrupt routing */
 	else if (strcmp(arg, "noirq") == 0) {
 		acpi_noirq_set();
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 0cc92ef..da9f240 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -420,7 +420,8 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 
 	/* Differentiate between RSDT and XSDT root tables */
 
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
+			&& !acpi_rsdt_forced) {
 		/*
 		 * Root table is an XSDT (64-bit physical addresses). We must use the
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 33bc0e3..05d2614 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -48,6 +48,7 @@
 #include "actypes.h"
 #include "actbl.h"
 
+extern u32 acpi_rsdt_forced;
 /*
  * Global interfaces
  */
-- 
1.5.6.6

