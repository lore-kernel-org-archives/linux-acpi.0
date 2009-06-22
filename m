From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/9] ACPI: processor: move acpi_processor_start() after
	acpi_processor_add()
Date: Mon, 22 Jun 2009 14:41:14 -0600
Message-ID: <20090622204114.32761.85.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:1993 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZFVUlL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:11 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Move acpi_processor_start() to just after acpi_processor_add().
A subsequent patch will merge them.

Code movement only; no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |  168 +++++++++++++++++++++--------------------
 1 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7f082b6..393695f 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -689,6 +689,90 @@ static int acpi_processor_get_info(struct acpi_device *device)
 
 static DEFINE_PER_CPU(void *, processor_device_array);
 
+static void acpi_processor_notify(struct acpi_device *device, u32 event)
+{
+	struct acpi_processor *pr = acpi_driver_data(device);
+	int saved;
+
+	if (!pr)
+		return;
+
+	switch (event) {
+	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
+		saved = pr->performance_platform_limit;
+		acpi_processor_ppc_has_changed(pr);
+		if (saved == pr->performance_platform_limit)
+			break;
+		acpi_bus_generate_proc_event(device, event,
+					pr->performance_platform_limit);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event,
+						  pr->performance_platform_limit);
+		break;
+	case ACPI_PROCESSOR_NOTIFY_POWER:
+		acpi_processor_cst_has_changed(pr);
+		acpi_bus_generate_proc_event(device, event, 0);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event, 0);
+		break;
+	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
+		acpi_processor_tstate_has_changed(pr);
+		acpi_bus_generate_proc_event(device, event, 0);
+		acpi_bus_generate_netlink_event(device->pnp.device_class,
+						  dev_name(&device->dev), event, 0);
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	return;
+}
+
+static int acpi_cpu_soft_notify(struct notifier_block *nfb,
+		unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (action == CPU_ONLINE && pr) {
+		acpi_processor_ppc_has_changed(pr);
+		acpi_processor_cst_has_changed(pr);
+		acpi_processor_tstate_has_changed(pr);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block acpi_cpu_notifier =
+{
+	    .notifier_call = acpi_cpu_soft_notify,
+};
+
+static int acpi_processor_add(struct acpi_device *device)
+{
+	struct acpi_processor *pr = NULL;
+
+
+	if (!device)
+		return -EINVAL;
+
+	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
+	if (!pr)
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&pr->throttling.shared_cpu_map, GFP_KERNEL)) {
+		kfree(pr);
+		return -ENOMEM;
+	}
+
+	pr->handle = device->handle;
+	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
+	device->driver_data = pr;
+
+	return 0;
+}
+
 static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
@@ -790,90 +874,6 @@ err_remove_fs:
 	return result;
 }
 
-static void acpi_processor_notify(struct acpi_device *device, u32 event)
-{
-	struct acpi_processor *pr = acpi_driver_data(device);
-	int saved;
-
-	if (!pr)
-		return;
-
-	switch (event) {
-	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
-		saved = pr->performance_platform_limit;
-		acpi_processor_ppc_has_changed(pr);
-		if (saved == pr->performance_platform_limit)
-			break;
-		acpi_bus_generate_proc_event(device, event,
-					pr->performance_platform_limit);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  pr->performance_platform_limit);
-		break;
-	case ACPI_PROCESSOR_NOTIFY_POWER:
-		acpi_processor_cst_has_changed(pr);
-		acpi_bus_generate_proc_event(device, event, 0);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
-		break;
-	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
-		acpi_processor_tstate_has_changed(pr);
-		acpi_bus_generate_proc_event(device, event, 0);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event, 0);
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
-		break;
-	}
-
-	return;
-}
-
-static int acpi_cpu_soft_notify(struct notifier_block *nfb,
-		unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (unsigned long)hcpu;
-	struct acpi_processor *pr = per_cpu(processors, cpu);
-
-	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr);
-		acpi_processor_cst_has_changed(pr);
-		acpi_processor_tstate_has_changed(pr);
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block acpi_cpu_notifier =
-{
-	    .notifier_call = acpi_cpu_soft_notify,
-};
-
-static int acpi_processor_add(struct acpi_device *device)
-{
-	struct acpi_processor *pr = NULL;
-
-
-	if (!device)
-		return -EINVAL;
-
-	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
-	if (!pr)
-		return -ENOMEM;
-
-	if (!zalloc_cpumask_var(&pr->throttling.shared_cpu_map, GFP_KERNEL)) {
-		kfree(pr);
-		return -ENOMEM;
-	}
-
-	pr->handle = device->handle;
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
-	device->driver_data = pr;
-
-	return 0;
-}
-
 static int acpi_processor_remove(struct acpi_device *device, int type)
 {
 	struct acpi_processor *pr = NULL;

