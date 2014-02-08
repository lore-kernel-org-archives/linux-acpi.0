From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 1/3] ACPI / idle: Make idle_boot_override depend on x86 and ia64
Date: Sat,  8 Feb 2014 21:10:16 +0800
Message-ID: <1391865018-3446-2-git-send-email-hanjun.guo@linaro.org>
References: <1391865018-3446-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391865018-3446-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

idle_boot_override depends on x86 and ia64 now, and we can not
foresee it will be used on ARM or ARM64,so move the code into
CONFIG_X86 and CONFIG_IA64 #ifdefs to make processor_core.c
can be compiled on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |   40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 46583d7..01b2656 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -19,24 +19,6 @@
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_core");
 
-static int __init set_no_mwait(const struct dmi_system_id *id)
-{
-	printk(KERN_NOTICE PREFIX "%s detected - "
-		"disabling mwait for CPU C-states\n", id->ident);
-	boot_option_idle_override = IDLE_NOMWAIT;
-	return 0;
-}
-
-static struct dmi_system_id processor_idle_dmi_table[] __initdata = {
-	{
-	set_no_mwait, "Extensa 5220", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
-	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
-	{},
-};
-
 static int map_lapic_id(struct acpi_subtable_header *entry,
 		 u32 acpi_id, int *apic_id)
 {
@@ -379,13 +361,35 @@ early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
+static int __init set_no_mwait(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"disabling mwait for CPU C-states\n", id->ident);
+	boot_option_idle_override = IDLE_NOMWAIT;
+	return 0;
+}
+
+static struct dmi_system_id processor_idle_dmi_table[] __initdata = {
+	{
+	set_no_mwait, "Extensa 5220", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
+	{},
+};
+#endif
+
 void __init acpi_early_processor_set_pdc(void)
 {
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
 	/*
 	 * Check whether the system is DMI table. If yes, OSPM
 	 * should not use mwait for CPU-states.
 	 */
 	dmi_check_system(processor_idle_dmi_table);
+#endif
 
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-- 
1.7.9.5
