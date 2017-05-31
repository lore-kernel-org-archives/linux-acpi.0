From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v4 5/5] ACPI: button: Cleanup lid notification logics
Date: Wed, 31 May 2017 17:42:28 +0800
Message-ID: <a8140dd7c0d37b748dcfc65824badb9c32271f43.1496221776.git.lv.zheng@intel.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-acpi@vger.kernel.org

Both nouveau and i915, the only 2 kernel space lid notification listeners,
invoke acpi_lid_open() API to obtain _LID returning value instead of using
the notified value. So kernel graphics drivers are only interested in _LID
return value, hence this patch makes this logic explicit in button driver.

However the preference may because kernel graphics drivers do not want to
receive non-bios notifications. Thus this patch also adds a global variable
to allow button driver to stop notifying non-bios notifications.

This is a no-op cleanup as the default behaviors are kept unchanged, but
may:
1. improve button.lid_init_state=method by introducing a possibility to
   allow kernel graphics driver to reduce redundant _LID evaluations, and
2. improve button.lid_init_state=open/method by introducing a possibility
   to stop notifying faked non bios events.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: linux-acpica/drivers/acpi/button.c
===================================================================
--- linux-acpica.orig/drivers/acpi/button.c
+++ linux-acpica/drivers/acpi/button.c
@@ -119,6 +119,7 @@ static u8 lid_init_state = ACPI_BUTTON_L
 static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
+static bool lid_notify_non_bios_events = true;
 
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
@@ -224,7 +225,17 @@ static void acpi_lid_notify_state(struct
 	if (state)
 		pm_wakeup_hard_event(&device->dev);
 
-	acpi_lid_notifier_call(device, state);
+	if (is_bios_event || lid_notify_non_bios_events) {
+		/*
+		 * The kernel drivers are only interested in the _LID
+		 * return value. But there are cases "state" is not a _LID
+		 * return value, so correct it before notifying.
+		 */
+		if (!is_bios_event &&
+		    lid_init_state != ACPI_BUTTON_LID_INIT_METHOD)
+			state = acpi_lid_evaluate_state(device);
+		acpi_lid_notifier_call(device, state);
+	}
 }
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
@@ -573,13 +584,13 @@ static int param_set_lid_init_state(cons
 
 	if (!strncmp(val, "open", sizeof("open") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
-		pr_info("Notify initial lid state as open\n");
+		pr_info("Report initial lid state as open to input layer\n");
 	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
-		pr_info("Notify initial lid state with _LID return value\n");
+		pr_info("Report initial lid state with _LID return value to input layer\n");
 	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
 		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
-		pr_info("Do not notify initial lid state\n");
+		pr_info("Do not report initial lid state to input layer\n");
 	} else
 		result = -EINVAL;
 	return result;
