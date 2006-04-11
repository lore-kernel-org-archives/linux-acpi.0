From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Power-button event after resume from S3
Date: Tue, 11 Apr 2006 03:35:15 +0100
Message-ID: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk>
References: <554C5F4C5BA7384EB2B412FD46A3BAD11E39CC@pdsmsx411.ccr.corp.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:14781 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932260AbWDKCfT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Apr 2006 22:35:19 -0400
In-Reply-To: Your message of "Tue, 11 Apr 2006 09:11:18 +0800."
             <554C5F4C5BA7384EB2B412FD46A3BAD11E39CC@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Felix Kuehling <fkuehlin@ati.com>, linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

>  if(acpi_during_suspend_resume)
>	don't generate power button event to confuse user space daemon

This patch might be useful useful in setting and unsetting
acpi_during_suspend_resume (and also using it, but you should ignore
those as they are hacks for a different problem).  The equivalent
variable in the patch below is acpi_in_suspend.

diff -r ac486e270597 -r abd89292c539 drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/osl.c	Thu Mar 30 10:59:57 2006 -0500
@@ -634,6 +634,8 @@ static void acpi_os_execute_deferred(voi
 	return_VOID;
 }
 
+extern int acpi_in_suspend;
+
 acpi_status
 acpi_os_queue_for_execution(u32 priority,
 			    acpi_osd_exec_callback function, void *context)
@@ -643,6 +645,8 @@ acpi_os_queue_for_execution(u32 priority
 	struct work_struct *task;
 
 	ACPI_FUNCTION_TRACE("os_queue_for_execution");
+	if (acpi_in_suspend)	/* in case kacpid is causing the queue */
+		return_ACPI_STATUS(AE_OK);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.
\n",
diff -r ac486e270597 -r abd89292c539 drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/sleep/main.c	Thu Mar 30 10:59:57 2006 -0500
@@ -19,6 +19,12 @@
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
 
+/* for functions putting machine to sleep to know that we're
+   suspending, so that they can careful about what AML methods they
+   invoke (to avoid trying untested BIOS code paths) */
+int acpi_in_suspend;
+EXPORT_SYMBOL(acpi_in_suspend);
+
 u8 sleep_states[ACPI_S_STATE_COUNT];
 
 static struct pm_ops acpi_pm_ops;
@@ -55,6 +61,8 @@ static int acpi_pm_prepare(suspend_state
 		printk("acpi_pm_prepare does not support %d \n", pm_state);
 		return -EPERM;
 	}
+	acpi_os_wait_events_complete(NULL);
+	acpi_in_suspend = TRUE;
 	return acpi_sleep_prepare(acpi_state);
 }
 
@@ -132,6 +140,7 @@ static int acpi_pm_finish(suspend_state_
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
 	acpi_leave_sleep_state(acpi_state);
+	acpi_in_suspend = FALSE;
 	acpi_disable_wakeup_device(acpi_state);
 
 	/* reset firmware waking vector */
diff -r ac486e270597 -r abd89292c539 drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/thermal.c	Thu Mar 30 10:59:57 2006 -0500
@@ -79,6 +79,8 @@ static int tzp;
 static int tzp;
 module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
+
+extern int acpi_in_suspend;
 
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
@@ -683,6 +685,8 @@ static void acpi_thermal_run(unsigned lo
 static void acpi_thermal_run(unsigned long data)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)data;
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return_VOID;	/* so don't do them */
 	if (!tz->zombie)
 		acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
 					    acpi_thermal_check, (void *)data);
@@ -705,6 +709,8 @@ static void acpi_thermal_check(void *dat
 
 	state = tz->state;
 
+	if (acpi_in_suspend)
+		return_VOID;
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
 		return_VOID;
@@ -1224,6 +1230,9 @@ static void acpi_thermal_notify(acpi_han
 	struct acpi_device *device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_notify");
+
+	if (acpi_in_suspend)	/* thermal methods might cause a hang */
+		return_VOID;	/* so don't do them */
 
 	if (!tz)
 		return_VOID;
