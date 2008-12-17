From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of
	"acpi=rsdt"
Date: Wed, 17 Dec 2008 16:55:18 +0800
Message-ID: <1229504118.3991.63.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18987 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbYLQIqT (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 17 Dec 2008 03:46:19 -0500
In-Reply-To: <20081031184233.8588.42241.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, trenn@suse.de

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
---
 Documentation/kernel-parameters.txt |    2 ++
 arch/ia64/kernel/acpi.c             |    1 +
 arch/x86/kernel/acpi/boot.c         |    6 +++++-
 drivers/acpi/tables/tbutils.c       |    3 ++-
 include/acpi/acpixf.h               |    1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
+++ linux-2.6/arch/x86/kernel/acpi/boot.c
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
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -48,6 +48,7 @@
 #include "actypes.h"
 #include "actbl.h"
 
+extern u32 acpi_rsdt_forced;
 /*
  * Global interfaces
  */
Index: linux-2.6/drivers/acpi/tables/tbutils.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbutils.c
+++ linux-2.6/drivers/acpi/tables/tbutils.c
@@ -420,7 +420,8 @@ acpi_tb_parse_root_table(acpi_physical_a
 
 	/* Differentiate between RSDT and XSDT root tables */
 
-	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
+	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
+			&& !acpi_rsdt_forced) {
 		/*
 		 * Root table is an XSDT (64-bit physical addresses). We must use the
 		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
Index: linux-2.6/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6/arch/ia64/kernel/acpi.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off) (void);
 EXPORT_SYMBOL(pm_power_off);
 
+u32 acpi_rsdt_forced;
 unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -139,6 +139,8 @@ and is between 256 and 4096 characters. 
 			ht -- run only enough ACPI to enable Hyper Threading
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
+			rsdt -- RSDT is used instead of XSDT table when both
+				exits.
 
 			See also Documentation/power/pm.txt, pci=noacpi
 


