From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI / sys: Update /sys/firmware/acpi/interrupts/gpexx using new GPE forced disabling/enabling mechanism
Date: Mon, 16 May 2016 17:11:18 +0800
Message-ID: <a4ce1750ef4a5ad3437ecb9934f6f640f831a35c.1463389640.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463389639.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Now GPE can be forced enabling/disabling through GPE management APIs, this
patch modifies /sys/firmware/acpi/interrupts/gpexx to use this new
facility.

The "block" command is implemented to invoke acpi_block_gpe() and the
"unblock" command is implemented to invoke acpi_unblock_gpe().
The "force-poll"/"force-irq"/"unforce" command is implemented to invoke
acpi_control_gpe_handling() to switch GPE handling mode (for EC driver
only).

"EN STS" is returned to display the current hardware register status, along
with "!" flag to indicate the register bit unset and "*" flag to indicate
the managed state.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sleep.c |    2 +-
 drivers/acpi/sysfs.c |   36 ++++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

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
index 4b3a9e2..7f33c90 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -599,6 +599,19 @@ static ssize_t counter_show(struct kobject *kobj,
 	if (result)
 		goto end;
 
+	if (status & ACPI_EVENT_FLAG_ENABLE_SET)
+		size += sprintf(buf + size, "      EN");
+	else
+		size += sprintf(buf + size, "     !EN");
+	if (status & ACPI_EVENT_FLAG_MANAGED)
+		size += sprintf(buf + size, "*");
+	else
+		size += sprintf(buf + size, " ");
+	if (status & ACPI_EVENT_FLAG_STATUS_SET)
+		size += sprintf(buf + size, "     STS");
+	else
+		size += sprintf(buf + size, "    !STS");
+
 	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
 		size += sprintf(buf + size, "   invalid");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
@@ -656,8 +669,23 @@ static ssize_t counter_set(struct kobject *kobj,
 		else if (!strcmp(buf, "enable\n") &&
 			 !(status & ACPI_EVENT_FLAG_ENABLED))
 			result = acpi_enable_gpe(handle, index);
+		else if (!strcmp(buf, "block\n"))
+			result = acpi_block_gpe(handle, index);
+		else if (!strcmp(buf, "unblock\n") &&
+			 (status & ACPI_EVENT_FLAG_MANAGED))
+			result = acpi_unblock_gpe(handle, index);
+		else if (!strcmp(buf, "force-poll\n"))
+			result = acpi_control_gpe_handling(handle, index,
+							   TRUE, FALSE);
+		else if (!strcmp(buf, "force-irq\n"))
+			result = acpi_control_gpe_handling(handle, index,
+							   FALSE, TRUE);
+		else if (!strcmp(buf, "unforce\n") &&
+			 (status & ACPI_EVENT_FLAG_MANAGED))
+			result = acpi_control_gpe_handling(handle, index,
+							   TRUE, TRUE);
 		else if (!strcmp(buf, "clear\n") &&
-			 (status & ACPI_EVENT_FLAG_SET))
+			 (status & ACPI_EVENT_FLAG_STATUS_SET))
 			result = acpi_clear_gpe(handle, index);
 		else if (!kstrtoul(buf, 0, &tmp))
 			all_counters[index].count = tmp;
@@ -666,13 +694,13 @@ static ssize_t counter_set(struct kobject *kobj,
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
