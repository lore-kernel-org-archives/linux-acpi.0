From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/42] ACPI / PM: acpi_suspend_enter() need not switch
 interrupts off
Date: Wed, 23 Mar 2011 02:42:24 -0400
Message-ID: <82911fe1988fadfc9c01673202cbc411aa803244.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36981 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab1CWHHb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:31 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:31 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_suspend_enter() is always called with interrupts
off, so it doesn't need to switch them off and on.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 67dcd38..3b54937 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -243,7 +243,6 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
 static int acpi_suspend_enter(suspend_state_t pm_state)
 {
 	acpi_status status = AE_OK;
-	unsigned long flags = 0;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	ACPI_FLUSH_CPU_CACHE();
@@ -256,7 +255,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 			return error;
 	}
 
-	local_irq_save(flags);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -290,7 +288,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions_early();
 
-	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
 
 	suspend_nvs_restore();
-- 
1.7.4.1.343.ga91df

