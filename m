From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/16] ACPI: Store NVS state even when entering suspend to RAM
Date: Fri, 04 Jun 2010 15:51:46 -0400
Message-ID: <c4db19a122abc06bbb84e88f1add66a4e79202ac.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab0FHTmO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:14 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:13 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

https://bugzilla.kernel.org/show_bug.cgi?id=13931 describes a bug where
a system fails to successfully resume after the second suspend. Maxim
Levitsky discovered that this could be rectified by forcibly saving
and restoring the ACPI non-volatile state. The spec indicates that this
is only required for S4, but testing the behaviour of Windows by adding
an ACPI NVS region to qemu's e820 map and registering a custom memory
read/write handler reveals that it's saved and restored even over suspend
to RAM. We should mimic that behaviour to avoid other broken platforms.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index bcaa6ef..403daf0 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -112,6 +112,8 @@ static int __acpi_pm_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
+	suspend_nvs_save();
+
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
 	return error;
@@ -140,6 +142,8 @@ static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
+	suspend_nvs_free();
+
 	if (acpi_state == ACPI_STATE_S0)
 		return;
 
@@ -189,6 +193,11 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
 	u32 acpi_state = acpi_suspend_states[pm_state];
 	int error = 0;
 
+	error = suspend_nvs_alloc();
+
+	if (error)
+		return error;
+
 	if (sleep_states[acpi_state]) {
 		acpi_target_sleep_state = acpi_state;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -264,6 +273,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	if (acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
+	suspend_nvs_restore();
+
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
@@ -430,12 +441,6 @@ static int acpi_hibernation_enter(void)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
-static void acpi_hibernation_finish(void)
-{
-	suspend_nvs_free();
-	acpi_pm_finish();
-}
-
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -473,7 +478,7 @@ static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot,
-	.finish = acpi_hibernation_finish,
+	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
@@ -526,7 +531,7 @@ static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
-	.finish = acpi_hibernation_finish,
+	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-- 
1.6.0.6

