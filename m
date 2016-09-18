From: Alexander Diewald <a.diewald@diewald-net.com>
Subject: [PATCH] Let platform drivers set GPE masks: Fix suspend for Intel
 Virtual Button Devices
Date: Sun, 18 Sep 2016 20:52:37 +0200
Message-ID: <1474224757.1234.25.camel@diewald-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out.selfhost.de ([82.98.82.95]:52491 "EHLO outgoing.selfhost.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754816AbcIRS7W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 18 Sep 2016 14:59:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

newer x86 devices that support Windows 8/10 may come with a "new"
virtual button device that handles basic keypresses like the power
button. In the 4.8 merge window, there was already basic support added
for Intel Virtual Button Devices (like the Dell Venue Pro 11) such that
these kinds of buttons are recognized during runtime. However, special
GPE masks are required to enable resuming these devices via the power
button. (For the detailed discussion please see https://bugzilla.kernel
.org/show_bug.cgi?id=102281).

Here, the problem is that the ACPI subsystem assigns the GPE mask that
allows the device to wake up to the runtime GPEs, whereas the wake gpe
mask set is not correct. Changing this logic is hence a no-go to
support a single device due to the risk of breaking other
functionality.

Hence, this patch allows to externally set the mask for a given GPE.
This allows platform drivers to "correct" wrongly detected GPE masks
using the method acpi_hw_set_gpe_wake_mask(...).
Further, this patch demonstrates its usefulness by calling this method
from a suspend hook in the corresponding platform driver by setting the
GPE of the power button to the correct value that allows the device to
resume from suspend.

The correct functionality of the patch as-is has been verified by me.
I'll welcome any feedback about this patch!


Best regards,

Alexander Diewald


Signed-off-by: Alexander Diewald <a.diewald@diewald-net.com>


diff --git a/drivers/acpi/acpica/acstruct.h
b/drivers/acpi/acpica/acstruct.h
index 6235642..bbe503d 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -232,6 +232,13 @@
 	u8 display_type;
 };
 
+/* Defines a GPE by its number and its mask. */
+
+struct gpe_mask {
+	u32 gpe_number;
+	u8 gpe_mask;
+};
+
 /* Display Types */
 
 #define ACPI_DISPLAY_SUMMARY        (u8) 0
diff --git a/drivers/acpi/acpica/evgpeutil.c
b/drivers/acpi/acpica/evgpeutil.c
index 3f150d5..2234780 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -357,4 +357,35 @@
 	return_ACPI_STATUS(AE_OK);
 }
 
+static unsigned int
+acpi_hw_set_gpe_wake_mask_internal(struct acpi_gpe_xrupt_info
*gpe_xrupt_info,
+				struct acpi_gpe_block_info *gpe_block,
+				void *context)
+{
+	u32 i;
+	struct acpi_gpe_register_info *gpe_register_info;
+
+	struct gpe_mask *gpe_set = context;
+
+	/* Examine each GPE Register within the block */
+
+	for (i = 0; i < gpe_block->register_count; i++) {
+		gpe_register_info = &gpe_block->register_info[i];
+		if(gpe_register_info->base_gpe_number == gpe_set-
>gpe_number) {
+			gpe_register_info->enable_for_wake = gpe_set-
>gpe_mask;
+           return 0;
+		}
+	}
+
+	return -1;
+}
+
+void acpi_hw_set_gpe_wake_mask(u32 gpe_number, u8 gpe_mask) {
+	struct gpe_mask set_gpe;
+	set_gpe.gpe_number = gpe_number;
+	set_gpe.gpe_mask = gpe_mask;
+	acpi_ev_walk_gpe_list(&acpi_hw_set_gpe_wake_mask_internal,
(void*)&set_gpe);
+}
+EXPORT_SYMBOL(acpi_hw_set_gpe_wake_mask);
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/platform/x86/intel-vbtn.c
b/drivers/platform/x86/intel-vbtn.c
index 146d02f..7f28d24 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -24,6 +24,8 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/acpixf.h>
+
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AceLan Kao");
@@ -144,6 +146,25 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int intel_vbtn_sleep(struct device *dev)
+{
+	// Set the mask for the GPE associated with the power button
to the
+	// value of the run mask, otherwise resuming is not possible
with the
+	// power button.
+	acpi_hw_set_gpe_wake_mask(8, 5);
+	return 0;
+}
+
+static int intel_vbtn_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(intel_vbtn_pm,
+		intel_vbtn_sleep, intel_vbtn_resume);
+#endif
+
 static struct platform_driver intel_vbtn_pl_driver = {
 	.driver = {
 		.name = "intel-vbtn",
@@ -151,6 +172,9 @@
 	},
 	.probe = intel_vbtn_probe,
 	.remove = intel_vbtn_remove,
+#ifdef CONFIG_PM_SLEEP
+	.driver.pm = &intel_vbtn_pm,
+#endif
 };
 MODULE_DEVICE_TABLE(acpi, intel_vbtn_ids);
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 562603d..cf64f19 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -333,6 +333,8 @@
 acpi_status acpi_os_signal(u32 function, void *info);
 #endif
 
+void acpi_hw_set_gpe_wake_mask(u32 gpe_number, u8 gpe_mask);
+
 /*
  * Debug print routines
  */

