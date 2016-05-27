From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/3] ACPI / button: Refactor functions to eliminate redundant code
Date: Fri, 27 May 2016 15:15:59 +0800
Message-ID: <b08061cb22639254107840b7ba8da0907fd0191f.1464332745.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com> <cover.1464332745.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464332745.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch simplies the code by merging the redundant code. No functional
changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c |   92 +++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9863278..e706e4b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -113,16 +113,53 @@ static struct acpi_device *lid_device;
 static struct proc_dir_entry *acpi_button_dir;
 static struct proc_dir_entry *acpi_lid_dir;
 
+static int acpi_lid_evaluate_state(struct acpi_device *device)
+{
+	unsigned long long lid_state;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &lid_state);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return lid_state ? 1 : 0;
+}
+
+static int acpi_lid_notify_state(struct acpi_device *device, int state)
+{
+	struct acpi_button *button = acpi_driver_data(device);
+	int ret;
+
+	/* input layer checks if event is redundant */
+	input_report_switch(button->input, SW_LID, !state);
+	input_sync(button->input);
+
+	if (state)
+		pm_wakeup_event(&device->dev, 0);
+
+	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
+	if (ret == NOTIFY_DONE)
+		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
+						   device);
+	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
+		/*
+		 * It is also regarded as success if the notifier_chain
+		 * returns NOTIFY_OK or NOTIFY_DONE.
+		 */
+		ret = 0;
+	}
+	return ret;
+}
+
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_device *device = seq->private;
-	acpi_status status;
-	unsigned long long state;
+	int state;
 
-	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
+	state = acpi_lid_evaluate_state(device);
 	seq_printf(seq, "state:      %s\n",
-		   ACPI_FAILURE(status) ? "unsupported" :
-			(state ? "open" : "closed"));
+		   IS_ERR_VALUE(state) ? "unsupported" :
+		   (state ? "open" : "closed"));
 	return 0;
 }
 
@@ -231,51 +268,22 @@ EXPORT_SYMBOL(acpi_lid_notifier_unregister);
 
 int acpi_lid_open(void)
 {
-	acpi_status status;
-	unsigned long long state;
-
 	if (!lid_device)
 		return -ENODEV;
 
-	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
-				       &state);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return !!state;
+	return acpi_lid_evaluate_state(lid_device);
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_send_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device)
 {
-	struct acpi_button *button = acpi_driver_data(device);
-	unsigned long long state;
-	acpi_status status;
-	int ret;
-
-	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
+	int state;
 
-	/* input layer checks if event is redundant */
-	input_report_switch(button->input, SW_LID, !state);
-	input_sync(button->input);
+	state = acpi_lid_evaluate_state(device);
+	if (IS_ERR_VALUE(state))
+		return state;
 
-	if (state)
-		pm_wakeup_event(&device->dev, 0);
-
-	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
-	if (ret == NOTIFY_DONE)
-		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
-						   device);
-	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
-		/*
-		 * It is also regarded as success if the notifier_chain
-		 * returns NOTIFY_OK or NOTIFY_DONE.
-		 */
-		ret = 0;
-	}
-	return ret;
+	return acpi_lid_notify_state(device, state);
 }
 
 static void acpi_button_notify(struct acpi_device *device, u32 event)
@@ -290,7 +298,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
-			acpi_lid_send_state(device);
+			acpi_lid_update_state(device);
 		} else {
 			int keycode;
 
-- 
1.7.10
