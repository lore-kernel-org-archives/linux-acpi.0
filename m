From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH v3] ACPI: Support for platform initiated graceful shutdown
Date: Thu, 23 Jun 2016 12:24:26 -0600
Message-ID: <1466706266-25513-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46909 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbcFWSYv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 14:24:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, cov@codeaurora.org, ahs3@redhat.com, harba@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

This patch adds support for platform initited graceful shutdown as
described in sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec

The OSPM will get a graceful shutdown request via a Notify operator
on \_SB device with a value of 0x81 per section 5.6.6. Following the
shutdown request from platform the OSPM needs to follow the
processing sequence as described in section 6.2.5.1.

v3
* Switched to regular work with delays from delayed work
* Dropped changes to actypes.h
* Small style changes

v2
* Switched from standalone driver to a simple notify handler

v1
* Initial

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/bus.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 262ca31..51adbae 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -30,6 +30,9 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/regulator/machine.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
+#include <linux/delay.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
 #endif
@@ -475,6 +478,56 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
 					   acpi_device_notify);
 }
 
+/* Handle events targeting \_SB device (at present only graceful shutdown) */
+
+#define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
+#define ACPI_SB_INDICATE_INTERVAL	10000
+
+static void sb_notify_work(struct work_struct *dummy)
+{
+	acpi_handle sb_handle;
+
+	orderly_poweroff(true);
+
+	/*
+	 * After initiating graceful shutdown, the ACPI spec requires OSPM
+	 * to evaluate _OST method once every 10seconds to indicate that
+	 * the shutdown is in progress
+	 */
+	acpi_get_handle(NULL, "\\_SB", &sb_handle);
+	while (1) {
+		pr_info("Graceful shutdown in progress.\n");
+		acpi_evaluate_ost(sb_handle, ACPI_OST_EC_OSPM_SHUTDOWN,
+				ACPI_OST_SC_OS_SHUTDOWN_IN_PROGRESS, NULL);
+		msleep(ACPI_SB_INDICATE_INTERVAL);
+	}
+}
+
+static void acpi_sb_notify(acpi_handle handle, u32 event, void *data)
+{
+	static DECLARE_WORK(acpi_sb_work, sb_notify_work);
+
+	if (event == ACPI_SB_NOTIFY_SHUTDOWN_REQUEST) {
+		if (!work_busy(&acpi_sb_work))
+			schedule_work(&acpi_sb_work);
+	} else
+		pr_warn("event %x is not supported by \\_SB device\n", event);
+}
+
+static int __init acpi_setup_sb_notify_handler(void)
+{
+	acpi_handle sb_handle;
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &sb_handle)))
+		return -ENXIO;
+
+	if (ACPI_FAILURE(acpi_install_notify_handler(sb_handle, ACPI_DEVICE_NOTIFY,
+						acpi_sb_notify, NULL)))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* --------------------------------------------------------------------------
                              Device Matching
    -------------------------------------------------------------------------- */
@@ -1124,6 +1177,7 @@ static int __init acpi_init(void)
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
+	acpi_setup_sb_notify_handler();
 	return 0;
 }
 
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

