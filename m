From: Christian Hofstaedtler <ch@zeha.at>
Subject: [PATCH] Default to ACPI reboots on newish X86 hardware
Date: Thu,  7 Jan 2010 21:03:13 +0100
Message-ID: <1262894593-25563-1-git-send-email-ch@zeha.at>
References: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from percival.namespace.at ([77.244.242.130]:33730 "EHLO
	percival.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0AGUEM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2010 15:04:12 -0500
In-Reply-To: <alpine.LFD.2.00.1001061433260.4086@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, lenb@kernel.org, tglx@linutronix.de, linux-acpi@vger.kernel.org, venkatesh.pallipadi@intel.com, arjan@infradead.org, bruce.w.allan@intel.com, Christian Hofstaedtler <ch@zeha.at>

Newer hardware is assumed to no longer reboot succesfully using the
keyboard controller, but needs to use ACPI instead.
To not cause problems with older hardware, only hardware with a BIOS
date 2006 or newer is considered for this choice. Broken BIOSes
reporting a BIOS date of 0 are not specially considered, and therefore
get the KBD reboot behaviour.

Also unifiy reboot_type selection code.

Signed-off-by: Christian Hofstaedtler <ch@zeha.at>
---
 arch/x86/include/asm/emergency-restart.h |    1 +
 arch/x86/kernel/reboot.c                 |   65 ++++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/emergency-restart.h b/arch/x86/include/asm/emergency-restart.h
index cc70c1c..72ee23a 100644
--- a/arch/x86/include/asm/emergency-restart.h
+++ b/arch/x86/include/asm/emergency-restart.h
@@ -2,6 +2,7 @@
 #define _ASM_X86_EMERGENCY_RESTART_H
 
 enum reboot_type {
+	BOOT_UNDECIDED = '?',
 	BOOT_TRIPLE = 't',
 	BOOT_KBD = 'k',
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 1545bc0..5e78483 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 static const struct desc_ptr no_idt = {};
 static int reboot_mode;
-enum reboot_type reboot_type = BOOT_KBD;
+enum reboot_type reboot_type = BOOT_UNDECIDED;
 int reboot_force;
 
 #if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
@@ -134,7 +134,11 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id __initdata reboot_dmi_table[] = {
+/*
+ * This table only gets used on x86_32, so only use with
+ * set_bios_reboot.
+ */
+static struct dmi_system_id __initdata reboot_dmi_table_x86_32[] = {
 	{	/* Handle problems with rebooting on Dell E520's */
 		.callback = set_bios_reboot,
 		.ident = "Dell E520",
@@ -270,13 +274,6 @@ static struct dmi_system_id __initdata reboot_dmi_table[] = {
 	{ }
 };
 
-static int __init reboot_init(void)
-{
-	dmi_check_system(reboot_dmi_table);
-	return 0;
-}
-core_initcall(reboot_init);
-
 /* The following code and data reboots the machine by switching to real
    mode and jumping to the BIOS reset entry point, as if the CPU has
    really been reset.  The previous version asked the keyboard
@@ -427,7 +424,8 @@ static int __init set_pci_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
-static struct dmi_system_id __initdata pci_reboot_dmi_table[] = {
+/* This table gets used on x86_32 AND x86_64. */
+static struct dmi_system_id __initdata reboot_dmi_table_all[] = {
 	{	/* Handle problems with rebooting on Apple MacBook5 */
 		.callback = set_pci_reboot,
 		.ident = "Apple MacBook5",
@@ -455,12 +453,53 @@ static struct dmi_system_id __initdata pci_reboot_dmi_table[] = {
 	{ }
 };
 
-static int __init pci_reboot_init(void)
+/* See if the Hardware is new enough to support ACPI reboots. */
+static int __init reboot_acpi_likey_supported(void)
+{
+        int year;
+
+	/* Doesn't exist? Likely an old system */
+	if (!dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL)) {
+		return 0;
+	}
+        /* 2006 was decided as the cut-off year. */
+	if (year < 2006) {
+		return 0;
+	}
+	return 1;
+}
+
+/* Decide how we will reboot:
+ * - Check the X86_32-only quirks table.
+ * - Check the generic quirks table.
+ * - Check if we could use ACPI-based reboot.
+ * - Fall back to old-style Keyboard Controller reboot.
+ *
+ * In any case, don't override user decisions. (reboot=...)
+ */
+static int __init reboot_init(void)
 {
-	dmi_check_system(pci_reboot_dmi_table);
+	if (reboot_type != BOOT_UNDECIDED)
+		return 0;
+
+#ifdef CONFIG_X86_32
+	dmi_check_system(reboot_dmi_table_x86_32);
+#endif /* CONFIG_X86_32 */
+	dmi_check_system(reboot_dmi_table_all);
+
+	if (reboot_type != BOOT_UNDECIDED)
+		return 0;
+
+	if (reboot_acpi_likey_supported()) {
+		reboot_type = BOOT_ACPI;
+	} else {
+		printk(KERN_INFO "Selecting old-style reboot for older hardware\n");
+		reboot_type = BOOT_KBD;
+	}
+
 	return 0;
 }
-core_initcall(pci_reboot_init);
+core_initcall(reboot_init);
 
 static inline void kb_wait(void)
 {
-- 
1.6.4.4

