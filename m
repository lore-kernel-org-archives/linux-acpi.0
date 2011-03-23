From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/42] ACPI: use __init where possible in processor driver
Date: Wed, 23 Mar 2011 02:42:40 -0400
Message-ID: <6430c9c12a7dbb8f60f0d8294b73b3c0bb03f64f.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab1CWIHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:35 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:33 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jan Beulich <JBeulich@novell.com>, Jan Beulich <jbeulich@novell.com>, Len Brown <len.brown@intel.com>

From: Jan Beulich <JBeulich@novell.com>

Use __init for several functions, remove an unnecessary export and a
stray use of __ref.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c   |    9 ++++-----
 drivers/acpi/processor_driver.c |    4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 3c1a2fe..ac77dde 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -19,7 +19,7 @@
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_core");
 
-static int set_no_mwait(const struct dmi_system_id *id)
+static int __init set_no_mwait(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE PREFIX "%s detected - "
 		"disabling mwait for CPU C-states\n", id->ident);
@@ -27,7 +27,7 @@ static int set_no_mwait(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
+static struct dmi_system_id __initdata processor_idle_dmi_table[] = {
 	{
 	set_no_mwait, "Extensa 5220", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
@@ -183,7 +183,7 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 #endif
 
-static bool processor_physically_present(acpi_handle handle)
+static bool __init processor_physically_present(acpi_handle handle)
 {
 	int cpuid, type;
 	u32 acpi_id;
@@ -323,9 +323,8 @@ void acpi_processor_set_pdc(acpi_handle handle)
 	kfree(obj_list->pointer);
 	kfree(obj_list);
 }
-EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 
-static acpi_status
+static acpi_status __init
 early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	if (processor_physically_present(handle) == false)
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 360a74e..a4e0f1b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -635,8 +635,8 @@ int acpi_processor_device_add(acpi_handle handle, struct acpi_device **device)
 	return 0;
 }
 
-static void __ref acpi_processor_hotplug_notify(acpi_handle handle,
-						u32 event, void *data)
+static void acpi_processor_hotplug_notify(acpi_handle handle,
+					  u32 event, void *data)
 {
 	struct acpi_processor *pr;
 	struct acpi_device *device = NULL;
-- 
1.7.4.1.343.ga91df

