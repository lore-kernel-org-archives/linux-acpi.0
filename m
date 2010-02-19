From: Len Brown <lenb@kernel.org>
Subject: [patch 2/2] ACPI: delete the "acpi=ht" boot option
Date: Fri, 19 Feb 2010 00:55:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190053520.17638@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
 <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
 <20100217183108.GA23189@srcf.ucam.org>
 <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
 <20100217212851.GA27092@srcf.ucam.org>
 <alpine.LFD.2.00.1002190028510.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:54203 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0BSFzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 00:55:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200EW6R42MAP1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 23:55:15 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.1002190028510.17638@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, "Rafael J. Wysocki" <rjw@sisk.pl>

From: Len Brown <len.brown@intel.com>

acpi=ht was important in 2003 -- before ACPI was
universally deployed and enabled by default in
the major Linux distributions.

At that time, there were a fair number of people who
or chose to, or needed to, run with acpi=off,
yet also wanted access to Hyper-threading.

Today we find that many invocations of "acpi=ht"
are accidental, and thus is it possible that it
is doing more harm than good.

The implementation of acpi=ht is a hack --
lets see if we can delete it.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    3 +--
 arch/ia64/include/asm/acpi.h        |    1 -
 arch/x86/include/asm/acpi.h         |    2 --
 arch/x86/kernel/acpi/boot.c         |   17 +++--------------
 arch/x86/lguest/boot.c              |    1 -
 drivers/acpi/tables.c               |    4 ++--
 6 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 826b6e1..a76ca84 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -142,11 +142,10 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	acpi=		[HW,ACPI,X86]
 			Advanced Configuration and Power Interface
-			Format: { force | off | ht | strict | noirq | rsdt }
+			Format: { force | off | strict | noirq | rsdt }
 			force -- enable ACPI if default was off
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
-			ht -- run only enough ACPI to enable Hyper Threading
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index e97b255..7ae5889 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -94,7 +94,6 @@ ia64_acpi_release_global_lock (unsigned int *lock)
 #define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
-#define acpi_ht 0	/* no HT-only mode on IA64 */
 #endif
 #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
 static inline void disable_acpi(void) { }
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 56f462c..aa2c39d 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -85,7 +85,6 @@ extern int acpi_ioapic;
 extern int acpi_noirq;
 extern int acpi_strict;
 extern int acpi_disabled;
-extern int acpi_ht;
 extern int acpi_pci_disabled;
 extern int acpi_skip_timer_override;
 extern int acpi_use_timer_override;
@@ -97,7 +96,6 @@ void acpi_pic_sci_set_trigger(unsigned int, u16);
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-	acpi_ht = 0;
 	acpi_pci_disabled = 1;
 	acpi_noirq = 1;
 }
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index cba0311..97229f3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -60,7 +60,6 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_noirq;				/* skip ACPI IRQ initialization */
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
-int acpi_ht __initdata = 1;	/* enable HT */
 
 int acpi_lapic;
 int acpi_ioapic;
@@ -1431,9 +1430,8 @@ void __init acpi_boot_table_init(void)
 
 	/*
 	 * If acpi_disabled, bail out
-	 * One exception: acpi=ht continues far enough to enumerate LAPICs
 	 */
-	if (acpi_disabled && !acpi_ht)
+	if (acpi_disabled)
 		return; 
 
 	/*
@@ -1464,9 +1462,8 @@ int __init early_acpi_boot_init(void)
 {
 	/*
 	 * If acpi_disabled, bail out
-	 * One exception: acpi=ht continues far enough to enumerate LAPICs
 	 */
-	if (acpi_disabled && !acpi_ht)
+	if (acpi_disabled)
 		return 1;
 
 	/*
@@ -1484,9 +1481,8 @@ int __init acpi_boot_init(void)
 
 	/*
 	 * If acpi_disabled, bail out
-	 * One exception: acpi=ht continues far enough to enumerate LAPICs
 	 */
-	if (acpi_disabled && !acpi_ht)
+	if (acpi_disabled)
 		return 1;
 
 	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
@@ -1518,19 +1514,12 @@ static int __init parse_acpi(char *arg)
 	/* acpi=force to over-ride black-list */
 	else if (strcmp(arg, "force") == 0) {
 		acpi_force = 1;
-		acpi_ht = 1;
 		acpi_disabled = 0;
 	}
 	/* acpi=strict disables out-of-spec workarounds */
 	else if (strcmp(arg, "strict") == 0) {
 		acpi_strict = 1;
 	}
-	/* Limit ACPI just to boot-time to enable HT */
-	else if (strcmp(arg, "ht") == 0) {
-		if (!acpi_force)
-			disable_acpi();
-		acpi_ht = 1;
-	}
 	/* acpi=rsdt use RSDT instead of XSDT */
 	else if (strcmp(arg, "rsdt") == 0) {
 		acpi_rsdt_forced = 1;
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index 7e59dc1..8eb9eed 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1391,7 +1391,6 @@ __init void lguest_init(void)
 #endif
 #ifdef CONFIG_ACPI
 	acpi_disabled = 1;
-	acpi_ht = 0;
 #endif
 
 	/*
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8a0ed28..f336bca 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -213,7 +213,7 @@ acpi_table_parse_entries(char *id,
 	unsigned long table_end;
 	acpi_size tbl_size;
 
-	if (acpi_disabled && !acpi_ht)
+	if (acpi_disabled)
 		return -ENODEV;
 
 	if (!handler)
@@ -280,7 +280,7 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
 
-	if (acpi_disabled && !acpi_ht)
+	if (acpi_disabled)
 		return -ENODEV;
 
 	if (!handler)
-- 
1.7.0.17.g7e5eb


