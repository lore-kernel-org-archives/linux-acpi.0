From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/42] ACPI / PM: acpi_hibernation_enter() need not switch
 interrupts off
Date: Wed, 23 Mar 2011 02:42:28 -0400
Message-ID: <aad83b143008e1d406248803550bfbfc600b6398.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36978 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1CWHHa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:30 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

The function acpi_hibernation_enter() is always called with
interrupts off, so it doesn't need to switch them off and on.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0a81bf1..84f5714 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -457,16 +457,13 @@ static int acpi_hibernation_begin(void)
 static int acpi_hibernation_enter(void)
 {
 	acpi_status status = AE_OK;
-	unsigned long flags = 0;
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	local_irq_save(flags);
 	/* This shouldn't return.  If it returns, we have a problem */
 	status = acpi_enter_sleep_state(ACPI_STATE_S4);
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
-	local_irq_restore(flags);
 
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
-- 
1.7.4.1.343.ga91df

