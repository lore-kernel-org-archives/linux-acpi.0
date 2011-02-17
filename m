From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH 1/2] acpi: use __init where possible in processor
	 driver
Date: Thu, 17 Feb 2011 16:33:53 +0000
Message-ID: <4D5D5C0102000078000327AE@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Use __init for several functions, remove an unnecessary export and a
stray use of __ref.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/processor_core.c   |    9 ++++-----
 drivers/acpi/processor_driver.c |    4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

--- 2.6.38-rc5/drivers/acpi/processor_core.c
+++ 2.6.38-rc5-acpi-processor-misc/drivers/acpi/processor_core.c
@@ -19,7 +19,7 @@
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_core");
 
-static int set_no_mwait(const struct dmi_system_id *id)
+static int __init set_no_mwait(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE PREFIX "%s detected - "
 		"disabling mwait for CPU C-states\n", id->ident);
@@ -27,7 +27,7 @@ static int set_no_mwait(const struct dmi
 	return 0;
 }
 
-static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
+static struct dmi_system_id __initdata processor_idle_dmi_table[] = {
 	{
 	set_no_mwait, "Extensa 5220", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
@@ -183,7 +183,7 @@ int acpi_get_cpuid(acpi_handle handle, i
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 #endif
 
-static bool processor_physically_present(acpi_handle handle)
+static bool __init processor_physically_present(acpi_handle handle)
 {
 	int cpuid, type;
 	u32 acpi_id;
@@ -323,9 +323,8 @@ void acpi_processor_set_pdc(acpi_handle 
 	kfree(obj_list->pointer);
 	kfree(obj_list);
 }
-EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 
-static acpi_status
+static acpi_status __init
 early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	if (processor_physically_present(handle) == false)
--- 2.6.38-rc5/drivers/acpi/processor_driver.c
+++ 2.6.38-rc5-acpi-processor-misc/drivers/acpi/processor_driver.c
@@ -635,8 +635,8 @@ int acpi_processor_device_add(acpi_handl
 	return 0;
 }
 
-static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
-						u32 event, void *data)
+static void acpi_processor_hotplug_notify(acpi_handle handle,
+					  u32 event, void *data)
 {
 	struct acpi_processor *pr;
 	struct acpi_device *device = NULL;



