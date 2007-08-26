From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/3] Hibernation: Enter platform hibernation state in a consisten way
Date: Sun, 26 Aug 2007 15:14:06 +0200
Message-ID: <200708261514.06716.rjw@sisk.pl>
References: <200708261509.40118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40543 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbXHZNG1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Aug 2007 09:06:27 -0400
In-Reply-To: <200708261509.40118.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Thomas Renninger <trenn@suse.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make hibernation_platform_enter() execute the enter-a-sleep-state sequence
instead of the mixed shutdown-with-entering-S4 thing.

Replace the shutting down of devices done by kernel_shutdown_prepare(), before
entering the ACPI S4 sleep state, with suspending them and the shutting down of
sysdevs with calling device_power_down(PMSG_SUSPEND) (just like before entering
S1 or S3, but the target state is now S4).  Also, disable the nonboot CPUs
before entering the sleep state (S4), which generally always is a good idea.

This is known to fix the "double disk spin down during hibernation" on some
machines, eg. HPC nx6325 (ref. http://lkml.org/lkml/2007/8/7/316 and the
following thread).  It also generally causes the hibernation state (ACPI S4) to
be entered faster.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc3/kernel/power/disk.c
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/disk.c
+++ linux-2.6.23-rc3/kernel/power/disk.c
@@ -223,15 +223,23 @@ int hibernation_platform_enter(void)
 	int error;
 
 	if (hibernation_ops) {
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
 		/*
 		 * We have cancelled the power transition by running
 		 * hibernation_ops->finish() before saving the image, so we
 		 * should let the firmware know that we're going to enter the
 		 * sleep state after all
 		 */
-		error = hibernation_ops->prepare();
-		sysdev_shutdown();
+		error = hibernation_ops->start();
+		if (!error) {
+			suspend_console();
+			error = device_suspend(PMSG_SUSPEND);
+		}
+		if (!error)
+			error = hibernation_ops->prepare();
+		if (!error)
+			error = disable_nonboot_cpus();
+		if (!error)
+			error = device_power_down(PMSG_SUSPEND);
 		if (!error)
 			error = hibernation_ops->enter();
 	} else {

