From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/3] ACPI / sys: Update /sys/firmware/acpi/interrupts/gpexx using new GPE masking mechanism
Date: Thu, 23 Jun 2016 14:20:24 +0800
Message-ID: <6edb1303d9162d396834042f6600bfddd48af88a.1466662469.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com> <cover.1466662469.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466662469.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
index 7a2e4d4..d00544c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -555,7 +555,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
 
-		if (pwr_btn_status & ACPI_EVENT_FLAG_SET) {
+		if (pwr_btn_status & ACPI_EVENT_FLAG_STATUS_SET) {
 			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
 			/* Flag for later */
 			pwr_btn_event_pending = true;
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 4b3a9e2..0303c99 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -599,14 +599,27 @@ static ssize_t counter_show(struct kobject *kobj,
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
@@ -657,8 +670,12 @@ static ssize_t counter_set(struct kobject *kobj,
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
@@ -666,13 +683,13 @@ static ssize_t counter_set(struct kobject *kobj,
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
