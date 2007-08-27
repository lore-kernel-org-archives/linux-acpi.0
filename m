From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 1/3] Hibernation: Enter platform hibernation state in a consistent way (rev. 3)
Date: Mon, 27 Aug 2007 23:49:20 +0200
Message-ID: <200708272349.21184.rjw@sisk.pl>
References: <200708272347.45438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764386AbXH0Vzy@vger.kernel.org>
In-Reply-To: <200708272347.45438.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

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
Acked-by: Pavel Machek <pavel@ucw.cz>
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
 
