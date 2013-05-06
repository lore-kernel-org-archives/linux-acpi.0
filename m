From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [FIX PATCH] ACPI/AC: Add sleep quirk for Thinkpad e530
Date: Mon,  6 May 2013 20:27:33 +0800
Message-ID: <1367843253-13021-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61557 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3EFMdX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 May 2013 08:33:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

Thinkpad e530 bios notify ac device first and then sleep
a specific time before doing actual operations in the
EC event handler(_Qxx). This will cause the AC state
reported by ACPI event.

Method (_Q27, 0, NotSerialized)
{
      Notify (AC, 0x80)
      Sleep (0x03E8)
      Store (Zero, PWRS)
      PNOT ()
}

This patch is to add a 1s sleep in the ac driver's
notify handler before acpi_ac_get_state() to make
sure get right state.

https://bugzilla.kernel.org/show_bug.cgi?id=45221

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ac.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 6d5bf64..0292cbb 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/dmi.h>
+#include <linux/delay.h>
 #ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -74,6 +76,8 @@ static int acpi_ac_resume(struct device *dev);
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 
+static int ac_flag_sleep_for_get_state;
+
 static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
@@ -252,6 +256,15 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
+		/* Some buggy bios notify ac device first and then sleep
+		 * a specific time before doing actual operations in the
+		 * EC event handler(_Qxx). This will cause the AC state
+		 * reported by ACPI event wrong. So add a 1s sleep here
+		 * to ensure get correct state.
+		 */
+		if (ac_flag_sleep_for_get_state)
+			msleep(1000);
+
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_proc_event(device, event, (u32) ac->state);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
@@ -264,6 +277,24 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 	return;
 }
 
+static int ac_sleep_for_get_state(const struct dmi_system_id *d)
+{
+	ac_flag_sleep_for_get_state = 1;
+	return 0;
+}
+
+static struct dmi_system_id __initdata ac_dmi_table[] = {
+	{
+	.callback = ac_sleep_for_get_state,
+	.ident = "thinkpad e530",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
+		},
+	},
+	{},
+};
+
 static int acpi_ac_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -312,6 +343,7 @@ static int acpi_ac_add(struct acpi_device *device)
 		kfree(ac);
 	}
 
+	dmi_check_system(ac_dmi_table);
 	return result;
 }
 
-- 
1.7.10.4

