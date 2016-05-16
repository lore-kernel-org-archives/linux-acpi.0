From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH v2] ACPI: Support for platform initiated graceful shutdown
Date: Mon, 16 May 2016 14:21:52 -0600
Message-ID: <1463430112-8843-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37166 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbcEPUWR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2016 16:22:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, harba@codeaurora.org, ahs3@redhat.com, Prashanth Prakash <pprakash@codeaurora.org>

This patch adds support for platform initited graceful shutdown as
described in sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec

The OSPM will get a graceful shutdown request via a Notify operator
on \_SB device with a value of 0x81 per section 5.6.6. Following the
shutdown request from platform the OSPM needs to follow the
processing sequence as described in section 6.2.5.1.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/acpi/bus.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/actypes.h |  2 +-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 31e8da6..25d4806 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -30,6 +30,8 @@
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/regulator/machine.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
 #endif
@@ -475,6 +477,52 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
 					   acpi_device_notify);
 }
 
+/* Handle events targeting \_SB device (at present only graceful shutdown) */
+
+#define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
+#define ACPI_SYBUS_INDICATE_INTERVAL	10000
+
+static void sybus_evaluate_ost(struct work_struct *dummy);
+static DECLARE_DELAYED_WORK(acpi_sybus_work, sybus_evaluate_ost);
+
+static void sybus_evaluate_ost(struct work_struct *dummy)
+{
+	acpi_handle sb_handle;
+
+	if (ACPI_SUCCESS(acpi_get_handle(NULL, "\\_SB", &sb_handle))) {
+		acpi_evaluate_ost(sb_handle, ACPI_OST_EC_OSPM_SHUTDOWN,
+				ACPI_OST_SC_OS_SHUTDOWN_IN_PROGRESS, NULL);
+		schedule_delayed_work(&acpi_sybus_work,
+				msecs_to_jiffies(ACPI_SYBUS_INDICATE_INTERVAL));
+		pr_info("Graceful shutdown in progress.\n");
+	}
+}
+
+static void acpi_sybus_notify(acpi_handle handle, u32 event, void *data)
+{
+	if (event == ACPI_SB_NOTIFY_SHUTDOWN_REQUEST) {
+		if (!delayed_work_pending(&acpi_sybus_work)) {
+			sybus_evaluate_ost(NULL);
+			orderly_poweroff(true);
+		}
+	} else
+		pr_warn("event %x is not supported by \\_SB device\n", event);
+}
+
+static int __init acpi_setup_sybus_notify_handler(void)
+{
+	acpi_handle sb_handle;
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &sb_handle)))
+		return -ENXIO;
+
+	if (ACPI_FAILURE(acpi_install_notify_handler(sb_handle, ACPI_DEVICE_NOTIFY,
+						acpi_sybus_notify, NULL)))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* --------------------------------------------------------------------------
                              Device Matching
    -------------------------------------------------------------------------- */
@@ -1124,6 +1172,7 @@ static int __init acpi_init(void)
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
+	acpi_setup_sybus_notify_handler();
 	return 0;
 }
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cb389ef..860b273 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -627,7 +627,7 @@ typedef u64 acpi_integer;
 #define ACPI_NOTIFY_DEVICE_PLD_CHECK    (u8) 0x09
 #define ACPI_NOTIFY_RESERVED            (u8) 0x0A
 #define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
-#define ACPI_NOTIFY_SHUTDOWN_REQUEST    (u8) 0x0C
+#define ACPI_NOTIFY_RESERVED_2          (u8) 0x0C
 #define ACPI_NOTIFY_AFFINITY_UPDATE     (u8) 0x0D
 
 #define ACPI_GENERIC_NOTIFY_MAX         0x0D
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

