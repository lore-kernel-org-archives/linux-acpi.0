From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] ACPI: Store NVS state even when entering suspend to RAM
Date: Fri, 28 May 2010 16:32:15 -0400
Message-ID: <1275078735-1866-2-git-send-email-mjg@redhat.com>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030Ab0E1Uce (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 May 2010 16:32:34 -0400
In-Reply-To: <1275078735-1866-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

https://bugzilla.kernel.org/show_bug.cgi?id=13931 describes a bug where
a system fails to successfully resume after the second suspend. Maxim
Levitsky discovered that this could be rectified by forcibly saving
and restoring the ACPI non-volatile state. The spec indicates that this
is only required for S4, but testing the behaviour of Windows by adding
an ACPI NVS region to qemu's e820 map and registering a custom memory
read/write handler reveals that it's saved and restored even over suspend
to RAM. We should mimic that behaviour to avoid other broken platforms.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/sleep.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index d3cbc55..18aa074 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -128,6 +128,8 @@ static int __acpi_pm_prepare(void)
 {
 	int error = acpi_sleep_prepare(acpi_target_sleep_state);
 
+	suspend_nvs_save();
+
 	if (error)
 		acpi_target_sleep_state = ACPI_STATE_S0;
 	return error;
@@ -156,6 +158,8 @@ static void acpi_pm_finish(void)
 {
 	u32 acpi_state = acpi_target_sleep_state;
 
+	suspend_nvs_free();
+
 	if (acpi_state == ACPI_STATE_S0)
 		return;
 
@@ -205,6 +209,11 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
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
@@ -283,6 +292,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	if (acpi_state == ACPI_STATE_S3)
 		acpi_restore_state_mem();
 
+	suspend_nvs_restore();
+
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
@@ -583,12 +594,6 @@ static int acpi_hibernation_enter(void)
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
@@ -626,7 +631,7 @@ static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot,
-	.finish = acpi_hibernation_finish,
+	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
@@ -679,7 +684,7 @@ static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
 	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
-	.finish = acpi_hibernation_finish,
+	.finish = acpi_pm_finish,
 	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-- 
1.7.0.1

