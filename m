From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/5] ACPI processor hotplug: Delay most initialization to cpu online
Date: Mon, 12 Sep 2011 01:42:31 +0200
Message-ID: <1315784551-39118-6-git-send-email-trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48670 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab1IKXmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 19:42:44 -0400
In-Reply-To: <1315784551-39118-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

When the CPU hotplug notification comes in via ACPI notify()
cpu_data of the core is not yet initialized (the core did never
get booted and set up).
This leads to errors in throttling and (if acpi_idle is used
as cpuidle driver) to not set up cpu idle subsystem.
-> Only bring up ACPI sysfs at that time
-> Initialize the rest (throttling, cpuidle,...) when a hotplugged
core is onlined the first time

Sidenote:
When starting on this, Xen patches were applied on the code base
I worked on. I later realized that changing:
static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
to only passing the processor object:
static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
came from Xen patches, but is convenient to have for physical cpu hotplugging
and took that over.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |   75 +++++++++++++++++++++++++++++---------
 include/acpi/processor.h        |    1 +
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 546951a..16f26b8 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -82,9 +82,9 @@ MODULE_LICENSE("GPL");
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
-
+static int acpi_processor_start(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
@@ -324,10 +324,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  they are physically not present.
 	 */
 	if (pr->id == -1) {
-		if (ACPI_FAILURE
-		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
+		if (ACPI_FAILURE(acpi_processor_hotadd_init(pr)))
 			return -ENODEV;
-		}
 	}
 	/*
 	 * On some boxes several processors use the same processor bus id.
@@ -425,10 +423,28 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr, 0);
-		acpi_processor_cst_has_changed(pr);
-		acpi_processor_reevaluate_tstate(pr, action);
-		acpi_processor_tstate_has_changed(pr);
+		/* CPU got hotplugged and onlined the first time
+		 * Initialize missing things
+		 */
+		if (pr->flags.need_hotplug_init) {
+			struct cpuidle_driver *idle_driver =
+				cpuidle_get_driver();
+
+			printk(KERN_INFO "Will online and init hotplugged "
+			       "CPU: %d\n", pr->id);
+			WARN(acpi_processor_start(pr), "Failed to start CPU:"
+				" %d\n", pr->id);
+			pr->flags.need_hotplug_init = 0;
+			if (idle_driver && !strcmp(idle_driver->name,
+						   "intel_idle")) {
+				intel_idle_cpu_init(pr->id);
+			}
+		} else {
+			acpi_processor_ppc_has_changed(pr, 0);
+			acpi_processor_cst_has_changed(pr);
+			acpi_processor_reevaluate_tstate(pr, action);
+			acpi_processor_tstate_has_changed(pr);
+		}
 	}
 	if (action == CPU_DEAD && pr) {
 		/* invalidate the flag.throttling after one CPU is offline */
@@ -442,7 +458,15 @@ static struct notifier_block acpi_cpu_notifier =
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int __cpuinit acpi_processor_start(struct acpi_processor *pr)
+/*
+ * acpi_processor_start() is called by the cpu_hotplug_notifier func:
+ * acpi_cpu_soft_notify(). Getting it __cpuinit{data} is difficult, the
+ * root cause seem to be that acpi_processor_uninstall_hotplug_notify()
+ * is in the module_exit (__exit) func. Allowing acpi_processor_start()
+ * to not be in __cpuinit section, but being called from __cpuinit funcs
+ * via __ref looks like the right thing to do here.
+ */
+static __ref int acpi_processor_start(struct acpi_processor *pr)
 {
 	struct acpi_device *device = per_cpu(processor_device_array, pr->id);
 	int result = 0;
@@ -548,6 +572,13 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		result = -EFAULT;
 		goto err_free_cpumask;
 	}
+	/*
+	 * Do not start hotplugged CPUs now, but when they
+	 * are onlined the first time
+	 */
+	if (pr->flags.need_hotplug_init)
+		return 0;
+
 	result = acpi_processor_start(pr);
 	if (result)
 		goto err_remove_sysfs;
@@ -737,20 +768,28 @@ processor_walk_namespace_cb(acpi_handle handle,
 	return (AE_OK);
 }
 
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
-
-	if (!is_processor_present(handle)) {
+	if (!is_processor_present(pr->handle))
 		return AE_ERROR;
-	}
 
-	if (acpi_map_lsapic(handle, p_cpu))
+	if (acpi_map_lsapic(pr->handle, &pr->id))
 		return AE_ERROR;
 
-	if (arch_register_cpu(*p_cpu)) {
-		acpi_unmap_lsapic(*p_cpu);
+	if (arch_register_cpu(pr->id)) {
+		acpi_unmap_lsapic(pr->id);
 		return AE_ERROR;
 	}
+	/* CPU got hot-plugged, but cpu_data is not initialized yet
+	 * Set flag to delay cpu_idle/throttling initialization
+	 * in:
+	 * acpi_processor_add()
+	 *   acpi_processor_get_info()
+	 * and do it when the CPU gets online the first time
+	 * TBD: Cleanup above functions and try to do this more elegant.
+	 */
+	printk(KERN_INFO "CPU %d got hotplugged\n", pr->id);
+	pr->flags.need_hotplug_init = 1;
 
 	return AE_OK;
 }
@@ -765,7 +804,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr)
 	return (0);
 }
 #else
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	return AE_ERROR;
 }
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 67055f1..2a2d3ab 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -195,6 +195,7 @@ struct acpi_processor_flags {
 	u8 has_cst:1;
 	u8 power_setup_done:1;
 	u8 bm_rld_set:1;
+	u8 need_hotplug_init:1;
 };
 
 struct acpi_processor {
-- 
1.7.6.1

