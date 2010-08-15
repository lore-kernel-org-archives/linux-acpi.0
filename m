From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/20] ACPI / Sleep: Rework enabling wakeup devices
Date: Sun, 15 Aug 2010 01:23:06 -0400
Message-ID: <25bed55753b8cf243406e8837990b55946c5278d.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:65055 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0HOFX3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:29 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L76002IHHN4ANF0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:29 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There is no reason why acpi_enable_wakeup_device() should be called
with interrupts disabled, because it doesn't access hardware.  Thus
it is possible to move it next to acpi_enable_wakeup_device_prep()
and make the ACPI suspend, hibernate and poweroff code more
straightforward.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index da68ed2..8704ca78 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -70,10 +70,11 @@ static int acpi_sleep_prepare(u32 acpi_state)
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
-	acpi_enable_wakeup_device_prep(acpi_state);
 #endif
 	printk(KERN_INFO PREFIX "Preparing to enter system sleep state S%d\n",
 		acpi_state);
+	acpi_enable_wakeup_device_prep(acpi_state);
+	acpi_enable_wakeup_device(acpi_state);
 	acpi_enter_sleep_state_prep(acpi_state);
 	return 0;
 }
@@ -238,7 +239,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	}
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(acpi_state);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -442,7 +442,6 @@ static int acpi_hibernation_enter(void)
 	ACPI_FLUSH_CPU_CACHE();
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(ACPI_STATE_S4);
 	/* This shouldn't return.  If it returns, we have a problem */
 	status = acpi_enter_sleep_state(ACPI_STATE_S4);
 	/* Reprogram control registers and execute _BFS */
@@ -696,7 +695,6 @@ static void acpi_power_off(void)
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
-	acpi_enable_wakeup_device(ACPI_STATE_S5);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
-- 
1.7.2.1.95.g3d045

