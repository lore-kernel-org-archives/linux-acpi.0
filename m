From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 08/20] ACPI: thinkpad-acpi: add subdriver
	debug statements
Date: Sat, 21 Apr 2007 11:08:32 -0300
Message-ID: <11771645271333-git-send-email-hmh@hmh.eng.br>
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

Add debug messages to the subdriver initialization and exit code.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    4 ++
 drivers/misc/thinkpad_acpi.c    |  111 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/thinkpad_acpi.h    |    4 ++
 3 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 82fd822..20d5ec3 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -710,5 +710,9 @@ enable various classes of debugging output, for example:
 will enable all debugging output classes.  It takes a bitmask, so
 to enable more than one output class, just add their values.
 
+	Debug bitmask		Description
+	0x0001			Initialization and probing
+	0x0002			Removal
+
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index eeab394..e8fc8da 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -313,6 +313,9 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	if (!*ibm->handle)
 		return 0;
 
+	dbg_printk(TPACPI_DBG_INIT,
+		"setting up ACPI notify for %s\n", ibm->name);
+
 	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
@@ -349,6 +352,9 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 {
 	int ret;
 
+	dbg_printk(TPACPI_DBG_INIT,
+		"registering %s as an ACPI driver\n", ibm->name);
+
 	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->driver) {
 		printk(IBM_ERR "kzalloc(ibm->driver) failed\n");
@@ -497,17 +503,25 @@ static int hotkey_orig_mask;
 
 static int hotkey_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
+
 	IBM_HANDLE_INIT(hkey);
 
 	/* hotkey not supported on 570 */
 	hotkey_supported = hkey_handle != NULL;
 
+	vdbg_printk(TPACPI_DBG_INIT, "hotkeys are %s\n",
+		str_supported(hotkey_supported));
+
 	if (hotkey_supported) {
 		/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 		   A30, R30, R31, T20-22, X20-21, X22-24 */
 		hotkey_mask_supported =
 		    acpi_evalf(hkey_handle, NULL, "DHKN", "qv");
 
+		vdbg_printk(TPACPI_DBG_INIT, "hotkey masks are %s\n",
+			str_supported(hotkey_mask_supported));
+
 		if (!hotkey_get(&hotkey_orig_status, &hotkey_orig_mask))
 			return -ENODEV;
 	}
@@ -518,6 +532,7 @@ static int hotkey_init(void)
 static void hotkey_exit(void)
 {
 	if (hotkey_supported) {
+		dbg_printk(TPACPI_DBG_EXIT, "restoring original hotkey mask\n");
 		hotkey_set(hotkey_orig_status, hotkey_orig_mask);
 	}
 }
@@ -633,6 +648,8 @@ static int bluetooth_supported;
 
 static int bluetooth_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
+
 	IBM_HANDLE_INIT(hkey);
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
@@ -640,6 +657,9 @@ static int bluetooth_init(void)
 	bluetooth_supported = hkey_handle &&
 	    acpi_evalf(hkey_handle, NULL, "GBDC", "qv");
 
+	vdbg_printk(TPACPI_DBG_INIT, "bluetooth is %s\n",
+		str_supported(bluetooth_supported));
+
 	return (bluetooth_supported)? 0 : 1;
 }
 
@@ -704,11 +724,16 @@ static int wan_supported;
 
 static int wan_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
+
 	IBM_HANDLE_INIT(hkey);
 
 	wan_supported = hkey_handle &&
 	    acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
 
+	vdbg_printk(TPACPI_DBG_INIT, "wan is %s\n",
+		str_supported(wan_supported));
+
 	return (wan_supported)? 0 : 1;
 }
 
@@ -784,6 +809,8 @@ static int video_init(void)
 {
 	int ivga;
 
+	vdbg_printk(TPACPI_DBG_INIT, "initializing video subdriver\n");
+
 	IBM_HANDLE_INIT(vid);
 	IBM_HANDLE_INIT(vid2);
 
@@ -804,11 +831,16 @@ static int video_init(void)
 		/* all others */
 		video_supported = TPACPI_VIDEO_NEW;
 
+	vdbg_printk(TPACPI_DBG_INIT, "video is %s, mode %d\n",
+		str_supported(video_supported != TPACPI_VIDEO_NONE),
+		video_supported);
+
 	return (video_supported != TPACPI_VIDEO_NONE)? 0 : 1;
 }
 
 static void video_exit(void)
 {
+	dbg_printk(TPACPI_DBG_EXIT, "restoring original video autoswitch mode\n");
 	acpi_evalf(vid_handle, NULL, "_DOS", "vd", video_orig_autosw);
 }
 
@@ -991,6 +1023,8 @@ IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
 static int light_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
+
 	IBM_HANDLE_INIT(ledb);
 	IBM_HANDLE_INIT(lght);
 	IBM_HANDLE_INIT(cmos);
@@ -1004,6 +1038,9 @@ static int light_init(void)
 		light_status_supported = acpi_evalf(ec_handle, NULL,
 						    "KBLT", "qv");
 
+	vdbg_printk(TPACPI_DBG_INIT, "light is %s\n",
+		str_supported(light_supported));
+
 	return (light_supported)? 0 : 1;
 }
 
@@ -1075,9 +1112,14 @@ IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
 static int dock_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
+
 	IBM_HANDLE_INIT(dock);
 	IBM_HANDLE_INIT(pci);
 
+	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
+		str_supported(dock_handle != NULL));
+
 	return (dock_handle)? 0 : 1;
 }
 
@@ -1171,6 +1213,8 @@ IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 
 static int bay_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing bay subdriver\n");
+
 	IBM_HANDLE_INIT(bay);
 	if (bay_handle)
 		IBM_HANDLE_INIT(bay_ej);
@@ -1188,6 +1232,13 @@ static int bay_init(void)
 	bay_eject2_supported = bay2_handle && bay2_ej_handle &&
 	    (strlencmp(bay2_ej_path, "_EJ0") == 0 || experimental);
 
+	vdbg_printk(TPACPI_DBG_INIT,
+		"bay 1: status %s, eject %s; bay 2: status %s, eject %s\n",
+		str_supported(bay_status_supported),
+		str_supported(bay_eject_supported),
+		str_supported(bay_status2_supported),
+		str_supported(bay_eject2_supported));
+
 	return (bay_status_supported || bay_eject_supported ||
 		bay_status2_supported || bay_eject2_supported)? 0 : 1;
 }
@@ -1255,8 +1306,13 @@ static int bay_write(char *buf)
 
 static int cmos_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT,
+		"initializing cmos commands subdriver\n");
+
 	IBM_HANDLE_INIT(cmos);
 
+	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
+		str_supported(cmos_handle != NULL));
 	return (cmos_handle)? 0 : 1;
 }
 
@@ -1320,6 +1376,8 @@ IBM_HANDLE(led, ec, "SLED",	/* 570 */
 
 static int led_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
+
 	IBM_HANDLE_INIT(led);
 
 	if (!led_handle)
@@ -1335,6 +1393,9 @@ static int led_init(void)
 		/* all others */
 		led_supported = TPACPI_LED_NEW;
 
+	vdbg_printk(TPACPI_DBG_INIT, "LED commands are %s, mode %d\n",
+		str_supported(led_supported), led_supported);
+
 	return (led_supported != TPACPI_LED_NONE)? 0 : 1;
 }
 
@@ -1434,8 +1495,13 @@ IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 
 static int beep_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing beep subdriver\n");
+
 	IBM_HANDLE_INIT(beep);
 
+	vdbg_printk(TPACPI_DBG_INIT, "beep is %s\n",
+		str_supported(beep_handle != NULL));
+
 	return (beep_handle)? 0 : 1;
 }
 
@@ -1486,6 +1552,8 @@ static int thermal_init(void)
 	int i;
 	int acpi_tmp7;
 
+	vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
+
 	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
 
 	if (ibm_thinkpad_ec_found && experimental) {
@@ -1542,6 +1610,10 @@ static int thermal_init(void)
 		thermal_read_mode = TPACPI_THERMAL_NONE;
 	}
 
+	vdbg_printk(TPACPI_DBG_INIT, "thermal is %s, mode %d\n",
+		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
+		thermal_read_mode);
+
 	return (thermal_read_mode != TPACPI_THERMAL_NONE)? 0 : 1;
 }
 
@@ -1698,6 +1770,8 @@ static int brightness_init(void)
 {
 	int b;
 
+	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
+
 	b = brightness_get(NULL);
 	if (b < 0)
 		return b;
@@ -1708,6 +1782,7 @@ static int brightness_init(void)
 		printk(IBM_ERR "Could not register backlight device\n");
 		return PTR_ERR(ibm_backlight_device);
 	}
+	vdbg_printk(TPACPI_DBG_INIT, "brightness is supported\n");
 
 	ibm_backlight_device->props.max_brightness = 7;
 	ibm_backlight_device->props.brightness = b;
@@ -1719,6 +1794,8 @@ static int brightness_init(void)
 static void brightness_exit(void)
 {
 	if (ibm_backlight_device) {
+		vdbg_printk(TPACPI_DBG_EXIT,
+			    "calling backlight_device_unregister()\n");
 		backlight_device_unregister(ibm_backlight_device);
 		ibm_backlight_device = NULL;
 	}
@@ -2017,6 +2094,8 @@ IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
 
 static int fan_init(void)
 {
+	vdbg_printk(TPACPI_DBG_INIT, "initializing fan subdriver\n");
+
 	fan_status_access_mode = TPACPI_FAN_NONE;
 	fan_control_access_mode = TPACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
@@ -2095,6 +2174,11 @@ static int fan_init(void)
 		}
 	}
 
+	vdbg_printk(TPACPI_DBG_INIT, "fan is %s, modes %d, %d\n",
+		str_supported(fan_status_access_mode != TPACPI_FAN_NONE ||
+		  fan_control_access_mode != TPACPI_FAN_WR_NONE),
+		fan_status_access_mode, fan_control_access_mode);
+
 	return (fan_status_access_mode != TPACPI_FAN_NONE ||
 	        fan_control_access_mode != TPACPI_FAN_WR_NONE)?
 			0 : 1;
@@ -2138,6 +2222,7 @@ static int fan_get_status(u8 *status)
 
 static void fan_exit(void)
 {
+	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending watchdogs\n");
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_scheduled_work();
 }
@@ -2622,6 +2707,15 @@ static struct ibm_struct ibms[] = {
  * Module and infrastructure proble, init and exit handling
  */
 
+#ifdef CONFIG_THINKPAD_ACPI_DEBUG
+static const char * str_supported(int is_supported)
+{
+	static const char * const text_unsupported = "not supported";
+
+	return (is_supported)? text_unsupported + 4 : text_unsupported;
+}
+#endif /* CONFIG_THINKPAD_ACPI_DEBUG */
+
 static int __init ibm_init(struct ibm_struct *ibm)
 {
 	int ret;
@@ -2630,6 +2724,9 @@ static int __init ibm_init(struct ibm_struct *ibm)
 	if (ibm->experimental && !experimental)
 		return 0;
 
+	dbg_printk(TPACPI_DBG_INIT,
+		"probing for %s\n", ibm->name);
+
 	if (ibm->init) {
 		ret = ibm->init();
 		if (ret > 0)
@@ -2657,6 +2754,9 @@ static int __init ibm_init(struct ibm_struct *ibm)
 			goto err_out;
 	}
 
+	dbg_printk(TPACPI_DBG_INIT,
+		"%s installed\n", ibm->name);
+
 	if (ibm->read) {
 		entry = create_proc_entry(ibm->name,
 					  S_IFREG | S_IRUGO | S_IWUSR,
@@ -2678,24 +2778,35 @@ static int __init ibm_init(struct ibm_struct *ibm)
 	return 0;
 
 err_out:
+	dbg_printk(TPACPI_DBG_INIT,
+		"%s: at error exit path with result %d\n",
+		ibm->name, ret);
+
 	ibm_exit(ibm);
 	return (ret < 0)? ret : 0;
 }
 
 static void ibm_exit(struct ibm_struct *ibm)
 {
+	dbg_printk(TPACPI_DBG_EXIT, "removing %s\n", ibm->name);
 	if (ibm->notify_installed) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: acpi_remove_notify_handler\n", ibm->name);
 		acpi_remove_notify_handler(*ibm->handle, ibm->type,
 					   dispatch_notify);
 		ibm->notify_installed = 0;
 	}
 
 	if (ibm->proc_created) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: remove_proc_entry\n", ibm->name);
 		remove_proc_entry(ibm->name, proc_dir);
 		ibm->proc_created = 0;
 	}
 
 	if (ibm->driver_registered) {
+		dbg_printk(TPACPI_DBG_EXIT,
+			"%s: acpi_bus_unregister_driver\n", ibm->name);
 		acpi_bus_unregister_driver(ibm->driver);
 		kfree(ibm->driver);
 		ibm->driver = NULL;
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 06d4c38..beb1447 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -76,12 +76,16 @@
 
 /* Debugging */
 #define TPACPI_DBG_ALL		0xffff
+#define TPACPI_DBG_ALL		0xffff
+#define TPACPI_DBG_INIT		0x0001
+#define TPACPI_DBG_EXIT		0x0002
 #define dbg_printk(a_dbg_level, format, arg...) \
 	do { if (dbg_level & a_dbg_level) \
 		printk(IBM_DEBUG "%s: " format, __func__ , ## arg); } while (0)
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
 #define vdbg_printk(a_dbg_level, format, arg...) \
 	dbg_printk(a_dbg_level, format, ## arg)
+static const char *str_supported(int is_supported);
 #else
 #define vdbg_printk(a_dbg_level, format, arg...)
 #endif
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
