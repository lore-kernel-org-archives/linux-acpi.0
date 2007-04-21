From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 07/20] ACPI: thinkpad-acpi: clean up
	probing and move init to subdrivers
Date: Sat, 21 Apr 2007 11:08:31 -0300
Message-ID: <11771645261334-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Move most of the probing code to its own function, and most of the
subdriver-specific init code into subdriver init functions.

This allows us to not define pci_handle unless the dock subdriver is
enabled, as well.

This patch causes a minor userland interface change: if a subdriver doesn't
detect a capability, /proc entries for it are not created anymore (as
opposed to a /proc entry that just returned "unsupported").

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  231 +++++++++++++++++++++++++++---------------
 drivers/misc/thinkpad_acpi.h |    4 +-
 2 files changed, 151 insertions(+), 84 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7fa906f..eeab394 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -277,9 +277,9 @@ static int _sta(acpi_handle handle)
  * ACPI device model
  */
 
-static void __init ibm_handle_init(char *name,
-				   acpi_handle * handle, acpi_handle parent,
-				   char **paths, int num_paths, char **path)
+static void ibm_handle_init(char *name,
+			   acpi_handle *handle, acpi_handle parent,
+			   char **paths, int num_paths, char **path)
 {
 	int i;
 	acpi_status status;
@@ -351,8 +351,8 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 
 	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->driver) {
-		printk(IBM_ERR "kmalloc(ibm->driver) failed\n");
-		return -1;
+		printk(IBM_ERR "kzalloc(ibm->driver) failed\n");
+		return -ENOMEM;
 	}
 
 	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
@@ -364,7 +364,9 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
 		       ibm->hid, ret);
 		kfree(ibm->driver);
-	}
+		ibm->driver = NULL;
+	} else if (!ret)
+		ibm->driver_registered = 1;
 
 	return ret;
 }
@@ -495,6 +497,8 @@ static int hotkey_orig_mask;
 
 static int hotkey_init(void)
 {
+	IBM_HANDLE_INIT(hkey);
+
 	/* hotkey not supported on 570 */
 	hotkey_supported = hkey_handle != NULL;
 
@@ -508,13 +512,14 @@ static int hotkey_init(void)
 			return -ENODEV;
 	}
 
-	return 0;
+	return (hotkey_supported)? 0 : 1;
 }
 
 static void hotkey_exit(void)
 {
-	if (hotkey_supported)
+	if (hotkey_supported) {
 		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
+	}
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -628,12 +633,14 @@ static int bluetooth_supported;
 
 static int bluetooth_init(void)
 {
+	IBM_HANDLE_INIT(hkey);
+
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
 	bluetooth_supported = hkey_handle &&
 	    acpi_evalf(hkey_handle, NULL, "GBDC", "qv");
 
-	return 0;
+	return (bluetooth_supported)? 0 : 1;
 }
 
 static int bluetooth_status(void)
@@ -697,10 +704,12 @@ static int wan_supported;
 
 static int wan_init(void)
 {
+	IBM_HANDLE_INIT(hkey);
+
 	wan_supported = hkey_handle &&
 	    acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
 
-	return 0;
+	return (wan_supported)? 0 : 1;
 }
 
 static int wan_status(void)
@@ -775,6 +784,9 @@ static int video_init(void)
 {
 	int ivga;
 
+	IBM_HANDLE_INIT(vid);
+	IBM_HANDLE_INIT(vid2);
+
 	if (vid2_handle && acpi_evalf(NULL, &ivga, "\\IVGA", "d") && ivga)
 		/* G41, assume IVGA doesn't change */
 		vid_handle = vid2_handle;
@@ -792,7 +804,7 @@ static int video_init(void)
 		/* all others */
 		video_supported = TPACPI_VIDEO_NEW;
 
-	return 0;
+	return (video_supported != TPACPI_VIDEO_NONE)? 0 : 1;
 }
 
 static void video_exit(void)
@@ -979,6 +991,10 @@ IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
 static int light_init(void)
 {
+	IBM_HANDLE_INIT(ledb);
+	IBM_HANDLE_INIT(lght);
+	IBM_HANDLE_INIT(cmos);
+
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
 	light_supported = (cmos_handle || lght_handle) && !ledb_handle;
 
@@ -988,7 +1004,7 @@ static int light_init(void)
 		light_status_supported = acpi_evalf(ec_handle, NULL,
 						    "KBLT", "qv");
 
-	return 0;
+	return (light_supported)? 0 : 1;
 }
 
 static int light_read(char *p)
@@ -1044,9 +1060,6 @@ static int light_write(char *buf)
  * Dock subdriver
  */
 
-/* don't list other alternatives as we install a notify handler on the 570 */
-IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
-
 #ifdef CONFIG_THINKPAD_ACPI_DOCK
 
 IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
@@ -1055,8 +1068,19 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
 
+/* don't list other alternatives as we install a notify handler on the 570 */
+IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
+
 #define dock_docked() (_sta(dock_handle) & 1)
 
+static int dock_init(void)
+{
+	IBM_HANDLE_INIT(dock);
+	IBM_HANDLE_INIT(pci);
+
+	return (dock_handle)? 0 : 1;
+}
+
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
@@ -1147,6 +1171,13 @@ IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 
 static int bay_init(void)
 {
+	IBM_HANDLE_INIT(bay);
+	if (bay_handle)
+		IBM_HANDLE_INIT(bay_ej);
+	IBM_HANDLE_INIT(bay2);
+	if (bay2_handle)
+		IBM_HANDLE_INIT(bay2_ej);
+
 	bay_status_supported = bay_handle &&
 	    acpi_evalf(bay_handle, NULL, "_STA", "qv");
 	bay_status2_supported = bay2_handle &&
@@ -1157,7 +1188,8 @@ static int bay_init(void)
 	bay_eject2_supported = bay2_handle && bay2_ej_handle &&
 	    (strlencmp(bay2_ej_path, "_EJ0") == 0 || experimental);
 
-	return 0;
+	return (bay_status_supported || bay_eject_supported ||
+		bay_status2_supported || bay_eject2_supported)? 0 : 1;
 }
 
 static void bay_notify(struct ibm_struct *ibm, u32 event)
@@ -1221,6 +1253,13 @@ static int bay_write(char *buf)
  * CMOS subdriver
  */
 
+static int cmos_init(void)
+{
+	IBM_HANDLE_INIT(cmos);
+
+	return (cmos_handle)? 0 : 1;
+}
+
 static int cmos_eval(int cmos_cmd)
 {
 	if (cmos_handle)
@@ -1281,6 +1320,8 @@ IBM_HANDLE(led, ec, "SLED",	/* 570 */
 
 static int led_init(void)
 {
+	IBM_HANDLE_INIT(led);
+
 	if (!led_handle)
 		/* led not supported on R30, R31 */
 		led_supported = TPACPI_LED_NONE;
@@ -1294,7 +1335,7 @@ static int led_init(void)
 		/* all others */
 		led_supported = TPACPI_LED_NEW;
 
-	return 0;
+	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
 }
 
 #define led_status(s) ((s) == 0 ? "off" : ((s) == 1 ? "on" : "blinking"))
@@ -1391,6 +1432,13 @@ static int led_write(char *buf)
 
 IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 
+static int beep_init(void)
+{
+	IBM_HANDLE_INIT(beep);
+
+	return (beep_handle)? 0 : 1;
+}
+
 static int beep_read(char *p)
 {
 	int len = 0;
@@ -1436,7 +1484,9 @@ static int thermal_init(void)
 {
 	u8 t, ta1, ta2;
 	int i;
-	int acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
+	int acpi_tmp7;
+
+	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
 
 	if (ibm_thinkpad_ec_found && experimental) {
 		/*
@@ -1492,7 +1542,7 @@ static int thermal_init(void)
 		thermal_read_mode = TPACPI_THERMAL_NONE;
 	}
 
-	return 0;
+	return (thermal_read_mode != TPACPI_THERMAL_NONE)? 0 : 1;
 }
 
 static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
@@ -1973,6 +2023,10 @@ static int fan_init(void)
 	fan_control_status_known = 1;
 	fan_watchdog_maxinterval = 0;
 
+	IBM_HANDLE_INIT(fans);
+	IBM_HANDLE_INIT(gfan);
+	IBM_HANDLE_INIT(sfan);
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
@@ -2010,7 +2064,7 @@ static int fan_init(void)
 			printk(IBM_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
 			       "fan status and control unavailable\n");
-			return 0;
+			return 1;
 		}
 	}
 
@@ -2041,7 +2095,9 @@ static int fan_init(void)
 		}
 	}
 
-	return 0;
+	return (fan_status_access_mode != TPACPI_FAN_NONE ||
+	        fan_control_access_mode != TPACPI_FAN_WR_NONE)?
+			0 : 1;
 }
 
 static int fan_get_status(u8 *status)
@@ -2485,6 +2541,7 @@ static struct ibm_struct ibms[] = {
 #ifdef CONFIG_THINKPAD_ACPI_DOCK
 	{
 	 .name = "dock",
+	 .init = dock_init,
 	 .read = dock_read,
 	 .write = dock_write,
 	 .notify = dock_notify,
@@ -2512,6 +2569,7 @@ static struct ibm_struct ibms[] = {
 #endif /* CONFIG_THINKPAD_ACPI_BAY */
 	{
 	 .name = "cmos",
+	 .init = cmos_init,
 	 .read = cmos_read,
 	 .write = cmos_write,
 	 },
@@ -2523,6 +2581,7 @@ static struct ibm_struct ibms[] = {
 	 },
 	{
 	 .name = "beep",
+	 .init = beep_init,
 	 .read = beep_read,
 	 .write = beep_write,
 	 },
@@ -2571,20 +2630,33 @@ static int __init ibm_init(struct ibm_struct *ibm)
 	if (ibm->experimental && !experimental)
 		return 0;
 
-	if (ibm->hid) {
-		ret = register_tpacpi_subdriver(ibm);
-		if (ret < 0)
-			return ret;
-		ibm->driver_registered = 1;
-	}
-
 	if (ibm->init) {
 		ret = ibm->init();
-		if (ret != 0)
+		if (ret > 0)
+			return 0;	/* probe failed */
+		if (ret)
 			return ret;
 		ibm->init_called = 1;
 	}
 
+	if (ibm->hid) {
+		ret = register_tpacpi_subdriver(ibm);
+		if (ret)
+			goto err_out;
+	}
+
+	if (ibm->notify) {
+		ret = setup_notify(ibm);
+		if (ret == -ENODEV) {
+			printk(IBM_NOTICE "disabling subdriver %s\n",
+				ibm->name);
+			ret = 0;
+			goto err_out;
+		}
+		if (ret < 0)
+			goto err_out;
+	}
+
 	if (ibm->read) {
 		entry = create_proc_entry(ibm->name,
 					  S_IFREG | S_IRUGO | S_IWUSR,
@@ -2592,7 +2664,8 @@ static int __init ibm_init(struct ibm_struct *ibm)
 		if (!entry) {
 			printk(IBM_ERR "unable to create proc entry %s\n",
 			       ibm->name);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_out;
 		}
 		entry->owner = THIS_MODULE;
 		entry->data = ibm;
@@ -2602,36 +2675,36 @@ static int __init ibm_init(struct ibm_struct *ibm)
 		ibm->proc_created = 1;
 	}
 
-	if (ibm->notify) {
-		ret = setup_notify(ibm);
-		if (ret == -ENODEV) {
-			printk(IBM_NOTICE "disabling subdriver %s\n",
-				ibm->name);
-			ibm_exit(ibm);
-			return 0;
-		}
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
+
+err_out:
+	ibm_exit(ibm);
+	return (ret < 0)? ret : 0;
 }
 
 static void ibm_exit(struct ibm_struct *ibm)
 {
-	if (ibm->notify_installed)
+	if (ibm->notify_installed) {
 		acpi_remove_notify_handler(*ibm->handle, ibm->type,
 					   dispatch_notify);
+		ibm->notify_installed = 0;
+	}
 
-	if (ibm->proc_created)
+	if (ibm->proc_created) {
 		remove_proc_entry(ibm->name, proc_dir);
-
-	if (ibm->init_called && ibm->exit)
-		ibm->exit();
+		ibm->proc_created = 0;
+	}
 
 	if (ibm->driver_registered) {
 		acpi_bus_unregister_driver(ibm->driver);
 		kfree(ibm->driver);
+		ibm->driver = NULL;
+		ibm->driver_registered = 0;
+	}
+
+	if (ibm->init_called && ibm->exit) {
+		ibm->exit();
+		ibm->init_called = 0;
 	}
 }
 
@@ -2663,6 +2736,32 @@ static char* __init check_dmi_for_ec(void)
 	return NULL;
 }
 
+static int __init probe_for_thinkpad(void)
+{
+	int is_thinkpad;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/*
+	 * Non-ancient models have better DMI tagging, but very old models
+	 * don't.
+	 */
+	is_thinkpad = dmi_name_in_vendors("ThinkPad");
+
+	/* ec is required because many other handles are relative to it */
+	IBM_HANDLE_INIT(ec);
+	if (!ec_handle) {
+		if (is_thinkpad)
+			printk(IBM_ERR
+				"Not yet supported ThinkPad detected!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+
 /* Module init, exit, parameters */
 
 static int __init set_ibm_param(const char *val, struct kernel_param *kp)
@@ -2712,45 +2811,13 @@ static int __init thinkpad_acpi_module_init(void)
 {
 	int ret, i;
 
-	if (acpi_disabled)
-		return -ENODEV;
+	ret = probe_for_thinkpad();
+	if (ret)
+		return ret;
 
-	/* ec is required because many other handles are relative to it */
-	IBM_HANDLE_INIT(ec);
-	if (!ec_handle) {
-		printk(IBM_ERR "ec object not found\n");
-		return -ENODEV;
-	}
-
-	/* Models with newer firmware report the EC in DMI */
 	ibm_thinkpad_ec_found = check_dmi_for_ec();
-
-	/* these handles are not required */
-	IBM_HANDLE_INIT(vid);
-	IBM_HANDLE_INIT(vid2);
-	IBM_HANDLE_INIT(ledb);
-	IBM_HANDLE_INIT(led);
-	IBM_HANDLE_INIT(hkey);
-	IBM_HANDLE_INIT(lght);
-	IBM_HANDLE_INIT(cmos);
-#ifdef CONFIG_THINKPAD_ACPI_DOCK
-	IBM_HANDLE_INIT(dock);
-#endif
-	IBM_HANDLE_INIT(pci);
-#ifdef CONFIG_THINKPAD_ACPI_BAY
-	IBM_HANDLE_INIT(bay);
-	if (bay_handle)
-		IBM_HANDLE_INIT(bay_ej);
-	IBM_HANDLE_INIT(bay2);
-	if (bay2_handle)
-		IBM_HANDLE_INIT(bay2_ej);
-#endif /* CONFIG_THINKPAD_ACPI_BAY */
-	IBM_HANDLE_INIT(beep);
 	IBM_HANDLE_INIT(ecrd);
 	IBM_HANDLE_INIT(ecwr);
-	IBM_HANDLE_INIT(fans);
-	IBM_HANDLE_INIT(gfan);
-	IBM_HANDLE_INIT(sfan);
 
 	proc_dir = proc_mkdir(IBM_DIR, acpi_root_dir);
 	if (!proc_dir) {
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index b2348d7..06d4c38 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -104,7 +104,7 @@ static acpi_handle ecrd_handle, ecwr_handle;	/* 570 EC access */
 static acpi_handle cmos_handle, hkey_handle;	/* basic thinkpad handles */
 
 static void ibm_handle_init(char *name,
-		   acpi_handle * handle, acpi_handle parent,
+		   acpi_handle *handle, acpi_handle parent,
 		   char **paths, int num_paths, char **path);
 #define IBM_HANDLE_INIT(object)						\
 	ibm_handle_init(#object, &object##_handle, *object##_parent,	\
@@ -242,8 +242,8 @@ static int cmos_write(char *buf);
  * Dock subdriver
  */
 
-static acpi_handle pci_handle;
 #ifdef CONFIG_THINKPAD_ACPI_DOCK
+static acpi_handle pci_handle;
 static acpi_handle dock_handle;
 
 static void dock_notify(struct ibm_struct *ibm, u32 event);
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
