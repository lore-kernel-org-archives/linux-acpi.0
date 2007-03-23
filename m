From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/7] ACPI: ibm-acpi: organize code
Date: Fri, 23 Mar 2007 17:33:57 -0300
Message-ID: <11746820412004-git-send-email-hmh@hmh.eng.br>
References: <11746820402862-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51210 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992550AbXCWUeL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Mar 2007 16:34:11 -0400
In-Reply-To: <11746820402862-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Shuffle code around to better organize the driver code inside the
ibm-acpi.c file.

This patch adds no functional changes.  It is pure fluff that will make me
a bit more productive.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/ibm_acpi.c | 1398 +++++++++++++++++++++++++----------------------
 1 files changed, 757 insertions(+), 641 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index e2da954..984ec81 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -87,8 +87,17 @@ MODULE_LICENSE("GPL");
 
 #define __unused __attribute__ ((unused))
 
-static int experimental;
-module_param(experimental, int, 0);
+/****************************************************************************
+ ****************************************************************************
+ *
+ * ACPI Helpers and device model
+ *
+ ****************************************************************************
+ ****************************************************************************/
+
+/*************************************************************************
+ * ACPI basic handles
+ */
 
 static acpi_handle root_handle = NULL;
 
@@ -105,183 +114,31 @@ IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 	   "\\_SB.PCI0.AD4S.EC0",	/* i1400, R30 */
 	   "\\_SB.PCI0.ICH3.EC0",	/* R31 */
 	   "\\_SB.PCI0.LPC.EC",	/* all others */
-    );
+	   );
 
-IBM_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
-	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
-	   "\\_SB.PCI0.VID0",	/* 770e */
-	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
-	   "\\_SB.PCI0.AGP.VID",	/* all others */
-    );				/* R30, R31 */
+IBM_HANDLE(ecrd, ec, "ECRD");	/* 570 */
+IBM_HANDLE(ecwr, ec, "ECWR");	/* 570 */
 
-IBM_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
+
+/*************************************************************************
+ * Misc ACPI handles
+ */
 
 IBM_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, T4x, X31, X40 */
 	   "\\CMOS",		/* A3x, G4x, R32, T23, T30, X22-24, X30 */
 	   "\\CMS",		/* R40, R40e */
-    );				/* all others */
-#ifdef CONFIG_ACPI_IBM_DOCK
-IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
-	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
-	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
-	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
-    );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
-#endif
-#ifdef CONFIG_ACPI_IBM_BAY
-IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
-	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
-	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
-	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
-    );				/* A21e, R30, R31 */
-
-IBM_HANDLE(bay_ej, bay, "_EJ3",	/* 600e/x, A2xm/p, A3x */
-	   "_EJ0",		/* all others */
-    );				/* 570,A21e,G4x,R30,R31,R32,R40e,R50e */
-
-IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
-	   "\\_SB.PCI0.IDE0.IDEP.IDPS",	/* 600e/x, 770e, 770x */
-    );				/* all others */
-
-IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
-	   "_EJ0",		/* 770x */
-    );				/* all others */
-#endif /* CONFIG_ACPI_IBM_BAY */
-
-/* don't list other alternatives as we install a notify handler on the 570 */
-IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
+	   );			/* all others */
 
 IBM_HANDLE(hkey, ec, "\\_SB.HKEY",	/* 600e/x, 770e, 770x */
 	   "^HKEY",		/* R30, R31 */
 	   "HKEY",		/* all others */
-    );				/* 570 */
+	   );			/* 570 */
 
-IBM_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
-IBM_HANDLE(ledb, ec, "LEDB");	/* G4x */
 
-IBM_HANDLE(led, ec, "SLED",	/* 570 */
-	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
-	   "LED",		/* all others */
-    );				/* R30, R31 */
-
-IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
-IBM_HANDLE(ecrd, ec, "ECRD");	/* 570 */
-IBM_HANDLE(ecwr, ec, "ECWR");	/* 570 */
-IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
-
-IBM_HANDLE(gfan, ec, "GFAN",	/* 570 */
-	   "\\FSPD",		/* 600e/x, 770e, 770x */
-    );				/* all others */
-
-IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
-	   "JFNS",		/* 770x-JL */
-    );				/* all others */
-
-/*
- * FAN ACCESS MODES
- *
- * IBMACPI_FAN_RD_ACPI_GFAN:
- * 	ACPI GFAN method: returns fan level
- *
- * 	see IBMACPI_FAN_WR_ACPI_SFAN
- * 	EC 0x2f not available if GFAN exists
- *
- * IBMACPI_FAN_WR_ACPI_SFAN:
- * 	ACPI SFAN method: sets fan level, 0 (stop) to 7 (max)
- *
- * 	EC 0x2f might be available *for reading*, but never for writing.
- *
- * IBMACPI_FAN_WR_TPEC:
- * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode Supported
- * 	on almost all ThinkPads
- *
- * 	Fan speed changes of any sort (including those caused by the
- * 	disengaged mode) are usually done slowly by the firmware as the
- * 	maximum ammount of fan duty cycle change per second seems to be
- * 	limited.
- *
- * 	Reading is not available if GFAN exists.
- * 	Writing is not available if SFAN exists.
- *
- * 	Bits
- *	 7	automatic mode engaged;
- *  		(default operation mode of the ThinkPad)
- * 		fan level is ignored in this mode.
- *	 6	disengage mode (takes precedence over bit 7);
- *		not available on all thinkpads.  May disable
- *		the tachometer, and speeds up fan to 100% duty-cycle,
- *		which speeds it up far above the standard RPM
- *		levels.  It is not impossible that it could cause
- *		hardware damage.
- *	5-3	unused in some models.  Extra bits for fan level
- *		in others, but still useless as all values above
- *		7 map to the same speed as level 7 in these models.
- *	2-0	fan level (0..7 usually)
- *			0x00 = stop
- * 			0x07 = max (set when temperatures critical)
- * 		Some ThinkPads may have other levels, see
- * 		IBMACPI_FAN_WR_ACPI_FANS (X31/X40/X41)
- *
- *	FIRMWARE BUG: on some models, EC 0x2f might not be initialized at
- *	boot. Apparently the EC does not intialize it, so unless ACPI DSDT
- *	does so, its initial value is meaningless (0x07).
- *
- *	For firmware bugs, refer to:
- *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
- *
- * 	----
- *
- *	ThinkPad EC register 0x84 (LSB), 0x85 (MSB):
- *	Main fan tachometer reading (in RPM)
- *
- *	This register is present on all ThinkPads with a new-style EC, and
- *	it is known not to be present on the A21m/e, and T22, as there is
- *	something else in offset 0x84 according to the ACPI DSDT.  Other
- *	ThinkPads from this same time period (and earlier) probably lack the
- *	tachometer as well.
- *
- *	Unfortunately a lot of ThinkPads with new-style ECs but whose firwmare
- *	was never fixed by IBM to report the EC firmware version string
- *	probably support the tachometer (like the early X models), so
- *	detecting it is quite hard.  We need more data to know for sure.
- *
- *	FIRMWARE BUG: always read 0x84 first, otherwise incorrect readings
- *	might result.
- *
- *	FIRMWARE BUG: when EC 0x2f bit 6 is set (disengaged mode), this
- *	register is not invalidated in ThinkPads that disable tachometer
- *	readings.  Thus, the tachometer readings go stale.
- *
- *	For firmware bugs, refer to:
- *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
- *
- * IBMACPI_FAN_WR_ACPI_FANS:
- *	ThinkPad X31, X40, X41.  Not available in the X60.
- *
- *	FANS ACPI handle: takes three arguments: low speed, medium speed,
- *	high speed.  ACPI DSDT seems to map these three speeds to levels
- *	as follows: STOP LOW LOW MED MED HIGH HIGH HIGH HIGH
- *	(this map is stored on FAN0..FAN8 as "0,1,1,2,2,3,3,3,3")
- *
- * 	The speeds are stored on handles
- * 	(FANA:FAN9), (FANC:FANB), (FANE:FAND).
- *
- * 	There are three default speed sets, acessible as handles:
- * 	FS1L,FS1M,FS1H; FS2L,FS2M,FS2H; FS3L,FS3M,FS3H
- *
- * 	ACPI DSDT switches which set is in use depending on various
- * 	factors.
- *
- * 	IBMACPI_FAN_WR_TPEC is also available and should be used to
- * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
- * 	but the ACPI tables just mention level 7.
+/*************************************************************************
+ * ACPI helpers
  */
 
-static char *ibm_thinkpad_ec_found = NULL;
-
-static struct proc_dir_entry *proc_dir = NULL;
-
-static struct backlight_device *ibm_backlight_device = NULL;
-
 static int acpi_evalf(acpi_handle handle,
 		      void *res, char *method, char *fmt, ...)
 {
@@ -371,6 +228,203 @@ static void __unused acpi_print_int(acpi_handle handle, char *method)
 		printk(IBM_ERR "error calling %s\n", method);
 }
 
+static int acpi_ec_read(int i, u8 * p)
+{
+	int v;
+
+	if (ecrd_handle) {
+		if (!acpi_evalf(ecrd_handle, &v, NULL, "dd", i))
+			return 0;
+		*p = v;
+	} else {
+		if (ec_read(i, p) < 0)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int acpi_ec_write(int i, u8 v)
+{
+	if (ecwr_handle) {
+		if (!acpi_evalf(ecwr_handle, NULL, NULL, "vdd", i, v))
+			return 0;
+	} else {
+		if (ec_write(i, v) < 0)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int _sta(acpi_handle handle)
+{
+	int status;
+
+	if (!handle || !acpi_evalf(handle, &status, "_STA", "d"))
+		status = 0;
+
+	return status;
+}
+
+/*************************************************************************
+ * ACPI device model
+ */
+
+static void __init ibm_handle_init(char *name,
+				   acpi_handle * handle, acpi_handle parent,
+				   char **paths, int num_paths, char **path)
+{
+	int i;
+	acpi_status status;
+
+	for (i = 0; i < num_paths; i++) {
+		status = acpi_get_handle(parent, paths[i], handle);
+		if (ACPI_SUCCESS(status)) {
+			*path = paths[i];
+			return;
+		}
+	}
+
+	*handle = NULL;
+}
+
+static void dispatch_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ibm_struct *ibm = data;
+
+	if (!ibm || !ibm->notify)
+		return;
+
+	ibm->notify(ibm, event);
+}
+
+static int __init setup_notify(struct ibm_struct *ibm)
+{
+	acpi_status status;
+	int ret;
+
+	if (!*ibm->handle)
+		return 0;
+
+	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
+	if (ret < 0) {
+		printk(IBM_ERR "%s device not present\n", ibm->name);
+		return -ENODEV;
+	}
+
+	acpi_driver_data(ibm->device) = ibm;
+	sprintf(acpi_device_class(ibm->device), "%s/%s", IBM_NAME, ibm->name);
+
+	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
+					     dispatch_notify, ibm);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_ALREADY_EXISTS) {
+			printk(IBM_NOTICE "another device driver is already handling %s events\n",
+				ibm->name);
+		} else {
+			printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
+				ibm->name, status);
+		}
+		return -ENODEV;
+	}
+	ibm->notify_installed = 1;
+	return 0;
+}
+
+static int __init ibm_device_add(struct acpi_device *device)
+{
+	return 0;
+}
+
+static int __init register_ibmacpi_subdriver(struct ibm_struct *ibm)
+{
+	int ret;
+
+	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
+	if (!ibm->driver) {
+		printk(IBM_ERR "kmalloc(ibm->driver) failed\n");
+		return -1;
+	}
+
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
+	ibm->driver->ids = ibm->hid;
+	ibm->driver->ops.add = &ibm_device_add;
+
+	ret = acpi_bus_register_driver(ibm->driver);
+	if (ret < 0) {
+		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
+		       ibm->hid, ret);
+		kfree(ibm->driver);
+	}
+
+	return ret;
+}
+
+
+/****************************************************************************
+ ****************************************************************************
+ *
+ * Procfs Helpers
+ *
+ ****************************************************************************
+ ****************************************************************************/
+
+static int dispatch_read(char *page, char **start, off_t off, int count,
+			 int *eof, void *data)
+{
+	struct ibm_struct *ibm = data;
+	int len;
+
+	if (!ibm || !ibm->read)
+		return -EINVAL;
+
+	len = ibm->read(page);
+	if (len < 0)
+		return len;
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int dispatch_write(struct file *file, const char __user * userbuf,
+			  unsigned long count, void *data)
+{
+	struct ibm_struct *ibm = data;
+	char *kernbuf;
+	int ret;
+
+	if (!ibm || !ibm->write)
+		return -EINVAL;
+
+	kernbuf = kmalloc(count + 2, GFP_KERNEL);
+	if (!kernbuf)
+		return -ENOMEM;
+
+	if (copy_from_user(kernbuf, userbuf, count)) {
+		kfree(kernbuf);
+		return -EFAULT;
+	}
+
+	kernbuf[count] = 0;
+	strcat(kernbuf, ",");
+	ret = ibm->write(kernbuf);
+	if (ret == 0)
+		ret = count;
+
+	kfree(kernbuf);
+
+	return ret;
+}
+
 static char *next_cmd(char **cmds)
 {
 	char *start = *cmds;
@@ -387,6 +441,19 @@ static char *next_cmd(char **cmds)
 	return start;
 }
 
+
+/****************************************************************************
+ ****************************************************************************
+ *
+ * Subdrivers
+ *
+ ****************************************************************************
+ ****************************************************************************/
+
+/*************************************************************************
+ * ibm-acpi init subdriver
+ */
+
 static int ibm_acpi_driver_init(void)
 {
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
@@ -409,11 +476,51 @@ static int ibm_acpi_driver_read(char *p)
 	return len;
 }
 
+/*************************************************************************
+ * Hotkey subdriver
+ */
+
 static int hotkey_supported;
 static int hotkey_mask_supported;
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
+static int hotkey_init(void)
+{
+	/* hotkey not supported on 570 */
+	hotkey_supported = hkey_handle != NULL;
+
+	if (hotkey_supported) {
+		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
+		   A30, R30, R31, T20-22, X20-21, X22-24 */
+		hotkey_mask_supported =
+		    acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
+
+		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void hotkey_exit(void)
+{
+	if (hotkey_supported)
+		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+}
+
+static void hotkey_notify(struct ibm_struct *ibm, u32 event)
+{
+	int hkey;
+
+	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
+		acpi_bus_generate_event(ibm->device, event, hkey);
+	else {
+		printk(IBM_ERR "unknown hotkey event %d\n", event);
+		acpi_bus_generate_event(ibm->device, event, 0);
+	}
+}
+
 static int hotkey_get(int *status, int *mask)
 {
 	if (!acpi_evalf(hkey_handle, status, "DHKC", "d"))
@@ -444,24 +551,6 @@ static int hotkey_set(int status, int mask)
 	return 1;
 }
 
-static int hotkey_init(void)
-{
-	/* hotkey not supported on 570 */
-	hotkey_supported = hkey_handle != NULL;
-
-	if (hotkey_supported) {
-		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
-		   A30, R30, R31, T20-22, X20-21, X22-24 */
-		hotkey_mask_supported =
-		    acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
-
-		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
-			return -ENODEV;
-	}
-
-	return 0;
-}
-
 static int hotkey_read(char *p)
 {
 	int status, mask;
@@ -523,23 +612,9 @@ static int hotkey_write(char *buf)
 	return 0;
 }
 
-static void hotkey_exit(void)
-{
-	if (hotkey_supported)
-		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
-}
-
-static void hotkey_notify(struct ibm_struct *ibm, u32 event)
-{
-	int hkey;
-
-	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
-		acpi_bus_generate_event(ibm->device, event, hkey);
-	else {
-		printk(IBM_ERR "unknown hotkey event %d\n", event);
-		acpi_bus_generate_event(ibm->device, event, 0);
-	}
-}
+/*************************************************************************
+ * Bluetooth subdriver
+ */
 
 static int bluetooth_supported;
 
@@ -606,6 +681,10 @@ static int bluetooth_write(char *buf)
 	return 0;
 }
 
+/*************************************************************************
+ * Wan subdriver
+ */
+
 static int wan_supported;
 
 static int wan_init(void)
@@ -668,9 +747,22 @@ static int wan_write(char *buf)
 	return 0;
 }
 
+/*************************************************************************
+ * Video subdriver
+ */
+
 static enum video_access_mode video_supported;
 static int video_orig_autosw;
 
+IBM_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
+	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
+	   "\\_SB.PCI0.VID0",	/* 770e */
+	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
+	   "\\_SB.PCI0.AGP.VID",	/* all others */
+	   );				/* R30, R31 */
+
+IBM_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
+
 static int video_init(void)
 {
 	int ivga;
@@ -695,6 +787,11 @@ static int video_init(void)
 	return 0;
 }
 
+static void video_exit(void)
+{
+	acpi_evalf(vid_handle, NULL, "_DOS", "vd", video_orig_autosw);
+}
+
 static int video_status(void)
 {
 	int status = 0;
@@ -736,33 +833,6 @@ static int video_autosw(void)
 	return autosw & 1;
 }
 
-static int video_read(char *p)
-{
-	int status = video_status();
-	int autosw = video_autosw();
-	int len = 0;
-
-	if (!video_supported) {
-		len += sprintf(p + len, "status:\t\tnot supported\n");
-		return len;
-	}
-
-	len += sprintf(p + len, "status:\t\tsupported\n");
-	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
-	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
-	if (video_supported == IBMACPI_VIDEO_NEW)
-		len += sprintf(p + len, "dvi:\t\t%s\n", enabled(status, 3));
-	len += sprintf(p + len, "auto:\t\t%s\n", enabled(autosw, 0));
-	len += sprintf(p + len, "commands:\tlcd_enable, lcd_disable\n");
-	len += sprintf(p + len, "commands:\tcrt_enable, crt_disable\n");
-	if (video_supported == IBMACPI_VIDEO_NEW)
-		len += sprintf(p + len, "commands:\tdvi_enable, dvi_disable\n");
-	len += sprintf(p + len, "commands:\tauto_enable, auto_disable\n");
-	len += sprintf(p + len, "commands:\tvideo_switch, expand_toggle\n");
-
-	return len;
-}
-
 static int video_switch(void)
 {
 	int autosw = video_autosw();
@@ -812,6 +882,33 @@ static int video_switch2(int status)
 	return ret;
 }
 
+static int video_read(char *p)
+{
+	int status = video_status();
+	int autosw = video_autosw();
+	int len = 0;
+
+	if (!video_supported) {
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+		return len;
+	}
+
+	len += sprintf(p + len, "status:\t\tsupported\n");
+	len += sprintf(p + len, "lcd:\t\t%s\n", enabled(status, 0));
+	len += sprintf(p + len, "crt:\t\t%s\n", enabled(status, 1));
+	if (video_supported == IBMACPI_VIDEO_NEW)
+		len += sprintf(p + len, "dvi:\t\t%s\n", enabled(status, 3));
+	len += sprintf(p + len, "auto:\t\t%s\n", enabled(autosw, 0));
+	len += sprintf(p + len, "commands:\tlcd_enable, lcd_disable\n");
+	len += sprintf(p + len, "commands:\tcrt_enable, crt_disable\n");
+	if (video_supported == IBMACPI_VIDEO_NEW)
+		len += sprintf(p + len, "commands:\tdvi_enable, dvi_disable\n");
+	len += sprintf(p + len, "commands:\tauto_enable, auto_disable\n");
+	len += sprintf(p + len, "commands:\tvideo_switch, expand_toggle\n");
+
+	return len;
+}
+
 static int video_write(char *buf)
 {
 	char *cmd;
@@ -862,14 +959,16 @@ static int video_write(char *buf)
 	return 0;
 }
 
-static void video_exit(void)
-{
-	acpi_evalf(vid_handle, NULL, "_DOS", "vd", video_orig_autosw);
-}
+/*************************************************************************
+ * Light (thinklight) subdriver
+ */
 
 static int light_supported;
 static int light_status_supported;
 
+IBM_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
+IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
+
 static int light_init(void)
 {
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
@@ -933,21 +1032,45 @@ static int light_write(char *buf)
 	return 0;
 }
 
-#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
-static int _sta(acpi_handle handle)
-{
-	int status;
-
-	if (!handle || !acpi_evalf(handle, &status, "_STA", "d"))
-		status = 0;
+/*************************************************************************
+ * Dock subdriver
+ */
 
-	return status;
-}
-#endif
+/* don't list other alternatives as we install a notify handler on the 570 */
+IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
 #ifdef CONFIG_ACPI_IBM_DOCK
+
+IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
+	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
+	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
+	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
+    );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
+
 #define dock_docked() (_sta(dock_handle) & 1)
 
+static void dock_notify(struct ibm_struct *ibm, u32 event)
+{
+	int docked = dock_docked();
+	int pci = ibm->hid && strstr(ibm->hid, IBM_PCI_HID);
+
+	if (event == 1 && !pci)	/* 570 */
+		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
+	else if (event == 1 && pci)	/* 570 */
+		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
+	else if (event == 3 && docked)
+		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
+	else if (event == 3 && !docked)
+		acpi_bus_generate_event(ibm->device, event, 2);	/* undock */
+	else if (event == 0 && docked)
+		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
+	else {
+		printk(IBM_ERR "unknown dock event %d, status %d\n",
+		       event, _sta(dock_handle));
+		acpi_bus_generate_event(ibm->device, event, 0);	/* unknown */
+	}
+}
+
 static int dock_read(char *p)
 {
 	int len = 0;
@@ -987,28 +1110,11 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-static void dock_notify(struct ibm_struct *ibm, u32 event)
-{
-	int docked = dock_docked();
-	int pci = ibm->hid && strstr(ibm->hid, IBM_PCI_HID);
+#endif /* CONFIG_ACPI_IBM_DOCK */
 
-	if (event == 1 && !pci)	/* 570 */
-		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
-	else if (event == 1 && pci)	/* 570 */
-		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
-	else if (event == 3 && docked)
-		acpi_bus_generate_event(ibm->device, event, 1);	/* button */
-	else if (event == 3 && !docked)
-		acpi_bus_generate_event(ibm->device, event, 2);	/* undock */
-	else if (event == 0 && docked)
-		acpi_bus_generate_event(ibm->device, event, 3);	/* dock */
-	else {
-		printk(IBM_ERR "unknown dock event %d, status %d\n",
-		       event, _sta(dock_handle));
-		acpi_bus_generate_event(ibm->device, event, 0);	/* unknown */
-	}
-}
-#endif
+/*************************************************************************
+ * Bay subdriver
+ */
 
 #ifdef CONFIG_ACPI_IBM_BAY
 static int bay_status_supported;
@@ -1016,6 +1122,21 @@ static int bay_status2_supported;
 static int bay_eject_supported;
 static int bay_eject2_supported;
 
+IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
+	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
+	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
+	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
+	   );				/* A21e, R30, R31 */
+IBM_HANDLE(bay_ej, bay, "_EJ3",	/* 600e/x, A2xm/p, A3x */
+	   "_EJ0",		/* all others */
+	   );			/* 570,A21e,G4x,R30,R31,R32,R40e,R50e */
+IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
+	   "\\_SB.PCI0.IDE0.IDEP.IDPS",	/* 600e/x, 770e, 770x */
+	   );				/* all others */
+IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
+	   "_EJ0",			/* 770x */
+	   );				/* all others */
+
 static int bay_init(void)
 {
 	bay_status_supported = bay_handle &&
@@ -1031,6 +1152,11 @@ static int bay_init(void)
 	return 0;
 }
 
+static void bay_notify(struct ibm_struct *ibm, u32 event)
+{
+	acpi_bus_generate_event(ibm->device, event, 0);
+}
+
 #define bay_occupied(b) (_sta(b##_handle) & 1)
 
 static int bay_read(char *p)
@@ -1081,12 +1207,19 @@ static int bay_write(char *buf)
 
 	return 0;
 }
+#endif /* CONFIG_ACPI_IBM_BAY */
 
-static void bay_notify(struct ibm_struct *ibm, u32 event)
+/*************************************************************************
+ * CMOS subdriver
+ */
+
+static int cmos_eval(int cmos_cmd)
 {
-	acpi_bus_generate_event(ibm->device, event, 0);
+	if (cmos_handle)
+		return acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd);
+	else
+		return 1;
 }
-#endif /* CONFIG_ACPI_IBM_BAY */
 
 static int cmos_read(char *p)
 {
@@ -1104,14 +1237,6 @@ static int cmos_read(char *p)
 	return len;
 }
 
-static int cmos_eval(int cmos_cmd)
-{
-	if (cmos_handle)
-		return acpi_evalf(cmos_handle, NULL, NULL, "vd", cmos_cmd);
-	else
-		return 1;
-}
-
 static int cmos_write(char *buf)
 {
 	char *cmd;
@@ -1134,8 +1259,18 @@ static int cmos_write(char *buf)
 	return 0;
 }
 
+
+/*************************************************************************
+ * LED subdriver
+ */
+
 static enum led_access_mode led_supported;
 
+IBM_HANDLE(led, ec, "SLED",	/* 570 */
+	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	   "LED",		/* all others */
+	   );			/* R30, R31 */
+
 static int led_init(void)
 {
 	if (!led_handle)
@@ -1242,6 +1377,12 @@ static int led_write(char *buf)
 	return 0;
 }
 
+/*************************************************************************
+ * Beep subdriver
+ */
+
+IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
+
 static int beep_read(char *p)
 {
 	int len = 0;
@@ -1277,34 +1418,9 @@ static int beep_write(char *buf)
 	return 0;
 }
 
-static int acpi_ec_read(int i, u8 * p)
-{
-	int v;
-
-	if (ecrd_handle) {
-		if (!acpi_evalf(ecrd_handle, &v, NULL, "dd", i))
-			return 0;
-		*p = v;
-	} else {
-		if (ec_read(i, p) < 0)
-			return 0;
-	}
-
-	return 1;
-}
-
-static int acpi_ec_write(int i, u8 v)
-{
-	if (ecwr_handle) {
-		if (!acpi_evalf(ecwr_handle, NULL, NULL, "vdd", i, v))
-			return 0;
-	} else {
-		if (ec_write(i, v) < 0)
-			return 0;
-	}
-
-	return 1;
-}
+/*************************************************************************
+ * Thermal subdriver
+ */
 
 static enum thermal_access_mode thermal_read_mode;
 
@@ -1446,6 +1562,10 @@ static int thermal_read(char *p)
 	return len;
 }
 
+/*************************************************************************
+ * EC Dump subdriver
+ */
+
 static u8 ecdump_regs[256];
 
 static int ecdump_read(char *p)
@@ -1505,6 +1625,55 @@ static int ecdump_write(char *buf)
 	return 0;
 }
 
+/*************************************************************************
+ * Backlight/brightness subdriver
+ */
+
+static struct backlight_device *ibm_backlight_device = NULL;
+
+static struct backlight_ops ibm_backlight_data = {
+        .get_brightness = brightness_get,
+        .update_status  = brightness_update_status,
+};
+
+static int brightness_init(void)
+{
+	int b;
+
+	b = brightness_get(NULL);
+	if (b < 0)
+		return b;
+
+	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
+							 &ibm_backlight_data);
+	if (IS_ERR(ibm_backlight_device)) {
+		printk(IBM_ERR "Could not register backlight device\n");
+		return PTR_ERR(ibm_backlight_device);
+	}
+
+	ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.brightness = b;
+	backlight_update_status(ibm_backlight_device);
+
+	return 0;
+}
+
+static void brightness_exit(void)
+{
+	if (ibm_backlight_device) {
+		backlight_device_unregister(ibm_backlight_device);
+		ibm_backlight_device = NULL;
+	}
+}
+
+static int brightness_update_status(struct backlight_device *bd)
+{
+	return brightness_set(
+		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+				bd->props.brightness : 0);
+}
+
 static int brightness_get(struct backlight_device *bd)
 {
 	u8 level;
@@ -1516,23 +1685,6 @@ static int brightness_get(struct backlight_device *bd)
 	return level;
 }
 
-static int brightness_read(char *p)
-{
-	int len = 0;
-	int level;
-
-	if ((level = brightness_get(NULL)) < 0) {
-		len += sprintf(p + len, "level:\t\tunreadable\n");
-	} else {
-		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
-		len += sprintf(p + len, "commands:\tup, down\n");
-		len += sprintf(p + len, "commands:\tlevel <level>"
-			       " (<level> is 0-7)\n");
-	}
-
-	return len;
-}
-
 static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i;
@@ -1540,8 +1692,7 @@ static int brightness_set(int value)
 
 	value &= 7;
 
-	cmos_cmd = value > current_value ?
-		   TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
+	cmos_cmd = value > current_value ? TP_CMOS_BRIGHTNESS_UP : TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 	for (i = current_value; i != value; i += inc) {
 		if (!cmos_eval(cmos_cmd))
@@ -1553,6 +1704,23 @@ static int brightness_set(int value)
 	return 0;
 }
 
+static int brightness_read(char *p)
+{
+	int len = 0;
+	int level;
+
+	if ((level = brightness_get(NULL)) < 0) {
+		len += sprintf(p + len, "level:\t\tunreadable\n");
+	} else {
+		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
+		len += sprintf(p + len, "commands:\tup, down\n");
+		len += sprintf(p + len, "commands:\tlevel <level>"
+			       " (<level> is 0-7)\n");
+	}
+
+	return len;
+}
+
 static int brightness_write(char *buf)
 {
 	int level;
@@ -1580,48 +1748,9 @@ static int brightness_write(char *buf)
 	return 0;
 }
 
-static int brightness_update_status(struct backlight_device *bd)
-{
-	return brightness_set(
-		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
-		 bd->props.power == FB_BLANK_UNBLANK) ?
-				bd->props.brightness : 0);
-}
-
-static struct backlight_ops ibm_backlight_data = {
-        .get_brightness = brightness_get,
-        .update_status  = brightness_update_status,
-};
-
-static int brightness_init(void)
-{
-	int b;
-
-	b = brightness_get(NULL);
-	if (b < 0)
-		return b;
-
-	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
-							 &ibm_backlight_data);
-	if (IS_ERR(ibm_backlight_device)) {
-		printk(IBM_ERR "Could not register backlight device\n");
-		return PTR_ERR(ibm_backlight_device);
-	}
-
-	ibm_backlight_device->props.max_brightness = 7;
-	ibm_backlight_device->props.brightness = b;
-	backlight_update_status(ibm_backlight_device);
-
-	return 0;
-}
-
-static void brightness_exit(void)
-{
-	if (ibm_backlight_device) {
-		backlight_device_unregister(ibm_backlight_device);
-		ibm_backlight_device = NULL;
-	}
-}
+/*************************************************************************
+ * Volume subdriver
+ */
 
 static int volume_read(char *p)
 {
@@ -1673,8 +1802,7 @@ static int volume_write(char *buf)
 			return -EINVAL;
 
 		if (new_level != level) {	/* mute doesn't change */
-			cmos_cmd = new_level > level ?
-					TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
+			cmos_cmd = new_level > level ? TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
 			if (mute && (!cmos_eval(cmos_cmd) ||
@@ -1693,8 +1821,7 @@ static int volume_write(char *buf)
 		}
 
 		if (new_mute != mute) {	/* level doesn't change */
-			cmos_cmd = new_mute ?
-				   TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
+			cmos_cmd = new_mute ? TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
 			if (!cmos_eval(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
@@ -1705,6 +1832,111 @@ static int volume_write(char *buf)
 	return 0;
 }
 
+
+/*************************************************************************
+ * Fan subdriver
+ */
+
+/*
+ * FAN ACCESS MODES
+ *
+ * IBMACPI_FAN_RD_ACPI_GFAN:
+ * 	ACPI GFAN method: returns fan level
+ *
+ * 	see IBMACPI_FAN_WR_ACPI_SFAN
+ * 	EC 0x2f not available if GFAN exists
+ *
+ * IBMACPI_FAN_WR_ACPI_SFAN:
+ * 	ACPI SFAN method: sets fan level, 0 (stop) to 7 (max)
+ *
+ * 	EC 0x2f might be available *for reading*, but never for writing.
+ *
+ * IBMACPI_FAN_WR_TPEC:
+ * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode Supported
+ * 	on almost all ThinkPads
+ *
+ * 	Fan speed changes of any sort (including those caused by the
+ * 	disengaged mode) are usually done slowly by the firmware as the
+ * 	maximum ammount of fan duty cycle change per second seems to be
+ * 	limited.
+ *
+ * 	Reading is not available if GFAN exists.
+ * 	Writing is not available if SFAN exists.
+ *
+ * 	Bits
+ *	 7	automatic mode engaged;
+ *  		(default operation mode of the ThinkPad)
+ * 		fan level is ignored in this mode.
+ *	 6	disengage mode (takes precedence over bit 7);
+ *		not available on all thinkpads.  May disable
+ *		the tachometer, and speeds up fan to 100% duty-cycle,
+ *		which speeds it up far above the standard RPM
+ *		levels.  It is not impossible that it could cause
+ *		hardware damage.
+ *	5-3	unused in some models.  Extra bits for fan level
+ *		in others, but still useless as all values above
+ *		7 map to the same speed as level 7 in these models.
+ *	2-0	fan level (0..7 usually)
+ *			0x00 = stop
+ * 			0x07 = max (set when temperatures critical)
+ * 		Some ThinkPads may have other levels, see
+ * 		IBMACPI_FAN_WR_ACPI_FANS (X31/X40/X41)
+ *
+ *	FIRMWARE BUG: on some models, EC 0x2f might not be initialized at
+ *	boot. Apparently the EC does not intialize it, so unless ACPI DSDT
+ *	does so, its initial value is meaningless (0x07).
+ *
+ *	For firmware bugs, refer to:
+ *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *
+ * 	----
+ *
+ *	ThinkPad EC register 0x84 (LSB), 0x85 (MSB):
+ *	Main fan tachometer reading (in RPM)
+ *
+ *	This register is present on all ThinkPads with a new-style EC, and
+ *	it is known not to be present on the A21m/e, and T22, as there is
+ *	something else in offset 0x84 according to the ACPI DSDT.  Other
+ *	ThinkPads from this same time period (and earlier) probably lack the
+ *	tachometer as well.
+ *
+ *	Unfortunately a lot of ThinkPads with new-style ECs but whose firwmare
+ *	was never fixed by IBM to report the EC firmware version string
+ *	probably support the tachometer (like the early X models), so
+ *	detecting it is quite hard.  We need more data to know for sure.
+ *
+ *	FIRMWARE BUG: always read 0x84 first, otherwise incorrect readings
+ *	might result.
+ *
+ *	FIRMWARE BUG: when EC 0x2f bit 6 is set (disengaged mode), this
+ *	register is not invalidated in ThinkPads that disable tachometer
+ *	readings.  Thus, the tachometer readings go stale.
+ *
+ *	For firmware bugs, refer to:
+ *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *
+ * IBMACPI_FAN_WR_ACPI_FANS:
+ *	ThinkPad X31, X40, X41.  Not available in the X60.
+ *
+ *	FANS ACPI handle: takes three arguments: low speed, medium speed,
+ *	high speed.  ACPI DSDT seems to map these three speeds to levels
+ *	as follows: STOP LOW LOW MED MED HIGH HIGH HIGH HIGH
+ *	(this map is stored on FAN0..FAN8 as "0,1,1,2,2,3,3,3,3")
+ *
+ * 	The speeds are stored on handles
+ * 	(FANA:FAN9), (FANC:FANB), (FANE:FAND).
+ *
+ * 	There are three default speed sets, acessible as handles:
+ * 	FS1L,FS1M,FS1H; FS2L,FS2M,FS2H; FS3L,FS3M,FS3H
+ *
+ * 	ACPI DSDT switches which set is in use depending on various
+ * 	factors.
+ *
+ * 	IBMACPI_FAN_WR_TPEC is also available and should be used to
+ * 	command the fan.  The X31/X40/X41 seems to have 8 fan levels,
+ * 	but the ACPI tables just mention level 7.
+ */
+
 static enum fan_status_access_mode fan_status_access_mode;
 static enum fan_control_access_mode fan_control_access_mode;
 static enum fan_control_commands fan_control_commands;
@@ -1716,6 +1948,14 @@ static void fan_watchdog_fire(struct work_struct *ignored);
 static int fan_watchdog_maxinterval;
 static DECLARE_DELAYED_WORK(fan_watchdog_task, fan_watchdog_fire);
 
+IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
+IBM_HANDLE(gfan, ec, "GFAN",	/* 570 */
+	   "\\FSPD",		/* 600e/x, 770e, 770x */
+	   );			/* all others */
+IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
+	   "JFNS",		/* 770x-JL */
+	   );			/* all others */
+
 static int fan_init(void)
 {
 	fan_status_access_mode = IBMACPI_FAN_NONE;
@@ -1831,6 +2071,12 @@ static int fan_get_status(u8 *status)
 	return 0;
 }
 
+static void fan_exit(void)
+{
+	cancel_delayed_work(&fan_watchdog_task);
+	flush_scheduled_work();
+}
+
 static int fan_get_speed(unsigned int *speed)
 {
 	u8 hi, lo;
@@ -1854,10 +2100,14 @@ static int fan_get_speed(unsigned int *speed)
 	return 0;
 }
 
-static void fan_exit(void)
+static void fan_watchdog_fire(struct work_struct *ignored)
 {
-	cancel_delayed_work(&fan_watchdog_task);
-	flush_scheduled_work();
+	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
+	if (fan_set_enable()) {
+		printk(IBM_ERR "fan watchdog: error while enabling fan\n");
+		/* reschedule for later */
+		fan_watchdog_reset();
+	}
 }
 
 static void fan_watchdog_reset(void)
@@ -1879,90 +2129,6 @@ static void fan_watchdog_reset(void)
 		fan_watchdog_active = 0;
 }
 
-static int fan_read(char *p)
-{
-	int len = 0;
-	int rc;
-	u8 status;
-	unsigned int speed = 0;
-
-	switch (fan_status_access_mode) {
-	case IBMACPI_FAN_RD_ACPI_GFAN:
-		/* 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status(&status)) < 0)
-			return rc;
-
-		len += sprintf(p + len, "status:\t\t%s\n"
-			       "level:\t\t%d\n",
-			       (status != 0) ? "enabled" : "disabled", status);
-		break;
-
-	case IBMACPI_FAN_RD_TPEC:
-		/* all except 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status(&status)) < 0)
-			return rc;
-
-		if (unlikely(!fan_control_status_known)) {
-			if (status != fan_control_initial_status)
-				fan_control_status_known = 1;
-			else
-				/* Return most likely status. In fact, it
-				 * might be the only possible status */
-				status = IBMACPI_FAN_EC_AUTO;
-		}
-
-		len += sprintf(p + len, "status:\t\t%s\n",
-			       (status != 0) ? "enabled" : "disabled");
-
-		/* No ThinkPad boots on disengaged mode, we can safely
-		 * assume the tachometer is online if fan control status
-		 * was unknown */
-		if ((rc = fan_get_speed(&speed)) < 0)
-			return rc;
-
-		len += sprintf(p + len, "speed:\t\t%d\n", speed);
-
-		if (status & IBMACPI_FAN_EC_DISENGAGED)
-			/* Disengaged mode takes precedence */
-			len += sprintf(p + len, "level:\t\tdisengaged\n");
-		else if (status & IBMACPI_FAN_EC_AUTO)
-			len += sprintf(p + len, "level:\t\tauto\n");
-		else
-			len += sprintf(p + len, "level:\t\t%d\n", status);
-		break;
-
-	case IBMACPI_FAN_NONE:
-	default:
-		len += sprintf(p + len, "status:\t\tnot supported\n");
-	}
-
-	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL) {
-		len += sprintf(p + len, "commands:\tlevel <level>");
-
-		switch (fan_control_access_mode) {
-		case IBMACPI_FAN_WR_ACPI_SFAN:
-			len += sprintf(p + len, " (<level> is 0-7)\n");
-			break;
-
-		default:
-			len += sprintf(p + len, " (<level> is 0-7, "
-				       "auto, disengaged)\n");
-			break;
-		}
-	}
-
-	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
-		len += sprintf(p + len, "commands:\tenable, disable\n"
-			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
-			       "1-120 (seconds))\n");
-
-	if (fan_control_commands & IBMACPI_FAN_CMD_SPEED)
-		len += sprintf(p + len, "commands:\tspeed <speed>"
-			       " (<speed> is 0-65535)\n");
-
-	return len;
-}
-
 static int fan_set_level(int level)
 {
 	switch (fan_control_access_mode) {
@@ -2074,6 +2240,90 @@ static int fan_set_speed(int speed)
 	return 0;
 }
 
+static int fan_read(char *p)
+{
+	int len = 0;
+	int rc;
+	u8 status;
+	unsigned int speed = 0;
+
+	switch (fan_status_access_mode) {
+	case IBMACPI_FAN_RD_ACPI_GFAN:
+		/* 570, 600e/x, 770e, 770x */
+		if ((rc = fan_get_status(&status)) < 0)
+			return rc;
+
+		len += sprintf(p + len, "status:\t\t%s\n"
+			       "level:\t\t%d\n",
+			       (status != 0) ? "enabled" : "disabled", status);
+		break;
+
+	case IBMACPI_FAN_RD_TPEC:
+		/* all except 570, 600e/x, 770e, 770x */
+		if ((rc = fan_get_status(&status)) < 0)
+			return rc;
+
+		if (unlikely(!fan_control_status_known)) {
+			if (status != fan_control_initial_status)
+				fan_control_status_known = 1;
+			else
+				/* Return most likely status. In fact, it
+				 * might be the only possible status */
+				status = IBMACPI_FAN_EC_AUTO;
+		}
+
+		len += sprintf(p + len, "status:\t\t%s\n",
+			       (status != 0) ? "enabled" : "disabled");
+
+		/* No ThinkPad boots on disengaged mode, we can safely
+		 * assume the tachometer is online if fan control status
+		 * was unknown */
+		if ((rc = fan_get_speed(&speed)) < 0)
+			return rc;
+
+		len += sprintf(p + len, "speed:\t\t%d\n", speed);
+
+		if (status & IBMACPI_FAN_EC_DISENGAGED)
+			/* Disengaged mode takes precedence */
+			len += sprintf(p + len, "level:\t\tdisengaged\n");
+		else if (status & IBMACPI_FAN_EC_AUTO)
+			len += sprintf(p + len, "level:\t\tauto\n");
+		else
+			len += sprintf(p + len, "level:\t\t%d\n", status);
+		break;
+
+	case IBMACPI_FAN_NONE:
+	default:
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	}
+
+	if (fan_control_commands & IBMACPI_FAN_CMD_LEVEL) {
+		len += sprintf(p + len, "commands:\tlevel <level>");
+
+		switch (fan_control_access_mode) {
+		case IBMACPI_FAN_WR_ACPI_SFAN:
+			len += sprintf(p + len, " (<level> is 0-7)\n");
+			break;
+
+		default:
+			len += sprintf(p + len, " (<level> is 0-7, "
+				       "auto, disengaged)\n");
+			break;
+		}
+	}
+
+	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
+		len += sprintf(p + len, "commands:\tenable, disable\n"
+			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
+			       "1-120 (seconds))\n");
+
+	if (fan_control_commands & IBMACPI_FAN_CMD_SPEED)
+		len += sprintf(p + len, "commands:\tspeed <speed>"
+			       " (<speed> is 0-65535)\n");
+
+	return len;
+}
+
 static int fan_write_cmd_level(const char *cmd, int *rc)
 {
 	int level;
@@ -2171,16 +2421,18 @@ static int fan_write(char *buf)
 	return rc;
 }
 
-static void fan_watchdog_fire(struct work_struct *ignored)
-{
-	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
-	if (fan_set_enable()) {
-		printk(IBM_ERR "fan watchdog: error while enabling fan\n");
-		/* reschedule for later */
-		fan_watchdog_reset();
-	}
-}
+/****************************************************************************
+ ****************************************************************************
+ *
+ * Infrastructure
+ *
+ ****************************************************************************
+ ****************************************************************************/
+
+/* /proc support */
+static struct proc_dir_entry *proc_dir = NULL;
 
+/* Subdriver registry */
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
@@ -2301,132 +2553,9 @@ static struct ibm_struct ibms[] = {
 	 },
 };
 
-static int dispatch_read(char *page, char **start, off_t off, int count,
-			 int *eof, void *data)
-{
-	struct ibm_struct *ibm = data;
-	int len;
-
-	if (!ibm || !ibm->read)
-		return -EINVAL;
-
-	len = ibm->read(page);
-	if (len < 0)
-		return len;
-
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-
-	return len;
-}
-
-static int dispatch_write(struct file *file, const char __user * userbuf,
-			  unsigned long count, void *data)
-{
-	struct ibm_struct *ibm = data;
-	char *kernbuf;
-	int ret;
-
-	if (!ibm || !ibm->write)
-		return -EINVAL;
-
-	kernbuf = kmalloc(count + 2, GFP_KERNEL);
-	if (!kernbuf)
-		return -ENOMEM;
-
-	if (copy_from_user(kernbuf, userbuf, count)) {
-		kfree(kernbuf);
-		return -EFAULT;
-	}
-
-	kernbuf[count] = 0;
-	strcat(kernbuf, ",");
-	ret = ibm->write(kernbuf);
-	if (ret == 0)
-		ret = count;
-
-	kfree(kernbuf);
-
-	return ret;
-}
-
-static void dispatch_notify(acpi_handle handle, u32 event, void *data)
-{
-	struct ibm_struct *ibm = data;
-
-	if (!ibm || !ibm->notify)
-		return;
-
-	ibm->notify(ibm, event);
-}
-
-static int __init setup_notify(struct ibm_struct *ibm)
-{
-	acpi_status status;
-	int ret;
-
-	if (!*ibm->handle)
-		return 0;
-
-	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
-	if (ret < 0) {
-		printk(IBM_ERR "%s device not present\n", ibm->name);
-		return -ENODEV;
-	}
-
-	acpi_driver_data(ibm->device) = ibm;
-	sprintf(acpi_device_class(ibm->device), "%s/%s", IBM_NAME, ibm->name);
-
-	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
-					     dispatch_notify, ibm);
-	if (ACPI_FAILURE(status)) {
-		if (status == AE_ALREADY_EXISTS) {
-			printk(IBM_NOTICE "another device driver is already handling %s events\n",
-				ibm->name);
-		} else {
-			printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
-				ibm->name, status);
-		}
-		return -ENODEV;
-	}
-	ibm->notify_installed = 1;
-	return 0;
-}
-
-static int __init ibm_device_add(struct acpi_device *device)
-{
-	return 0;
-}
-
-static int __init register_ibmacpi_subdriver(struct ibm_struct *ibm)
-{
-	int ret;
-
-	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
-	if (!ibm->driver) {
-		printk(IBM_ERR "kmalloc(ibm->driver) failed\n");
-		return -1;
-	}
-
-	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
-	ibm->driver->ids = ibm->hid;
-	ibm->driver->ops.add = &ibm_device_add;
-
-	ret = acpi_bus_register_driver(ibm->driver);
-	if (ret < 0) {
-		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->hid, ret);
-		kfree(ibm->driver);
-	}
-
-	return ret;
-}
+/*
+ * Module and infrastructure proble, init and exit handling
+ */
 
 static int __init ibm_init(struct ibm_struct *ibm)
 {
@@ -2500,27 +2629,35 @@ static void ibm_exit(struct ibm_struct *ibm)
 	}
 }
 
-static void __init ibm_handle_init(char *name,
-				   acpi_handle * handle, acpi_handle parent,
-				   char **paths, int num_paths, char **path)
+/* Probing */
+
+static char *ibm_thinkpad_ec_found = NULL;
+
+static char* __init check_dmi_for_ec(void)
 {
-	int i;
-	acpi_status status;
+	struct dmi_device *dev = NULL;
+	char ec_fw_string[18];
 
-	for (i = 0; i < num_paths; i++) {
-		status = acpi_get_handle(parent, paths[i], handle);
-		if (ACPI_SUCCESS(status)) {
-			*path = paths[i];
-			return;
+	/*
+	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
+	 * X32 or newer, all Z series;  Some models must have an
+	 * up-to-date BIOS or they will not be detected.
+	 *
+	 * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+	 */
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
+		if (sscanf(dev->name,
+			   "IBM ThinkPad Embedded Controller -[%17c",
+			   ec_fw_string) == 1) {
+			ec_fw_string[sizeof(ec_fw_string) - 1] = 0;
+			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
+			return kstrdup(ec_fw_string, GFP_KERNEL);
 		}
 	}
-
-	*handle = NULL;
+	return NULL;
 }
 
-#define IBM_HANDLE_INIT(object)						\
-	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
-		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
+/* Module init, exit, parameters */
 
 static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 {
@@ -2538,6 +2675,9 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 	return -EINVAL;
 }
 
+static int experimental;
+module_param(experimental, int, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
@@ -2559,44 +2699,6 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
-static void acpi_ibm_exit(void)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
-		ibm_exit(&ibms[i]);
-
-	if (proc_dir)
-		remove_proc_entry(IBM_DIR, acpi_root_dir);
-
-	if (ibm_thinkpad_ec_found)
-		kfree(ibm_thinkpad_ec_found);
-}
-
-static char* __init check_dmi_for_ec(void)
-{
-	struct dmi_device *dev = NULL;
-	char ec_fw_string[18];
-
-	/*
-	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
-	 * X32 or newer, all Z series;  Some models must have an
-	 * up-to-date BIOS or they will not be detected.
-	 *
-	 * See http://thinkwiki.org/wiki/List_of_DMI_IDs
-	 */
-	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
-		if (sscanf(dev->name,
-			   "IBM ThinkPad Embedded Controller -[%17c",
-			   ec_fw_string) == 1) {
-			ec_fw_string[sizeof(ec_fw_string) - 1] = 0;
-			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
-			return kstrdup(ec_fw_string, GFP_KERNEL);
-		}
-	}
-	return NULL;
-}
-
 static int __init acpi_ibm_init(void)
 {
 	int ret, i;
@@ -2662,5 +2764,19 @@ static int __init acpi_ibm_init(void)
 	return 0;
 }
 
+static void acpi_ibm_exit(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
+		ibm_exit(&ibms[i]);
+
+	if (proc_dir)
+		remove_proc_entry(IBM_DIR, acpi_root_dir);
+
+	if (ibm_thinkpad_ec_found)
+		kfree(ibm_thinkpad_ec_found);
+}
+
 module_init(acpi_ibm_init);
 module_exit(acpi_ibm_exit);
-- 
1.5.0.3

