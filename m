From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/20] ACPI / Sleep: Drop acpi_suspend_finish()
Date: Sun, 15 Aug 2010 01:23:09 -0400
Message-ID: <618d7fd0d4e51a45d25d9bc6097a0cb1e5a2f226.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49385 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0HOFXb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:31 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600CE0HN69OF0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:31 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_suspend_finish() is not necessary any more, because
acpi_pm_finish() can be used instead of it just fine.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 61c5bd0..5529c70 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -290,11 +290,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
-static void acpi_suspend_finish(void)
-{
-	acpi_pm_finish();
-}
-
 static int acpi_suspend_state_valid(suspend_state_t pm_state)
 {
 	u32 acpi_state;
@@ -316,7 +311,7 @@ static struct platform_suspend_ops acpi_suspend_ops = {
 	.begin = acpi_suspend_begin,
 	.prepare_late = acpi_pm_prepare,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 };
 
@@ -344,7 +339,7 @@ static struct platform_suspend_ops acpi_suspend_ops_old = {
 	.begin = acpi_suspend_begin_old,
 	.prepare_late = acpi_pm_pre_suspend,
 	.enter = acpi_suspend_enter,
-	.wake = acpi_suspend_finish,
+	.wake = acpi_pm_finish,
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
-- 
1.7.2.1.95.g3d045

