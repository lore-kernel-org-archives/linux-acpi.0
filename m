From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] Hibernation: Enter platform hibernation state in a consisten way (rev. 2)
Date: Mon, 27 Aug 2007 14:31:11 +0200
Message-ID: <200708271431.12482.rjw@sisk.pl>
References: <200708270149.52585.rjw@sisk.pl> <200708270151.33307.rjw@sisk.pl> <20070827082405.GE2060@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44887 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbXH0MU1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2007 08:20:27 -0400
In-Reply-To: <20070827082405.GE2060@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Johannes Berg <johannes@sipsolutions.net>, Thomas Renninger <trenn@suse.de>

On Monday, 27 August 2007 10:24, Pavel Machek wrote:
> Hi!
> 
> > Make hibernation_platform_enter() execute the enter-a-sleep-state sequence
> > instead of the mixed shutdown-with-entering-S4 thing.
> > 
> > Replace the shutting down of devices done by kernel_shutdown_prepare(), before
> > entering the ACPI S4 sleep state, with suspending them and the shutting down of
> > sysdevs with calling device_power_down(PMSG_SUSPEND) (just like before entering
> > S1 or S3, but the target state is now S4).  Also, disable the nonboot CPUs
> > before entering the sleep state (S4), which generally always is a good idea.
> > 
> > This is known to fix the "double disk spin down during hibernation" on some
> > machines, eg. HPC nx6325 (ref. http://lkml.org/lkml/2007/8/7/316 and the
> > following thread).  It also generally causes the hibernation state (ACPI S4) to
> > be entered faster.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/disk.c |   55 ++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 41 insertions(+), 14 deletions(-)
> > 
> 
> > +	local_irq_disable();
> > +	error = device_power_down(PMSG_SUSPEND);
> > +	if (!error) {
> > +		error = hibernation_ops->enter();
> > +		/* We should never get here */
> 
> Are you sure it is good idea to enable interrupts/power up devices
> when this happens?

Hm.  No, I'm not.

> AFAICT image is already on disk an intact at this point, safe thing to do is
> while(1);... 

OK

Like this?

---
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
 kernel/power/disk.c |   55 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 14 deletions(-)

Index: linux-2.6.23-rc3/kernel/power/disk.c
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/disk.c
+++ linux-2.6.23-rc3/kernel/power/disk.c
@@ -222,21 +222,48 @@ int hibernation_platform_enter(void)
 {
 	int error;
 
-	if (hibernation_ops) {
-		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
-		/*
-		 * We have cancelled the power transition by running
-		 * hibernation_ops->finish() before saving the image, so we
-		 * should let the firmware know that we're going to enter the
-		 * sleep state after all
-		 */
-		error = hibernation_ops->prepare();
-		sysdev_shutdown();
-		if (!error)
-			error = hibernation_ops->enter();
-	} else {
-		error = -ENOSYS;
+	if (!hibernation_ops)
+		return -ENOSYS;
+
+	/*
+	 * We have cancelled the power transition by running
+	 * hibernation_ops->finish() before saving the image, so we should let
+	 * the firmware know that we're going to enter the sleep state after all
+	 */
+	error = hibernation_ops->start();
+	if (error)
+		return error;
+
+	suspend_console();
+	error = device_suspend(PMSG_SUSPEND);
+	if (error)
+		return error;
+
+	error = hibernation_ops->prepare();
+	if (error)
+		goto Resume_devices;
+
+	error = disable_nonboot_cpus();
+	if (error)
+		goto Finish;
+
+	local_irq_disable();
+	error = device_power_down(PMSG_SUSPEND);
+	if (!error) {
+		hibernation_ops->enter();
+		/* We should never get here */
+		while (1);
 	}
+	local_irq_enable();
+
+	/*
+	 * We don't need to reenable the nonboot CPUs or resume consoles, since
+	 * the system is going to be halted anyway.
+	 */
+ Finish:
+	hibernation_ops->finish();
+ Resume_devices:
+	device_resume();
 	return error;
 }
 
