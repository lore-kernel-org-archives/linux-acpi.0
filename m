From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/30] ACPI / sysfs: Update /sys/firmware/acpi/interrupts/gpexx using new GPE masking mechanism
Date: Thu,  4 Aug 2016 16:43:45 +0800
Message-ID: <dd9a8337983bf450d5392d7948eeb9a9c4b54bae.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48669 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Now GPE can be masked via new acpi_mask_gpe() API, this patch modifies
/sys/firmware/acpi/interrupts/gpexx to use this new facility.

Writes "mask/unmask" to this file now invoke acpi_mask_gpe().

Reads from this file now returns new "EN/STS" when the corresponding GPE
hardware register's EN/STS bits are flagged, and new "masked/unmasked"
attribute to indicate the status of the masking mechanism.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sleep.c |    2 +-
 drivers/acpi/sysfs.c |   33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2b38c1b..9788663 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -572,7 +572,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
 
-		if (pwr_btn_status & ACPI_EVENT_FLAG_SET) {
+		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
 			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 			/* Flag for later */
 			pwr_btn_event_pending = true;
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 358165e..703c993 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -597,14 +597,27 @@ static ssize_t counter_show(struct kobject *kobj,
 	if (result)
 		goto end;
 
+	if (status & ACPI_EVENT_FLAG_ENABLE_SET)
+		size += sprintf(buf + size, "  EN");
+	else
+		size += sprintf(buf + size, "    ");
+	if (status & ACPI_EVENT_FLAG_STATUS_SET)
+		size += sprintf(buf + size, " STS");
+	else
+		size += sprintf(buf + size, "    ");
+
 	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
-		size += sprintf(buf + size, "   invalid");
+		size += sprintf(buf + size, " invalid     ");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, "   enabled");
+		size += sprintf(buf + size, " enabled     ");
 	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
-		size += sprintf(buf + size, "   wake_enabled");
+		size += sprintf(buf + size, " wake_enabled");
 	else
-		size += sprintf(buf + size, "   disabled");
+		size += sprintf(buf + size, " disabled    ");
+	if (status & ACPI_EVENT_FLAG_MASKED)
+		size += sprintf(buf + size, " masked  ");
+	else
+		size += sprintf(buf + size, " unmasked");
 
 end:
 	size += sprintf(buf + size, "\n");
@@ -655,8 +668,12 @@ static ssize_t counter_set(struct kobject *kobj,
 			 !(status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_enable_gpe(handle, index);
 		else if (!strcmp(buf, "clear\n") &&
-			 (status & ACPI_EVENT_FLAG_SET))
+			 (status & ACPI_EVENT_FLAG_STATUS_SET))
 			result = acpi_clear_gpe(handle, index);
+		else if (!strcmp(buf, "mask\n"))
+			result = acpi_mask_gpe(handle, index, TRUE);
+		else if (!strcmp(buf, "unmask\n"))
+			result = acpi_mask_gpe(handle, index, FALSE);
 		else if (!kstrtoul(buf, 0, &tmp))
 			all_counters[index].count = tmp;
 		else
@@ -664,13 +681,13 @@ static ssize_t counter_set(struct kobject *kobj,
 	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
 		int event = index - num_gpes;
 		if (!strcmp(buf, "disable\n") &&
-		    (status & ACPI_EVENT_FLAG_ENABLED))
+		    (status & ACPI_EVENT_FLAG_ENABLE_SET))
 			result = acpi_disable_event(event, ACPI_NOT_ISR);
 		else if (!strcmp(buf, "enable\n") &&
-			 !(status & ACPI_EVENT_FLAG_ENABLED))
+			 !(status & ACPI_EVENT_FLAG_ENABLE_SET))
 			result = acpi_enable_event(event, ACPI_NOT_ISR);
 		else if (!strcmp(buf, "clear\n") &&
-			 (status & ACPI_EVENT_FLAG_SET))
+			 (status & ACPI_EVENT_FLAG_STATUS_SET))
 			result = acpi_clear_event(event);
 		else if (!kstrtoul(buf, 0, &tmp))
 			all_counters[index].count = tmp;
-- 
1.7.10

