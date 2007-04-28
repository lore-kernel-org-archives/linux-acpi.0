From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 1/9] ACPI: thinkpad-acpi: add a fan-control
	feature master toggle
Date: Fri, 27 Apr 2007 21:57:41 -0300
Message-ID: <11777218612968-git-send-email-hmh@hmh.eng.br>
References: <1177721861912-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1177721861912-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown considers that an active by default fan control interface in
laptops may be too close to giving users enough rope.  There is a good
chance he is quite correct on this, especially if someone decides to use
that interface in applets and users are not aware of its risks.

This patch adds a master switch to thinkpad-acpi that enables or disables
the entire fan-control feature as a module parameter: "fan_control".  It
defaults to disabled.  Set it to non-zero to enable fan control.

Also, the patch removes the expermiental status from fan control, since it
is stable enough to not be called experimental, and the master switch makes
it safe enough to do so.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   15 +++++++--------
 drivers/misc/thinkpad_acpi.c    |   30 +++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h    |    2 ++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index eab4997..bca50d7 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -38,7 +38,7 @@ detailed description):
 	- Experimental: embedded controller register dump
 	- LCD brightness control
 	- Volume control
-	- Experimental: fan speed, fan enable/disable
+	- Fan control and monitoring: fan speed, fan enable/disable
 	- Experimental: WAN enable and disable
 
 A compatibility table by model and feature is maintained on the web
@@ -681,21 +681,20 @@ distinct. The unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume).
 The current volume level and mute state is shown in the file.
 
-EXPERIMENTAL: fan speed, fan enable/disable
--------------------------------------------
+Fan control and monitoring: fan speed, fan enable/disable
+---------------------------------------------------------
 
 procfs: /proc/acpi/ibm/fan
 sysfs device attributes: (hwmon) fan_input, pwm1, pwm1_enable
 
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+NOTE NOTE NOTE: fan control operations are disabled by default for
+safety reasons.  To enable them, the module parameter "fan_control=1"
+must be given to thinkpad-acpi.
 
 This feature attempts to show the current fan speed, control mode and
 other fan data that might be available.  The speed is read directly
 from the hardware registers of the embedded controller.  This is known
-to work on later R, T and X series ThinkPads but may show a bogus
+to work on later R, T, X and Z series ThinkPads but may show a bogus
 value on other models.
 
 Fan levels:
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c0a023c..7dc3a22 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2935,6 +2935,9 @@ static ssize_t fan_fan_watchdog_store(struct device_driver *drv,
 	if (parse_strtoul(buf, 120, &t))
 		return -EINVAL;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	fan_watchdog_maxinterval = t;
 	fan_watchdog_reset();
 
@@ -3046,6 +3049,14 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
 		fan_status_access_mode, fan_control_access_mode);
 
+	/* fan control master switch */
+	if (!fan_control_allowed) {
+		fan_control_access_mode = TPACPI_FAN_WR_NONE;
+		fan_control_commands = 0;
+		dbg_printk(TPACPI_DBG_INIT,
+			   "fan control features disabled by parameter\n");
+	}
+
 	/* update fan_control_desired_level */
 	if (fan_status_access_mode != TPACPI_FAN_NONE)
 		fan_get_status_safe(NULL);
@@ -3203,6 +3214,9 @@ static void fan_watchdog_reset(void)
 
 static int fan_set_level(int level)
 {
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		if (level >= 0 && level <= 7) {
@@ -3242,6 +3256,9 @@ static int fan_set_level_safe(int level)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3262,6 +3279,9 @@ static int fan_set_enable(void)
 	u8 s;
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3315,6 +3335,9 @@ static int fan_set_disable(void)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3351,6 +3374,9 @@ static int fan_set_speed(int speed)
 {
 	int rc;
 
+	if (!fan_control_allowed)
+		return -EPERM;
+
 	rc = mutex_lock_interruptible(&fan_mutex);
 	if (rc < 0)
 		return rc;
@@ -3558,7 +3584,6 @@ static struct ibm_struct fan_driver_data = {
 	.read = fan_read,
 	.write = fan_write,
 	.exit = fan_exit,
-	.flags.experimental = 1,
 };
 
 /****************************************************************************
@@ -3879,6 +3904,9 @@ module_param_named(debug, dbg_level, uint, 0);
 static int force_load;
 module_param(force_load, int, 0);
 
+static int fan_control_allowed;
+module_param_named(fan_control, fan_control_allowed, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 8348fc6..a9e7093 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -375,6 +375,8 @@ enum fan_control_commands {
 						 * and also watchdog cmd */
 };
 
+static int fan_control_allowed;
+
 static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
-- 
1.5.1


>From 0ffd0e794b5e4cd0ec88af2e422aad24d75b7538 Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 00:53:21 -0300
Subject: [PATCH 2/9] ACPI: thinkpad-acpi: do not arm fan watchdog if it would not work

Do not enable/rearm the fan control safety watchdog if we would not be able
to do anything to the fan anyway.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7dc3a22..f824259 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3197,6 +3197,9 @@ static void fan_watchdog_reset(void)
 {
 	static int fan_watchdog_active = 0;
 
+	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
+		return;
+
 	if (fan_watchdog_active)
 		cancel_delayed_work(&fan_watchdog_task);
 
-- 
1.5.1


>From 0ad4468cefb154a6e8db14fe7093fce7dc23a87d Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 00:53:34 -0300
Subject: [PATCH 3/9] ACPI: thinkpad-acpi: fix a fan watchdog invocation

The fan control watchdog was being called in one place even when the fan
control operation had failed.  Fix it.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index f824259..b85f096 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2888,9 +2888,10 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	if (!rc && (status &
 		    (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
 		rc = fan_set_level(newlevel);
-		if (!rc)
+		if (!rc) {
 			fan_update_desired_level(newlevel);
-		fan_watchdog_reset();
+			fan_watchdog_reset();
+		}
 	}
 
 	mutex_unlock(&fan_mutex);
-- 
1.5.1


>From 815497180d284bd374d4d534ad82d7a37dba405a Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 09:17:20 -0300
Subject: [PATCH 4/9] ACPI: thinkpad-acpi: map ENXIO to EINVAL for fan sysfs

Currently, all fan control operations return ENXIO if unsupported
operations are requested, but return EINVAL if invalid fan modes are
requested on a given ThinkPad.

This is not strictly correct for sysfs, so map ENXIO to EINVAL in the sysfs
attribute store handlers, as we do benefit from the ENXIO in other parts of
the driver code.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b85f096..7aed118 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2824,7 +2824,9 @@ static ssize_t fan_pwm1_enable_store(struct device *dev,
 	}
 
 	res = fan_set_level_safe(level);
-	if (res < 0)
+	if (res == -ENXIO)
+		return -EINVAL;
+	else if (res < 0)
 		return res;
 
 	fan_watchdog_reset();
@@ -2888,7 +2890,9 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	if (!rc && (status &
 		    (TP_EC_FAN_AUTO | TP_EC_FAN_FULLSPEED)) == 0) {
 		rc = fan_set_level(newlevel);
-		if (!rc) {
+		if (rc == -ENXIO)
+			rc = -EINVAL;
+		else if (!rc) {
 			fan_update_desired_level(newlevel);
 			fan_watchdog_reset();
 		}
-- 
1.5.1


>From a67fdd9acd9a43102fb278283969be10bf53f56f Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 09:22:56 -0300
Subject: [PATCH 5/9] ACPI: thinkpad-acpi: improve fan control documentation

Improve fan control documentation and fix one mistake.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index bca50d7..e3ad7a4 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -795,15 +795,23 @@ Sysfs notes:
 The sysfs interface follows the hwmon subsystem guidelines for the most
 part, and the exception is the fan safety watchdog.
 
+Writes to any of the sysfs attributes may return the EINVAL error if
+that operation is not supported in a given ThinkPad or if the parameter
+is out-of-bounds, and EPERM if it is forbidden.  They may also return
+EINTR (interrupted system call), and EIO (I/O error while trying to talk
+to the firmware).
+
+Features not yet implemented by the driver return ENOSYS.
+
 hwmon device attribute pwm1_enable:
 	0: PWM offline (fan is set to full-speed mode)
 	1: Manual PWM control (use pwm1 to set fan level)
 	2: Hardware PWM control (EC "auto" mode)
 	3: reserved (Software PWM control, not implemented yet)
 
-	Modes 0 and 2 are not supported by all ThinkPads, and the driver
-	is not always able to detect this.  If it does know a mode is
-	unsupported, it will return -EINVAL.
+	Modes 0 and 2 are not supported by all ThinkPads, and the
+	driver is not always able to detect this.  If it does know a
+	mode is unsupported, it will return -EINVAL.
 
 hwmon device attribute pwm1:
 	Fan level, scaled from the firmware values of 0-7 to the hwmon
@@ -826,8 +834,8 @@ driver attribute fan_watchdog:
 To stop the fan: set pwm1 to zero, and pwm1_enable to 1.
 
 To start the fan in a safe mode: set pwm1_enable to 2.  If that fails
-with ENOTSUP, set it to 1 and set pwm1 to at least 128 (255 would be the
-safest choice, though).
+with EINVAL, try to set pwm1_enable to 1 and pwm1 to at least 128 (255
+would be the safest choice, though).
 
 
 EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
-- 
1.5.1


>From 8ed7a9aafd465f22282421f6e9db99e17d9412f4 Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 10:51:43 -0300
Subject: [PATCH 6/9] ACPI: thinkpad-acpi: improve debugging for acpi helpers

Some issues with the dock subdriver proved that a slightly improved
debugging setup for ACPI notifiers and handler helpers would be useful.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7aed118..68f1cc0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -296,14 +296,22 @@ static void drv_acpi_handle_init(char *name,
 	int i;
 	acpi_status status;
 
+	vdbg_printk(TPACPI_DBG_INIT, "trying to locate ACPI handle for %s\n",
+		name);
+
 	for (i = 0; i < num_paths; i++) {
 		status = acpi_get_handle(parent, paths[i], handle);
 		if (ACPI_SUCCESS(status)) {
 			*path = paths[i];
+			dbg_printk(TPACPI_DBG_INIT,
+				   "Found ACPI handle %s for %s\n",
+				   *path, name);
 			return;
 		}
 	}
 
+	vdbg_printk(TPACPI_DBG_INIT, "ACPI handle for %s not found\n",
+		    name);
 	*handle = NULL;
 }
 
@@ -320,19 +328,20 @@ static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int __init setup_acpi_notify(struct ibm_struct *ibm)
 {
 	acpi_status status;
-	int ret;
+	int rc;
 
 	BUG_ON(!ibm->acpi);
 
 	if (!*ibm->acpi->handle)
 		return 0;
 
-	dbg_printk(TPACPI_DBG_INIT,
+	vdbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	ret = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
-	if (ret < 0) {
-		printk(IBM_ERR "%s device not present\n", ibm->name);
+	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
+	if (rc < 0) {
+		printk(IBM_ERR "acpi_bus_get_device(%s) failed: %d\n",
+			ibm->name, rc);
 		return -ENODEV;
 	}
 
@@ -364,7 +373,7 @@ static int __init tpacpi_device_add(struct acpi_device *device)
 
 static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 {
-	int ret;
+	int rc;
 
 	dbg_printk(TPACPI_DBG_INIT,
 		"registering %s as an ACPI driver\n", ibm->name);
@@ -381,16 +390,16 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 	ibm->acpi->driver->ids = ibm->acpi->hid;
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
-	ret = acpi_bus_register_driver(ibm->acpi->driver);
-	if (ret < 0) {
+	rc = acpi_bus_register_driver(ibm->acpi->driver);
+	if (rc < 0) {
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->acpi->hid, ret);
+		       ibm->acpi->hid, rc);
 		kfree(ibm->acpi->driver);
 		ibm->acpi->driver = NULL;
-	} else if (!ret)
+	} else if (!rc)
 		ibm->flags.acpi_driver_registered = 1;
 
-	return ret;
+	return rc;
 }
 
 
-- 
1.5.1


>From a0ef99724ed0656df1e48ffe511eefc1f87cf608 Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Thu, 26 Apr 2007 11:27:15 -0300
Subject: [PATCH 7/9] ACPI: thinkpad-acpi: improve dock subdriver initialization

The dock sub-driver has split-personality (two subdrivers), and it was
doing some unoptimal things on init because of that.  Fix it so that the
second half of it will only init when necessary, and only if the first half
initialized sucessfully in the first place.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   78 +++++++++++++++++++++++++++---------------
 1 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 68f1cc0..a565265 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1519,6 +1519,33 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
+static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
+	{
+	 .notify = dock_notify,
+	 .handle = &dock_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+	{
+	 .hid = IBM_PCI_HID,
+	 .notify = dock_notify,
+	 .handle = &pci_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+};
+
+static struct ibm_struct dock_driver_data[2] = {
+	{
+	 .name = "dock",
+	 .read = dock_read,
+	 .write = dock_write,
+	 .acpi = &ibm_dock_acpidriver[0],
+	},
+	{
+	 .name = "dock",
+	 .acpi = &ibm_dock_acpidriver[1],
+	},
+};
+
 #define dock_docked() (_sta(dock_handle) & 1)
 
 static int __init dock_init(struct ibm_init_struct *iibm)
@@ -1526,7 +1553,6 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(dock);
-	IBM_ACPIHANDLE_INIT(pci);
 
 	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
 		str_supported(dock_handle != NULL));
@@ -1534,6 +1560,28 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	return (dock_handle)? 0 : 1;
 }
 
+static int __init dock_init2(struct ibm_init_struct *iibm)
+{
+	int dock2_needed;
+
+	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver part 2\n");
+
+	if (dock_driver_data[0].flags.acpi_driver_registered &&
+	    dock_driver_data[0].flags.acpi_notify_installed) {
+		IBM_ACPIHANDLE_INIT(pci);
+		dock2_needed = (pci_handle != NULL);
+		vdbg_printk(TPACPI_DBG_INIT,
+			    "dock PCI handler for the TP 570 is %s\n",
+			    str_supported(dock2_needed));
+	} else {
+		vdbg_printk(TPACPI_DBG_INIT,
+		"dock subdriver part 2 not required\n");
+		dock2_needed = 0;
+	}
+
+	return (dock2_needed)? 0 : 1;
+}
+
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
@@ -1595,33 +1643,6 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
-	{
-	 .notify = dock_notify,
-	 .handle = &dock_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-	{
-	 .hid = IBM_PCI_HID,
-	 .notify = dock_notify,
-	 .handle = &pci_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-};
-
-static struct ibm_struct dock_driver_data[2] = {
-	{
-	 .name = "dock",
-	 .read = dock_read,
-	 .write = dock_write,
-	 .acpi = &ibm_dock_acpidriver[0],
-	},
-	{
-	 .name = "dock",
-	 .acpi = &ibm_dock_acpidriver[1],
-	},
-};
-
 #endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
@@ -3850,6 +3871,7 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.data = &dock_driver_data[0],
 	},
 	{
+		.init = dock_init2,
 		.data = &dock_driver_data[1],
 	},
 #endif
-- 
1.5.1


>From d4e6aca89bdaf437ccf62f3b186276faafd926ba Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Mon, 19 Feb 2007 13:45:10 -0200
Subject: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver

Add the hotkey sysfs support.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   58 ++++++++++++++----
 drivers/misc/thinkpad_acpi.c    |  127 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.h    |    2 +
 3 files changed, 176 insertions(+), 11 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index e3ad7a4..ebeed58 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -134,8 +134,11 @@ end of this document.  Changes to the sysfs interface done by the kernel
 subsystems are not documented here, nor are they tracked by this
 attribute.
 
-Hot keys -- /proc/acpi/ibm/hotkey
----------------------------------
+Hot keys
+--------
+
+procfs: /proc/acpi/ibm/hotkey
+sysfs device attribute: hotkey/*
 
 Without this driver, only the Fn-F4 key (sleep button) generates an
 ACPI event. With the driver loaded, the hotkey feature enabled and the
@@ -149,15 +152,6 @@ All labeled Fn-Fx key combinations generate distinct events. In
 addition, the lid microswitch and some docking station buttons may
 also generate such events.
 
-The following commands can be written to this file:
-
-	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
-	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
-	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
-	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
-	... any other 4-hex-digit mask ...
-	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
-
 The bit mask allows some control over which hot keys generate ACPI
 events. Not all bits in the mask can be modified. Not all bits that
 can be modified do anything. Not all hot keys can be individually
@@ -189,6 +183,48 @@ buttons do not generate ACPI events even with this driver. They *can*
 be used through the "ThinkPad Buttons" utility, see
 http://www.nongnu.org/tpb/
 
+procfs notes:
+
+The following commands can be written to the /proc/acpi/ibm/hotkey file:
+
+	echo enable > /proc/acpi/ibm/hotkey -- enable the hot keys feature
+	echo disable > /proc/acpi/ibm/hotkey -- disable the hot keys feature
+	echo 0xffff > /proc/acpi/ibm/hotkey -- enable all possible hot keys
+	echo 0x0000 > /proc/acpi/ibm/hotkey -- disable all possible hot keys
+	... any other 4-hex-digit mask ...
+	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
+
+sysfs notes:
+
+	The hot keys attributes are in a hotkey/ subdirectory off the
+	thinkpad device.
+
+	bios_enabled:
+		Returns the status of the hot keys feature when
+		thinkpad-acpi was loaded.  Upon module unload, the hot
+		key feature status will be restored to this value.
+
+		0: hot keys were disabled
+		1: hot keys were enabled
+
+	bios_mask:
+		Returns the hot keys mask when thinkpad-acpi was loaded.
+		Upon module unload, the hot keys mask will be restored
+		to this value.
+
+	enable:
+		Enables/disables the hot keys feature, and reports
+		current status of the hot keys feature.
+
+		0: disables the hot keys feature / feature disabled
+		1: enables the hot keys feature / feature enabled
+
+	mask:
+		bit mask to enable ACPI event generation for each hot
+		key (see above).  Returns the current status of the hot
+		keys mask, and allows one to modify it.
+
+
 Bluetooth -- /proc/acpi/ibm/bluetooth
 -------------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a565265..83a8d98 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -706,6 +706,108 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
+static struct attribute_set *hotkey_dev_attributes = NULL;
+
+/* sysfs hotkey enable ------------------------------------------------- */
+static ssize_t hotkey_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, status, mask;
+
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status);
+}
+
+static ssize_t hotkey_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res, status, mask;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = hotkey_get(&status, &mask);
+	if (!res)
+		res = hotkey_set(t, mask);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_hotkey_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		hotkey_enable_show, hotkey_enable_store);
+
+/* sysfs hotkey mask --------------------------------------------------- */
+static ssize_t hotkey_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int res, status, mask;
+
+	res = hotkey_get(&status, &mask);
+	if (res)
+		return res;
+
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", mask);
+}
+
+static ssize_t hotkey_mask_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res, status, mask;
+
+	if (parse_strtoul(buf, 0xffff, &t))
+		return -EINVAL;
+
+	res = hotkey_get(&status, &mask);
+	if (!res)
+		hotkey_set(status, t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_hotkey_mask =
+	__ATTR(mask, S_IWUSR | S_IRUGO,
+		hotkey_mask_show, hotkey_mask_store);
+
+/* sysfs hotkey bios_enabled ------------------------------------------- */
+static ssize_t hotkey_bios_enabled_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_orig_status);
+}
+
+static struct device_attribute dev_attr_hotkey_bios_enabled =
+	__ATTR(bios_enabled, S_IRUGO, hotkey_bios_enabled_show, NULL);
+
+/* sysfs hotkey bios_mask ---------------------------------------------- */
+static ssize_t hotkey_bios_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%04x\n", hotkey_orig_mask);
+}
+
+static struct device_attribute dev_attr_hotkey_bios_mask =
+	__ATTR(bios_mask, S_IRUGO, hotkey_bios_mask_show, NULL);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *hotkey_mask_attributes[] = {
+	&dev_attr_hotkey_mask.attr,
+	&dev_attr_hotkey_bios_enabled.attr,
+	&dev_attr_hotkey_bios_mask.attr,
+};
+
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	int res;
@@ -722,6 +824,15 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
+		hotkey_dev_attributes = create_attr_set(4,
+						TPACPI_HOTKEY_SYSFS_GROUP);
+		if (!hotkey_dev_attributes)
+			return -ENOMEM;
+		res = add_to_attr_set(hotkey_dev_attributes,
+				&dev_attr_hotkey_enable.attr);
+		if (res)
+			return res;
+
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 		   A30, R30, R31, T20-22, X20-21, X22-24 */
 		tp_features.hotkey_mask =
@@ -731,6 +842,16 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			str_supported(tp_features.hotkey_mask));
 
 		res = hotkey_get(&hotkey_orig_status, &hotkey_orig_mask);
+		if (!res && tp_features.hotkey_mask) {
+			res = add_many_to_attr_set(hotkey_dev_attributes,
+				hotkey_mask_attributes,
+				ARRAY_SIZE(hotkey_mask_attributes));
+		}
+		if (!res)
+			res = register_attr_set_with_sysfs(
+					hotkey_dev_attributes,
+					&tpacpi_pdev->dev.kobj);
+
 		if (res)
 			return res;
 	}
@@ -748,6 +869,11 @@ static void hotkey_exit(void)
 		if (res)
 			printk(IBM_ERR "failed to restore hotkey to BIOS defaults\n");
 	}
+
+	if (hotkey_dev_attributes) {
+		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
+		hotkey_dev_attributes = NULL;
+	}
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -798,6 +924,7 @@ static int hotkey_set(int status, int mask)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int hotkey_read(char *p)
 {
 	int res, status, mask;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index a9e7093..7615adb 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -414,6 +414,8 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
  * Hotkey subdriver
  */
 
+#define TPACPI_HOTKEY_SYSFS_GROUP "hotkey"
+
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
-- 
1.5.1


>From 685f6397efbd0dec2aff99d5c27cac8179530621 Mon Sep 17 00:00:00 2001
From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Date: Mon, 19 Feb 2007 13:45:11 -0200
Subject: [PATCH 9/9] ACPI: thinkpad-acpi: add sysfs support to wan and bluetooth subdrivers

Add support to sysfs to the wan and bluetooth subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   61 ++++++++++++++---
 drivers/misc/thinkpad_acpi.c    |  144 +++++++++++++++++++++++++++++++++++---
 drivers/misc/thinkpad_acpi.h    |    4 +
 3 files changed, 186 insertions(+), 23 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index ebeed58..2d48033 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -225,15 +225,35 @@ sysfs notes:
 		keys mask, and allows one to modify it.
 
 
-Bluetooth -- /proc/acpi/ibm/bluetooth
--------------------------------------
+Bluetooth
+---------
 
-This feature shows the presence and current state of a Bluetooth
-device. If Bluetooth is installed, the following commands can be used:
+procfs: /proc/acpi/ibm/bluetooth
+sysfs device attribute: bluetooth/enable
+
+This feature shows the presence and current state of a ThinkPad
+Bluetooth device in the internal ThinkPad CDC slot.
+
+Procfs notes:
+
+If Bluetooth is installed, the following commands can be used:
 
 	echo enable > /proc/acpi/ibm/bluetooth
 	echo disable > /proc/acpi/ibm/bluetooth
 
+Sysfs notes:
+
+	If the Bluetooth CDC card is installed, it can be enabled /
+	disabled through the "bluetooth/enable" thinkpad-acpi device
+	attribute, and its current status can also be queried.
+
+	enable:
+		0: disables Bluetooth / Bluetooth is disabled
+		1: enables Bluetooth / Bluetooth is enabled.
+
+	Note: this interface will be probably be superseeded by the
+	generic rfkill class.
+
 Video output control -- /proc/acpi/ibm/video
 --------------------------------------------
 
@@ -874,23 +894,42 @@ with EINVAL, try to set pwm1_enable to 1 and pwm1 to at least 128 (255
 would be the safest choice, though).
 
 
-EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
----------------------------------------
+EXPERIMENTAL: WAN
+-----------------
+
+procfs: /proc/acpi/ibm/wan
+sysfs device attribute: wwan/enable
 
 This feature is marked EXPERIMENTAL because the implementation
 directly accesses hardware registers and may not work as expected. USE
 WITH CAUTION! To use this feature, you need to supply the
 experimental=1 parameter when loading the module.
 
-This feature shows the presence and current state of a WAN (Sierra
-Wireless EV-DO) device. If WAN is installed, the following commands can
-be used:
+This feature shows the presence and current state of a W-WAN (Sierra
+Wireless EV-DO) device.
+
+It was tested on a Lenovo Thinkpad X60. It should probably work on other
+Thinkpad models which come with this module installed.
+
+Procfs notes:
+
+If the W-WAN card is installed, the following commands can be used:
 
 	echo enable > /proc/acpi/ibm/wan
 	echo disable > /proc/acpi/ibm/wan
 
-It was tested on a Lenovo Thinkpad X60. It should probably work on other
-Thinkpad models which come with this module installed.
+Sysfs notes:
+
+	If the W-WAN card is installed, it can be enabled /
+	disabled through the "wwan/enable" thinkpad-acpi device
+	attribute, and its current status can also be queried.
+
+	enable:
+		0: disables WWAN card / WWAN card is disabled
+		1: enables WWAN card / WWAN card is enabled.
+
+	Note: this interface will be probably be superseeded by the
+	generic rfkill class.
 
 Multiple Commands, Module Parameters
 ------------------------------------
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 83a8d98..6c36a55 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1020,8 +1020,54 @@ static struct ibm_struct hotkey_driver_data = {
  * Bluetooth subdriver
  */
 
+/* sysfs bluetooth enable ---------------------------------------------- */
+static ssize_t bluetooth_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int status;
+
+	status = bluetooth_get_radiosw();
+	if (status < 0)
+		return status;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+}
+
+static ssize_t bluetooth_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = bluetooth_set_radiosw(t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_bluetooth_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		bluetooth_enable_show, bluetooth_enable_store);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *bluetooth_attributes[] = {
+	&dev_attr_bluetooth_enable.attr,
+	NULL
+};
+
+static const struct attribute_group bluetooth_attr_group = {
+	.name = TPACPI_BLUETH_SYSFS_GROUP,
+	.attrs = bluetooth_attributes,
+};
+
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
+	int res;
 	int status = 0;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
@@ -1037,17 +1083,29 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.bluetooth),
 		status);
 
-	if (tp_features.bluetooth &&
-	    !(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
-		/* no bluetooth hardware present in system */
-		tp_features.bluetooth = 0;
-		dbg_printk(TPACPI_DBG_INIT,
-			   "bluetooth hardware not installed\n");
+	if (tp_features.bluetooth) {
+		if (!(status & TP_ACPI_BLUETOOTH_HWPRESENT)) {
+			/* no bluetooth hardware present in system */
+			tp_features.bluetooth = 0;
+			dbg_printk(TPACPI_DBG_INIT,
+				   "bluetooth hardware not installed\n");
+		} else {
+			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					&bluetooth_attr_group);
+			if (res)
+				return res;
+		}
 	}
 
 	return (tp_features.bluetooth)? 0 : 1;
 }
 
+static void bluetooth_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			&bluetooth_attr_group);
+}
+
 static int bluetooth_get_radiosw(void)
 {
 	int status;
@@ -1080,6 +1138,7 @@ static int bluetooth_set_radiosw(int radio_on)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int bluetooth_read(char *p)
 {
 	int len = 0;
@@ -1119,14 +1178,61 @@ static struct ibm_struct bluetooth_driver_data = {
 	.name = "bluetooth",
 	.read = bluetooth_read,
 	.write = bluetooth_write,
+	.exit = bluetooth_exit,
 };
 
 /*************************************************************************
  * Wan subdriver
  */
 
+/* sysfs wan enable ---------------------------------------------------- */
+static ssize_t wan_enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	int status;
+
+	status = wan_get_radiosw();
+	if (status < 0)
+		return status;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", status ? 1 : 0);
+}
+
+static ssize_t wan_enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	res = wan_set_radiosw(t);
+
+	return (res) ? res : count;
+}
+
+static struct device_attribute dev_attr_wan_enable =
+	__ATTR(enable, S_IWUSR | S_IRUGO,
+		wan_enable_show, wan_enable_store);
+
+/* --------------------------------------------------------------------- */
+
+static struct attribute *wan_attributes[] = {
+	&dev_attr_wan_enable.attr,
+	NULL
+};
+
+static const struct attribute_group wan_attr_group = {
+	.name = TPACPI_WAN_SYSFS_GROUP,
+	.attrs = wan_attributes,
+};
+
 static int __init wan_init(struct ibm_init_struct *iibm)
 {
+	int res;
 	int status = 0;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
@@ -1140,17 +1246,29 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.wan),
 		status);
 
-	if (tp_features.wan &&
-	    !(status & TP_ACPI_WANCARD_HWPRESENT)) {
-		/* no wan hardware present in system */
-		tp_features.wan = 0;
-		dbg_printk(TPACPI_DBG_INIT,
-			   "wan hardware not installed\n");
+	if (tp_features.wan) {
+		if (!(status & TP_ACPI_WANCARD_HWPRESENT)) {
+			/* no wan hardware present in system */
+			tp_features.wan = 0;
+			dbg_printk(TPACPI_DBG_INIT,
+				   "wan hardware not installed\n");
+		} else {
+			res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+					&wan_attr_group);
+			if (res)
+				return res;
+		}
 	}
 
 	return (tp_features.wan)? 0 : 1;
 }
 
+static void wan_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+		&wan_attr_group);
+}
+
 static int wan_get_radiosw(void)
 {
 	int status;
@@ -1183,6 +1301,7 @@ static int wan_set_radiosw(int radio_on)
 	return 0;
 }
 
+/* procfs -------------------------------------------------------------- */
 static int wan_read(char *p)
 {
 	int len = 0;
@@ -1222,6 +1341,7 @@ static struct ibm_struct wan_driver_data = {
 	.name = "wan",
 	.read = wan_read,
 	.write = wan_write,
+	.exit = wan_exit,
 	.flags.experimental = 1,
 };
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 7615adb..a6c2855 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -278,6 +278,8 @@ static int beep_write(char *buf);
  * Bluetooth subdriver
  */
 
+#define TPACPI_BLUETH_SYSFS_GROUP "bluetooth"
+
 enum {
 	/* ACPI GBDC/SBDC bits */
 	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
@@ -551,6 +553,8 @@ static int volume_write(char *buf);
  * Wan subdriver
  */
 
+#define TPACPI_WAN_SYSFS_GROUP "wwan"
+
 enum {
 	/* ACPI GWAN/SWAN bits */
 	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
