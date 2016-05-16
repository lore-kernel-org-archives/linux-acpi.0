From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding
Date: Mon, 16 May 2016 17:11:24 +0800
Message-ID: <c6808078a092fbf990d535cc359b734108ae5d6b.1463389640.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62070 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbcEPJL2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 May 2016 05:11:28 -0400
In-Reply-To: <cover.1463389639.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Sometimes, the users may require a quirk to be provided from ACPI subsystem
core to prevent a GPE from flooding. Normally, if a GPE cannot be
dispatched, ACPICA core automatically prevents the GPE from firing. But
there are cases the GPE is dispatched by _Lxx/_Exx provided via AML table,
and OSPM is lacking of the knowledge to get _Lxx/_Exx correctly executed to
handle the GPE, thus the GPE flooding may still occur.

This patch provides a quirk mechanism to stop this kind of GPE flooding.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=53071
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    1 +
 drivers/acpi/sleep.c    |    2 ++
 drivers/acpi/sysfs.c    |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9bb0773..d0f1744 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -37,6 +37,7 @@ void acpi_amba_init(void);
 static inline void acpi_amba_init(void) {}
 #endif
 int acpi_sysfs_init(void);
+void acpi_gpe_apply_blocked_gpes(void);
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
 #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5f28cf7..5ff366c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1958,6 +1958,7 @@ int __init acpi_scan_init(void)
 		}
 	}
 
+	acpi_gpe_apply_blocked_gpes();
 	acpi_update_all_gpes();
 
  out:
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index d00544c..daba3ba 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -414,6 +414,7 @@ static void acpi_pm_finish(void)
 		acpi_state);
 	acpi_disable_wakeup_devices(acpi_state);
 	acpi_leave_sleep_state(acpi_state);
+	acpi_gpe_apply_blocked_gpes();
 
 	/* reset firmware waking vector */
 	acpi_set_waking_vector(0);
@@ -774,6 +775,7 @@ static void acpi_pm_thaw(void)
 {
 	acpi_ec_unblock_transactions();
 	acpi_enable_all_runtime_gpes();
+	acpi_gpe_apply_blocked_gpes();
 }
 
 static const struct platform_hibernation_ops acpi_hibernation_ops = {
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7f33c90..a2fb524 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -715,6 +715,62 @@ end:
 	return result ? result : size;
 }
 
+/*
+ * A Quirk Mechanism for GPE Flooding Prevention:
+ *
+ * Quirks may be needed to prevent GPE flooding on a specific GPE. The
+ * flooding typically cannot be detected and automatically prevented by
+ * ACPI_GPE_DISPATCH_NONE check because there is a _Lxx/_Exx prepared in
+ * the AML tables. This normally indicates a feature gap in Linux, thus
+ * instead of providing endless quirk tables, we provide a boot parameter
+ * for those who want this quirk. For example, if the users want to prevent
+ * the GPE flooding for GPE 00, they need to specify the following boot
+ * parameter:
+ *   acpi.block_gpe=0x00
+ * The blocking status can be modified by the following runtime controlling
+ * interface:
+ *   echo unblock > /sys/firmware/acpi/interrupts/gpe00
+ */
+
+/*
+ * Currently, the GPE flooding prevention only supports to block the GPEs
+ * numbered from 00 to 63.
+ */
+#define ACPI_BLOCKABLE_GPE_MAX	64
+
+static u64 acpi_blocked_gpes;
+
+static int __init acpi_gpe_set_blocked_gpes(char *val)
+{
+	u8 gpe;
+
+	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_BLOCKABLE_GPE_MAX)
+		return -EINVAL;
+	acpi_blocked_gpes |= ((u64)1<<gpe);
+
+	return 1;
+}
+__setup("acpi_block_gpe=", acpi_gpe_set_blocked_gpes);
+
+void acpi_gpe_apply_blocked_gpes(void)
+{
+	acpi_handle handle;
+	acpi_status status;
+	u8 gpe;
+
+	for (gpe = 0;
+	     gpe < min_t(u8, ACPI_BLOCKABLE_GPE_MAX, acpi_current_gpe_count);
+	     gpe++) {
+		if (acpi_blocked_gpes & ((u64)1<<gpe)) {
+			status = acpi_get_gpe_device(gpe, &handle);
+			if (ACPI_SUCCESS(status)) {
+				pr_info("Blocking GPE 0x%x.\n", gpe);
+				(void)acpi_block_gpe(handle, gpe);
+			}
+		}
+	}
+}
+
 void acpi_irq_stats_init(void)
 {
 	acpi_status status;
-- 
1.7.10

