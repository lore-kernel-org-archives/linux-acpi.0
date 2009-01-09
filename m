From: Len Brown <lenb@kernel.org>
Subject: [PATCH 64/94] ACPI: proc.c: remove ACPI_FUNCTION_TRACE
Date: Fri, 09 Jan 2009 04:27:06 -0500
Message-ID: <95d9a7a828aedef965234f348b916caa98be1e6c.1231492610.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbZAIJ25 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:57 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MQZ6BAVY83@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:23 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

ACPI_FUNCTION_TRACE and return_VALUE are internal acpica functions.
remove ACPI_FUNCTION_TRACE
replace return_VALUE with return

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4dbc227..1c4851f 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -28,8 +28,6 @@ static int acpi_system_sleep_seq_show(struct seq_file *seq, void *offset)
 {
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_system_sleep_seq_show");
-
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
 		if (sleep_states[i]) {
 			seq_printf(seq, "S%d ", i);
@@ -93,8 +91,6 @@ static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 	unsigned char rtc_control = 0;
 	unsigned long flags;
 
-	ACPI_FUNCTION_TRACE("acpi_system_alarm_seq_show");
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
 	sec = CMOS_READ(RTC_SECONDS_ALARM);
@@ -227,13 +223,11 @@ acpi_system_write_alarm(struct file *file,
 	int adjust = 0;
 	unsigned char rtc_control = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_system_write_alarm");
-
 	if (count > sizeof(alarm_string) - 1)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(alarm_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	alarm_string[count] = '\0';
 
@@ -334,7 +328,7 @@ acpi_system_write_alarm(struct file *file,
 
 	result = 0;
       end:
-	return_VALUE(result ? result : count);
+	return result ? result : count;
 }
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 
-- 
1.5.6.6

