From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH 1/4] ACPI button: provide lid status functions
Date: Wed, 15 Jul 2009 15:11:23 -0700
Message-ID: <1247695886-18432-2-git-send-email-jbarnes@virtuousgeek.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-16.bluehost.com ([69.89.20.231]:52936 "HELO
	outbound-mail-16.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753210AbZGOWSI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:18:08 -0400
In-Reply-To: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>

Some drivers need to know when a lid event occurs and get the current
status.  This can be useful for when a platform firmware clobbers some
hardware state at lid time, and a driver needs to restore things when
the lid is opened again.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/acpi/button.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/button.h |   10 ++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 include/acpi/button.h

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9195deb..ebb593e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -113,6 +113,9 @@ static const struct file_operations acpi_button_state_fops = {
 	.release = single_release,
 };
 
+static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
+static struct acpi_device *lid_device;
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -229,11 +232,38 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 /* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
+int acpi_lid_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
+}
+EXPORT_SYMBOL(acpi_lid_notifier_register);
+
+int acpi_lid_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
+}
+EXPORT_SYMBOL(acpi_lid_notifier_unregister);
+
+int acpi_lid_open(void)
+{
+	acpi_status status;
+	unsigned long long state;
+
+	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
+				       &state);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return !!state;
+}
+EXPORT_SYMBOL(acpi_lid_open);
+
 static int acpi_lid_send_state(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	unsigned long long state;
 	acpi_status status;
+	int ret;
 
 	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
 	if (ACPI_FAILURE(status))
@@ -242,7 +272,12 @@ static int acpi_lid_send_state(struct acpi_device *device)
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
-	return 0;
+
+	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
+	if (ret == NOTIFY_DONE)
+		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
+						   device);
+	return ret;
 }
 
 static void acpi_button_notify(struct acpi_device *device, u32 event)
@@ -364,8 +399,14 @@ static int acpi_button_add(struct acpi_device *device)
 	error = input_register_device(input);
 	if (error)
 		goto err_remove_fs;
-	if (button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID) {
 		acpi_lid_send_state(device);
+		/*
+		 * This assumes there's only one lid device, or if there are
+		 * more we only care about the last one...
+		 */
+		lid_device = device;
+	}
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
diff --git a/include/acpi/button.h b/include/acpi/button.h
new file mode 100644
index 0000000..bb643a7
--- /dev/null
+++ b/include/acpi/button.h
@@ -0,0 +1,10 @@
+#ifndef ACPI_BUTTON_H
+#define ACPI_BUTTON_H
+
+#include <linux/notifier.h>
+
+extern int acpi_lid_notifier_register(struct notifier_block *nb);
+extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
+extern int acpi_lid_open(void);
+
+#endif /* ACPI_BUTTON_H */
-- 
1.6.2.5

