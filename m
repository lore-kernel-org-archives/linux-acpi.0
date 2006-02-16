From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: confused fan after S3 resume (TP 600X)
Date: Thu, 16 Feb 2006 03:15:16 -0500
Message-ID: <E1F9eIG-00010e-Jm@approximate.corpus.cam.ac.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:50889 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932514AbWBPIPW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Feb 2006 03:15:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

System: 2.6.16-rc2 (and on many kernels in between 2.6.15 and 2.6.16-rc2)
Hardware: TP 600X + modified DSDT

After S3 resume, the fan returns confused.  Before the suspend, all is
good.  When it's hot the fan is on, and the system thinks that the fan
is on:

  $ acpi -t
       Battery 1: charged, 99%
       Battery 2: charged, 99%
       Thermal 1: ok, 46.0 degrees C
       Thermal 2: active[0], 42.0 degrees C
       Thermal 3: ok, 32.0 degrees C
       Thermal 4: ok, 35.0 degrees C

Then I suspend with a minimal configuration (only intel_agp, agpgart,
thermal, processor loaded) and it wakes up saying:

  $ acpi -t
       Thermal 1: ok, 47.0 degrees C
       Thermal 2: active[0], 41.0 degrees C
       Thermal 3: ok, 32.0 degrees C
       Thermal 4: ok, 35.0 degrees C

but fan isn't on despite the 'active'.  Setting THM2 trip point to 42,
then to 39 turns it on.  Strangely, setting it to 39 right away, so
without first setting it to 42, doesn't turn it on.

First theory: On sleep, the machine turns off the fan.  On wakeup, the
thermal module doesn't check whether the fan should be turned back on.
Only when a trip point is crossed (or changed?) does it turn on.  So I
added a _resume method to thermal.c to call acpi_thermal_check().
However, that didn't fix the problem.

Second theory: acpi_thermal_active(), called by acpi_thermal_check(),
correctly knew that the fan should be on, but thought that it was
already on.  So I added a _suspend() method that unset the enabled
flags, the theory being that since the hardware turned off the fan, ACPI
should be told that it's off.  The second theory is embodied in the
patch below.  It didn't help either, but maybe someone has a better
idea.  Do the .valid flags need to be set (or ignored) in the _resume()
method?

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 19f3ea4..f6fdb62 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -81,6 +81,8 @@ module_param(tzp, int, 0);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
 
 static int acpi_thermal_add(struct acpi_device *device);
+static int acpi_thermal_suspend(struct acpi_device *device, int state);
+static int acpi_thermal_resume(struct acpi_device *device, int state);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
@@ -103,6 +105,10 @@ static struct acpi_driver acpi_thermal_d
 	.ops = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
+#ifdef	CONFIG_PM
+		.suspend = acpi_thermal_suspend,
+		.resume = acpi_thermal_resume,
+#endif	/* PM */
 		},
 };
 
@@ -1371,6 +1377,51 @@ static int acpi_thermal_add(struct acpi_
 	return_VALUE(result);
 }
 
+static int acpi_thermal_suspend(struct acpi_device *device, int state) {
+	int i;
+	struct acpi_thermal_active *active = NULL;
+	struct acpi_thermal *tz = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_thermal_suspend");
+
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+
+	tz = (struct acpi_thermal *)acpi_driver_data(device);
+
+	/* The hardware shuts off the fans, so tell ACPI that they are
+	   off.  If the active flag is not disabled, then
+	   acpi_thermal_check(), part of the _resume method, will not
+	   check whether the fan needs to be turned on (it will assume
+	   that it is on, because the flag says it is). */
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		active = &(tz->trips.active[i]);
+		if (!active || !active->flags.valid)
+			break;
+		active->flags.enabled = 0;
+	}
+	return_VALUE(AE_OK);
+}
+
+static int acpi_thermal_resume(struct acpi_device *device, int state)
+{
+	struct acpi_thermal *tz = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_thermal_resume");
+
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+
+	tz = (struct acpi_thermal *)acpi_driver_data(device);
+	acpi_thermal_check(tz);
+
+	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
+	       acpi_device_name(device), acpi_device_bid(device),
+	       KELVIN_TO_CELSIUS(tz->temperature));
+
+	return_VALUE(AE_OK);
+}
+
 static int acpi_thermal_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = AE_OK;
