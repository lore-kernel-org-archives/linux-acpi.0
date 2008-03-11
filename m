From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/12] ACPI: replace remaining __FUNCTION__ occurrences
Date: Tue, 11 Mar 2008 02:51:49 -0400
Message-ID: <96b2dd1f1fdb9a131b7f2e79e5c7b2e4282cfcbf.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:2378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754378AbYCKGy4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:56 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Len Brown <len.brown@intel.com>

From: Harvey Harrison <harvey.harrison@gmail.com>

__FUNCTION__ is gcc-specific, use __func__

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c               |    2 +-
 drivers/acpi/scan.c              |    2 +-
 drivers/acpi/sleep/main.c        |    2 +-
 drivers/acpi/utilities/utdebug.c |    2 +-
 drivers/acpi/video.c             |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index ce3c0a2..5b6760e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -776,7 +776,7 @@ static int __init acpi_init(void)
 
 	acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
 	if (!acpi_kobj) {
-		printk(KERN_WARNING "%s: kset create error\n", __FUNCTION__);
+		printk(KERN_WARNING "%s: kset create error\n", __func__);
 		acpi_kobj = NULL;
 	}
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3fac011..b26e301 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -966,7 +966,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 	case ACPI_BUS_TYPE_DEVICE:
 		status = acpi_get_object_info(handle, &buffer);
 		if (ACPI_FAILURE(status)) {
-			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __FUNCTION__);
+			printk(KERN_ERR PREFIX "%s: Error reading device info\n", __func__);
 			return;
 		}
 
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 293a1cb..d2f71a5 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -504,7 +504,7 @@ static void acpi_power_off_prepare(void)
 static void acpi_power_off(void)
 {
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
-	printk("%s called\n", __FUNCTION__);
+	printk("%s called\n", __func__);
 	local_irq_disable();
 	acpi_enable_wakeup_device(ACPI_STATE_S5);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index c7e128e..7361204 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -109,7 +109,7 @@ void acpi_ut_track_stack_ptr(void)
  * RETURN:      Updated pointer to the function name
  *
  * DESCRIPTION: Remove the "Acpi" prefix from the function name, if present.
- *              This allows compiler macros such as __FUNCTION__ to be used
+ *              This allows compiler macros such as __func__ to be used
  *              with no change to the debug output.
  *
  ******************************************************************************/
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 12cce69..d64a142 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1201,7 +1201,7 @@ static int acpi_video_bus_ROM_seq_show(struct seq_file *seq, void *offset)
 	if (!video)
 		goto end;
 
-	printk(KERN_INFO PREFIX "Please implement %s\n", __FUNCTION__);
+	printk(KERN_INFO PREFIX "Please implement %s\n", __func__);
 	seq_printf(seq, "<TODO>\n");
 
       end:
-- 
1.5.4.3.422.g34cd6

