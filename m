From: akpm@osdl.org
Subject: [patch 12/13] Fix HPET operation on 64-bit NVIDIA platforms
Date: Thu, 01 Jun 2006 20:18:52 -0700
Message-ID: <200606020314.k523EXuI028340@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:19121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751184AbWFBDOk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 23:14:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ACurrid@nvidia.com, acurrid@nvidia.com, ak@muc.de, luming.yu@intel.com


From: "Andy Currid" <ACurrid@nvidia.com>

This patch fixes a kernel panic during boot that occurs on NVIDIA platforms
that have HPET enabled.

When HPET is enabled, the standard timer IRQ is routed to IOAPIC pin 2 and is
advertised as such in the ACPI APIC table - but an earlier workaround in the
kernel was ignoring this override.  The fix is to honor timer IRQ overrides
from ACPI when HPET is detected on an NVIDIA platform.

Signed-off-by: Andy Currid <acurrid@nvidia.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/io_apic.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/kernel/io_apic.c~fix-hpet-operation-on-64-bit-nvidia-platforms arch/x86_64/kernel/io_apic.c
--- devel/arch/x86_64/kernel/io_apic.c~fix-hpet-operation-on-64-bit-nvidia-platforms	2006-06-01 20:17:10.000000000 -0700
+++ devel-akpm/arch/x86_64/kernel/io_apic.c	2006-06-01 20:17:10.000000000 -0700
@@ -271,6 +271,18 @@ __setup("enable_8254_timer", setup_enabl
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
 
+
+#ifdef CONFIG_ACPI
+
+static int nvidia_hpet_detected __initdata;
+
+static int __init nvidia_hpet_check(unsigned long phys, unsigned long size)
+{
+	nvidia_hpet_detected = 1;
+	return 0;
+}
+#endif
+
 /* Temporary Hack. Nvidia and VIA boards currently only work with IO-APIC
    off. Check for an Nvidia or VIA PCI bridge and turn it off.
    Use pci direct infrastructure because this runs before the PCI subsystem. 
@@ -317,11 +329,19 @@ void __init check_ioapic(void) 
 					return;
 				case PCI_VENDOR_ID_NVIDIA:
 #ifdef CONFIG_ACPI
-					/* All timer overrides on Nvidia
-				           seem to be wrong. Skip them. */
-					acpi_skip_timer_override = 1;
-					printk(KERN_INFO 
-	     "Nvidia board detected. Ignoring ACPI timer override.\n");
+					/*
+					 * All timer overrides on Nvidia are
+					 * wrong unless HPET is enabled.
+					 */
+					nvidia_hpet_detected = 0;
+					acpi_table_parse(ACPI_HPET,
+							nvidia_hpet_check);
+					if (nvidia_hpet_detected == 0) {
+						acpi_skip_timer_override = 1;
+						printk(KERN_INFO "Nvidia board "
+						    "detected. Ignoring ACPI "
+						    "timer override.\n");
+					}
 #endif
 					/* RED-PEN skip them on mptables too? */
 					return;
_
