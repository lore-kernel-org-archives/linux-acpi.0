From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/9] Suspend: Use common prefix in messages
Date: Sat, 8 Dec 2007 02:08:38 +0100
Message-ID: <200712080208.39104.rjw@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38246 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbXLHAzx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 19:55:53 -0500
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make suspend messages start with one common prefix "PM: ".

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -227,7 +227,7 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(!irqs_disabled());
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
-		printk(KERN_ERR "Some devices failed to power down\n");
+		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Done;
 	}
 
@@ -261,7 +261,7 @@ int suspend_devices_and_enter(suspend_st
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "Some devices failed to suspend\n");
+		printk(KERN_ERR "PM: Some devices failed to suspend\n");
 		goto Resume_console;
 	}
 
@@ -344,7 +344,7 @@ static int enter_state(suspend_state_t s
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
-	printk("Syncing filesystems ... ");
+	printk(KERN_INFO "PM: Syncing filesystems ... ");
 	sys_sync();
 	printk("done.\n");
 
