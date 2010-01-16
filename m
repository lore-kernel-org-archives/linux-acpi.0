From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/16] x86, ACPI: delete acpi_boot_table_init() return value
Date: Sat, 16 Jan 2010 02:32:54 -0500
Message-ID: <8558e3943df1c51c3377cb4e8a52ea484d6f357d.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50147 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0APHdY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:24 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB000QAWZB9A97@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:17 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

cleanup only.

setup_arch(), doesn't care care if ACPI initialization succeeded
or failed, so delete acpi_boot_table_init()'s return value.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/boot.c |   22 ++++++----------------
 include/linux/acpi.h        |    6 +++---
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index fb1035c..036d28a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1529,16 +1529,10 @@ static struct dmi_system_id __initdata acpi_dmi_table_late[] = {
  *	if acpi_blacklisted() acpi_disabled = 1;
  *	acpi_irq_model=...
  *	...
- *
- * return value: (currently ignored)
- *	0: success
- *	!0: failure
  */
 
-int __init acpi_boot_table_init(void)
+void __init acpi_boot_table_init(void)
 {
-	int error;
-
 	dmi_check_system(acpi_dmi_table);
 
 	/*
@@ -1546,15 +1540,14 @@ int __init acpi_boot_table_init(void)
 	 * One exception: acpi=ht continues far enough to enumerate LAPICs
 	 */
 	if (acpi_disabled && !acpi_ht)
-		return 1;
+		return; 
 
 	/*
 	 * Initialize the ACPI boot-time table parser.
 	 */
-	error = acpi_table_init();
-	if (error) {
+	if (acpi_table_init()) {
 		disable_acpi();
-		return error;
+		return;
 	}
 
 	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
@@ -1562,18 +1555,15 @@ int __init acpi_boot_table_init(void)
 	/*
 	 * blacklist may disable ACPI entirely
 	 */
-	error = acpi_blacklisted();
-	if (error) {
+	if (acpi_blacklisted()) {
 		if (acpi_force) {
 			printk(KERN_WARNING PREFIX "acpi=force override\n");
 		} else {
 			printk(KERN_WARNING PREFIX "Disabling ACPI support\n");
 			disable_acpi();
-			return error;
+			return;
 		}
 	}
-
-	return 0;
 }
 
 int __init early_acpi_boot_init(void)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3692425..b926afe 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -80,7 +80,7 @@ char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
-int acpi_boot_table_init (void);
+void acpi_boot_table_init (void);
 int acpi_mps_check (void);
 int acpi_numa_init (void);
 
@@ -321,9 +321,9 @@ static inline int acpi_boot_init(void)
 	return 0;
 }
 
-static inline int acpi_boot_table_init(void)
+static inline void acpi_boot_table_init(void)
 {
-	return 0;
+	return;
 }
 
 static inline int acpi_mps_check(void)
-- 
1.6.0.6

