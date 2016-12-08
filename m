From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3] ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding
Date: Thu,  8 Dec 2016 12:50:51 +0800
Message-ID: <20e06a1b76c0dd0187dfaed14789ecf434b90e29.1481172564.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9179 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcLHEu7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Dec 2016 23:50:59 -0500
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
Link: https://bugzilla.kernel.org/show_bug.cgi?id=117481
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/887793
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 Documentation/kernel-parameters.txt |   10 +++++++
 drivers/acpi/internal.h             |    1 +
 drivers/acpi/scan.c                 |    1 +
 drivers/acpi/sysfs.c                |   56 +++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1f6cecc..12cab01 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -305,6 +305,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			use by PCI
 			Format: <irq>,<irq>...
 
+	acpi_mask_gpe=  [HW,ACPI]
+			Due to the existence of _Lxx/_Exx, some GPEs triggered
+			by unsupported hardware/firmware features can result in
+                        GPE floodings that cannot be automatically disabled by
+                        the GPE dispatcher.
+			This facility can be used to prevent such uncontrolled
+			GPE floodings.
+			Format: <int>
+			Support masking of GPEs numbered from 0x00 to 0x7f.
+
 	acpi_no_auto_serialize	[HW,ACPI]
 			Disable auto-serialization of AML methods
 			AML control methods that contain the opcodes to create
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 1b41a27..0c45226 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -37,6 +37,7 @@
 static inline void acpi_amba_init(void) {}
 #endif
 int acpi_sysfs_init(void);
+void acpi_gpe_apply_masked_gpes(void);
 void acpi_container_init(void);
 void acpi_memory_hotplug_init(void);
 #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3d1856f..5a2fdf1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2044,6 +2044,7 @@ int __init acpi_scan_init(void)
 		}
 	}
 
+	acpi_gpe_apply_masked_gpes();
 	acpi_update_all_gpes();
 	acpi_ec_ecdt_start();
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 703c26e..47d7182 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -708,6 +708,62 @@ static ssize_t counter_set(struct kobject *kobj,
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
+ *   acpi_mask_gpe=0x00
+ * The masking status can be modified by the following runtime controlling
+ * interface:
+ *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
+ */
+
+/*
+ * Currently, the GPE flooding prevention only supports to mask the GPEs
+ * numbered from 00 to 7f.
+ */
+#define ACPI_MASKABLE_GPE_MAX	0x80
+
+static u64 acpi_masked_gpes;
+
+static int __init acpi_gpe_set_masked_gpes(char *val)
+{
+	u8 gpe;
+
+	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
+		return -EINVAL;
+	acpi_masked_gpes |= ((u64)1<<gpe);
+
+	return 1;
+}
+__setup("acpi_mask_gpe=", acpi_gpe_set_masked_gpes);
+
+void acpi_gpe_apply_masked_gpes(void)
+{
+	acpi_handle handle;
+	acpi_status status;
+	u8 gpe;
+
+	for (gpe = 0;
+	     gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
+	     gpe++) {
+		if (acpi_masked_gpes & ((u64)1<<gpe)) {
+			status = acpi_get_gpe_device(gpe, &handle);
+			if (ACPI_SUCCESS(status)) {
+				pr_info("Masking GPE 0x%x.\n", gpe);
+				(void)acpi_mask_gpe(handle, gpe, TRUE);
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

