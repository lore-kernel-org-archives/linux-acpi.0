From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] ACPI / Sleep: Rework enabling wakeup devices
Date: Fri, 2 Jul 2010 00:12:26 +0200
Message-ID: <201007020012.27005.rjw@sisk.pl>
References: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42768 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932585Ab0GAWQy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:16:54 -0400
In-Reply-To: <201007020010.13755.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There is no reason why acpi_enable_wakeup_device() should be called
with interrupts disabled, because it doesn't access hardware.  Thus
it is possible to move it next to acpi_enable_wakeup_device_prep()
and make the ACPI suspend, hibernate and poweroff code more
straightforward.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -70,10 +70,11 @@ static int acpi_sleep_prepare(u32 acpi_s
 
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
@@ -233,7 +234,6 @@ static int acpi_suspend_enter(suspend_st
 	}
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(acpi_state);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
@@ -437,7 +437,6 @@ static int acpi_hibernation_enter(void)
 	ACPI_FLUSH_CPU_CACHE();
 
 	local_irq_save(flags);
-	acpi_enable_wakeup_device(ACPI_STATE_S4);
 	/* This shouldn't return.  If it returns, we have a problem */
 	status = acpi_enter_sleep_state(ACPI_STATE_S4);
 	/* Reprogram control registers and execute _BFS */
@@ -682,7 +681,6 @@ static void acpi_power_off(void)
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
-	acpi_enable_wakeup_device(ACPI_STATE_S5);
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 

