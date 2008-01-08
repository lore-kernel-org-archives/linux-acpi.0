From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 11/20] ACPI: thinkpad-acpi: rename IBM in
	defines
Date: Tue,  8 Jan 2008 13:02:48 -0200
Message-ID: <1199804577-32017-12-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rename defines with IBM in their name that are related to the older
driver name (ibm-acpi) to TPACPI, unless they are specific to IBM
ThinkPads.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  324 +++++++++++++++++++++---------------------
 1 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index be04f1c..c92ae8d 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define IBM_VERSION "0.18"
+#define TPACPI_VERSION "0.18"
 #define TPACPI_SYSFS_VERSION 0x020101
 
 /*
@@ -113,7 +113,7 @@ enum {
 };
 
 /* ACPI HIDs */
-#define IBM_HKEY_HID    "IBM0068"
+#define TPACPI_ACPI_HKEY_HID		"IBM0068"
 
 /* Input IDs */
 #define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
@@ -124,25 +124,25 @@ enum {
  * Main driver
  */
 
-#define IBM_NAME "thinkpad"
-#define IBM_DESC "ThinkPad ACPI Extras"
-#define IBM_FILE IBM_NAME "_acpi"
-#define IBM_URL "http://ibm-acpi.sf.net/"
-#define IBM_MAIL "ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
+#define TPACPI_NAME "thinkpad"
+#define TPACPI_DESC "ThinkPad ACPI Extras"
+#define TPACPI_FILE TPACPI_NAME "_acpi"
+#define TPACPI_URL "http://ibm-acpi.sf.net/"
+#define TPACPI_MAIL "ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
 
-#define IBM_PROC_DIR "ibm"
-#define IBM_ACPI_EVENT_PREFIX "ibm"
-#define IBM_DRVR_NAME IBM_FILE
-#define IBM_HWMON_DRVR_NAME IBM_NAME "_hwmon"
+#define TPACPI_PROC_DIR "ibm"
+#define TPACPI_ACPI_EVENT_PREFIX "ibm"
+#define TPACPI_DRVR_NAME TPACPI_FILE
+#define TPACPI_HWMON_DRVR_NAME TPACPI_NAME "_hwmon"
 
-#define IBM_MAX_ACPI_ARGS 3
+#define TPACPI_MAX_ACPI_ARGS 3
 
 /* Debugging */
-#define IBM_LOG IBM_FILE ": "
-#define IBM_ERR	   KERN_ERR    IBM_LOG
-#define IBM_NOTICE KERN_NOTICE IBM_LOG
-#define IBM_INFO   KERN_INFO   IBM_LOG
-#define IBM_DEBUG  KERN_DEBUG  IBM_LOG
+#define TPACPI_LOG TPACPI_FILE ": "
+#define TPACPI_ERR	   KERN_ERR    TPACPI_LOG
+#define TPACPI_NOTICE KERN_NOTICE TPACPI_LOG
+#define TPACPI_INFO   KERN_INFO   TPACPI_LOG
+#define TPACPI_DEBUG  KERN_DEBUG  TPACPI_LOG
 
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_ALL		0xffff
@@ -150,7 +150,7 @@ enum {
 #define TPACPI_DBG_EXIT		0x0002
 #define dbg_printk(a_dbg_level, format, arg...) \
 	do { if (dbg_level & a_dbg_level) \
-		printk(IBM_DEBUG "%s: " format, __func__ , ## arg); } while (0)
+		printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); } while (0)
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
 #define vdbg_printk(a_dbg_level, format, arg...) \
 	dbg_printk(a_dbg_level, format, ## arg)
@@ -270,13 +270,13 @@ static u32 dbg_level;
 
 static acpi_handle root_handle;
 
-#define IBM_HANDLE(object, parent, paths...)			\
+#define TPACPI_HANDLE(object, parent, paths...)			\
 	static acpi_handle  object##_handle;			\
 	static acpi_handle *object##_parent = &parent##_handle;	\
 	static char        *object##_path;			\
 	static char        *object##_paths[] = { paths }
 
-IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
+TPACPI_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 	   "\\_SB.PCI.ISA.EC",	/* 570 */
 	   "\\_SB.PCI0.ISA0.EC0",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.ISA.EC",	/* A21e, A2xm/p, T20-22, X20-21 */
@@ -285,15 +285,15 @@ IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 	   "\\_SB.PCI0.LPC.EC",	/* all others */
 	   );
 
-IBM_HANDLE(ecrd, ec, "ECRD");	/* 570 */
-IBM_HANDLE(ecwr, ec, "ECWR");	/* 570 */
+TPACPI_HANDLE(ecrd, ec, "ECRD");	/* 570 */
+TPACPI_HANDLE(ecwr, ec, "ECWR");	/* 570 */
 
-IBM_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, T4x, X31, X40 */
+TPACPI_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, T4x, X31, X40 */
 	   "\\CMOS",		/* A3x, G4x, R32, T23, T30, X22-24, X30 */
 	   "\\CMS",		/* R40, R40e */
 	   );			/* all others */
 
-IBM_HANDLE(hkey, ec, "\\_SB.HKEY",	/* 600e/x, 770e, 770x */
+TPACPI_HANDLE(hkey, ec, "\\_SB.HKEY",	/* 600e/x, 770e, 770x */
 	   "^HKEY",		/* R30, R31 */
 	   "HKEY",		/* all others */
 	   );			/* 570 */
@@ -308,7 +308,7 @@ static int acpi_evalf(acpi_handle handle,
 {
 	char *fmt0 = fmt;
 	struct acpi_object_list params;
-	union acpi_object in_objs[IBM_MAX_ACPI_ARGS];
+	union acpi_object in_objs[TPACPI_MAX_ACPI_ARGS];
 	struct acpi_buffer result, *resultp;
 	union acpi_object out_obj;
 	acpi_status status;
@@ -318,7 +318,7 @@ static int acpi_evalf(acpi_handle handle,
 	int quiet;
 
 	if (!*fmt) {
-		printk(IBM_ERR "acpi_evalf() called with empty format\n");
+		printk(TPACPI_ERR "acpi_evalf() called with empty format\n");
 		return 0;
 	}
 
@@ -343,7 +343,7 @@ static int acpi_evalf(acpi_handle handle,
 			break;
 			/* add more types as needed */
 		default:
-			printk(IBM_ERR "acpi_evalf() called "
+			printk(TPACPI_ERR "acpi_evalf() called "
 			       "with invalid format character '%c'\n", c);
 			return 0;
 		}
@@ -370,13 +370,13 @@ static int acpi_evalf(acpi_handle handle,
 		break;
 		/* add more types as needed */
 	default:
-		printk(IBM_ERR "acpi_evalf() called "
+		printk(TPACPI_ERR "acpi_evalf() called "
 		       "with invalid format character '%c'\n", res_type);
 		return 0;
 	}
 
 	if (!success && !quiet)
-		printk(IBM_ERR "acpi_evalf(%s, %s, ...) failed: %d\n",
+		printk(TPACPI_ERR "acpi_evalf(%s, %s, ...) failed: %d\n",
 		       method, fmt0, status);
 
 	return success;
@@ -436,7 +436,7 @@ static int issue_thinkpad_cmos_command(int cmos_cmd)
  * ACPI device model
  */
 
-#define IBM_ACPIHANDLE_INIT(object)						\
+#define TPACPI_ACPIHANDLE_INIT(object)						\
 	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
@@ -494,24 +494,24 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 
 	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
 	if (rc < 0) {
-		printk(IBM_ERR "acpi_bus_get_device(%s) failed: %d\n",
+		printk(TPACPI_ERR "acpi_bus_get_device(%s) failed: %d\n",
 			ibm->name, rc);
 		return -ENODEV;
 	}
 
 	acpi_driver_data(ibm->acpi->device) = ibm;
 	sprintf(acpi_device_class(ibm->acpi->device), "%s/%s",
-		IBM_ACPI_EVENT_PREFIX,
+		TPACPI_ACPI_EVENT_PREFIX,
 		ibm->name);
 
 	status = acpi_install_notify_handler(*ibm->acpi->handle,
 			ibm->acpi->type, dispatch_acpi_notify, ibm);
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_ALREADY_EXISTS) {
-			printk(IBM_NOTICE "another device driver is already handling %s events\n",
+			printk(TPACPI_NOTICE "another device driver is already handling %s events\n",
 				ibm->name);
 		} else {
-			printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
+			printk(TPACPI_ERR "acpi_install_notify_handler(%s) failed: %d\n",
 				ibm->name, status);
 		}
 		return -ENODEV;
@@ -536,18 +536,18 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 
 	ibm->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->acpi->driver) {
-		printk(IBM_ERR "kzalloc(ibm->driver) failed\n");
+		printk(TPACPI_ERR "kzalloc(ibm->driver) failed\n");
 		return -ENOMEM;
 	}
 
-	sprintf(ibm->acpi->driver->name, "%s_%s", IBM_NAME, ibm->name);
+	sprintf(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name);
 	ibm->acpi->driver->ids = ibm->acpi->hid;
 
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
 	rc = acpi_bus_register_driver(ibm->acpi->driver);
 	if (rc < 0) {
-		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
+		printk(TPACPI_ERR "acpi_bus_register_driver(%s) failed: %d\n",
 		       ibm->name, rc);
 		kfree(ibm->acpi->driver);
 		ibm->acpi->driver = NULL;
@@ -670,7 +670,7 @@ static int tpacpi_resume_handler(struct platform_device *pdev)
 
 static struct platform_driver tpacpi_pdriver = {
 	.driver = {
-		.name = IBM_DRVR_NAME,
+		.name = TPACPI_DRVR_NAME,
 		.owner = THIS_MODULE,
 	},
 	.resume = tpacpi_resume_handler,
@@ -678,7 +678,7 @@ static struct platform_driver tpacpi_pdriver = {
 
 static struct platform_driver tpacpi_hwmon_pdriver = {
 	.driver = {
-		.name = IBM_HWMON_DRVR_NAME,
+		.name = TPACPI_HWMON_DRVR_NAME,
 		.owner = THIS_MODULE,
 	},
 };
@@ -818,7 +818,7 @@ static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO,
 static ssize_t tpacpi_driver_version_show(struct device_driver *drv,
 						char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s v%s\n", IBM_DESC, IBM_VERSION);
+	return snprintf(buf, PAGE_SIZE, "%s v%s\n", TPACPI_DESC, TPACPI_VERSION);
 }
 
 static DRIVER_ATTR(version, S_IRUGO,
@@ -867,17 +867,17 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 
 static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
 {
-	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
-	printk(IBM_INFO "%s\n", IBM_URL);
+	printk(TPACPI_INFO "%s v%s\n", TPACPI_DESC, TPACPI_VERSION);
+	printk(TPACPI_INFO "%s\n", TPACPI_URL);
 
-	printk(IBM_INFO "ThinkPad BIOS %s, EC %s\n",
+	printk(TPACPI_INFO "ThinkPad BIOS %s, EC %s\n",
 		(thinkpad_id.bios_version_str) ?
 			thinkpad_id.bios_version_str : "unknown",
 		(thinkpad_id.ec_version_str) ?
 			thinkpad_id.ec_version_str : "unknown");
 
 	if (thinkpad_id.vendor && thinkpad_id.model_str)
-		printk(IBM_INFO "%s %s\n",
+		printk(TPACPI_INFO "%s %s\n",
 			(thinkpad_id.vendor == PCI_VENDOR_ID_IBM) ?
 				"IBM" : ((thinkpad_id.vendor ==
 						PCI_VENDOR_ID_LENOVO) ?
@@ -891,8 +891,8 @@ static int thinkpad_acpi_driver_read(char *p)
 {
 	int len = 0;
 
-	len += sprintf(p + len, "driver:\t\t%s\n", IBM_DESC);
-	len += sprintf(p + len, "version:\t%s\n", IBM_VERSION);
+	len += sprintf(p + len, "driver:\t\t%s\n", TPACPI_DESC);
+	len += sprintf(p + len, "version:\t%s\n", TPACPI_VERSION);
 
 	return len;
 }
@@ -1073,7 +1073,7 @@ static int hotkey_mask_set(u32 mask)
 		if (!hotkey_mask_get() && !rc &&
 		    (hotkey_mask & ~hotkey_source_mask) !=
 		     (mask & ~hotkey_source_mask)) {
-			printk(IBM_NOTICE
+			printk(TPACPI_NOTICE
 			       "requested hot key mask 0x%08x, but "
 			       "firmware forced it to 0x%08x\n",
 			       mask, hotkey_mask);
@@ -1085,7 +1085,7 @@ static int hotkey_mask_set(u32 mask)
 		HOTKEY_CONFIG_CRITICAL_END
 		hotkey_mask_get();
 		if (hotkey_mask != mask) {
-			printk(IBM_NOTICE
+			printk(TPACPI_NOTICE
 			       "requested hot key mask 0x%08x, "
 			       "forced to 0x%08x (NVRAM poll mask is "
 			       "0x%08x): no firmware mask support\n",
@@ -1352,10 +1352,10 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-			                       NULL, IBM_FILE "d");
+			                       NULL, TPACPI_FILE "d");
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
-				printk(IBM_ERR "could not create kernel thread "
+				printk(TPACPI_ERR "could not create kernel thread "
 				       "for hotkey polling\n");
 			}
 		}
@@ -1363,7 +1363,7 @@ static void hotkey_poll_setup(int may_warn)
 		hotkey_poll_stop_sync();
 		if (may_warn &&
 		    hotkey_source_mask != 0 && hotkey_poll_freq == 0) {
-			printk(IBM_NOTICE "hot keys 0x%08x require polling, "
+			printk(TPACPI_NOTICE "hot keys 0x%08x require polling, "
 				"which is currently disabled\n",
 				hotkey_source_mask);
 		}
@@ -1777,7 +1777,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	BUG_ON(tpacpi_inputdev->open != NULL ||
 	       tpacpi_inputdev->close != NULL);
 
-	IBM_ACPIHANDLE_INIT(hkey);
+	TPACPI_ACPIHANDLE_INIT(hkey);
 	mutex_init(&hotkey_mutex);
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
@@ -1806,10 +1806,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		   for HKEY interface version 0x100 */
 		if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
 			if ((hkeyv >> 8) != 1) {
-				printk(IBM_ERR "unknown version of the "
+				printk(TPACPI_ERR "unknown version of the "
 				       "HKEY interface: 0x%x\n", hkeyv);
-				printk(IBM_ERR "please report this to %s\n",
-				       IBM_MAIL);
+				printk(TPACPI_ERR "please report this to %s\n",
+				       TPACPI_MAIL);
 			} else {
 				/*
 				 * MHKV 0x100 in A31, R40, R40e,
@@ -1825,10 +1825,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		if (tp_features.hotkey_mask) {
 			if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
 					"MHKA", "qd")) {
-				printk(IBM_ERR
+				printk(TPACPI_ERR
 				       "missing MHKA handler, "
 				       "please report this to %s\n",
-				       IBM_MAIL);
+				       TPACPI_MAIL);
 				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
 			}
 		}
@@ -1863,7 +1863,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		/* Not all thinkpads have a hardware radio switch */
 		if (!res && acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
 			tp_features.hotkey_wlsw = 1;
-			printk(IBM_INFO
+			printk(TPACPI_INFO
 				"radio switch found; radios are %s\n",
 				enabled(status, 0));
 			res = add_to_attr_set(hotkey_dev_attributes,
@@ -1882,7 +1882,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
 						GFP_KERNEL);
 		if (!hotkey_keycode_map) {
-			printk(IBM_ERR "failed to allocate memory for key map\n");
+			printk(TPACPI_ERR "failed to allocate memory for key map\n");
 			return -ENOMEM;
 		}
 
@@ -1957,7 +1957,7 @@ static void hotkey_exit(void)
 		/* no short-circuit boolean operator below! */
 		if ((hotkey_mask_set(hotkey_orig_mask) |
 		     hotkey_status_set(hotkey_orig_status)) != 0)
-			printk(IBM_ERR "failed to restore hot key mask to BIOS defaults\n");
+			printk(TPACPI_ERR "failed to restore hot key mask to BIOS defaults\n");
 	}
 
 	if (hotkey_dev_attributes) {
@@ -1974,7 +1974,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	int ignore_acpi_ev;
 
 	if (event != 0x80) {
-		printk(IBM_ERR "unknown HKEY notification event %d\n", event);
+		printk(TPACPI_ERR "unknown HKEY notification event %d\n", event);
 		/* forward it to userspace, maybe it knows how to handle it */
 		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
 						ibm->acpi->device->dev.bus_id,
@@ -1984,7 +1984,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 
 	while (1) {
 		if (!acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
-			printk(IBM_ERR "failed to retrieve HKEY event\n");
+			printk(TPACPI_ERR "failed to retrieve HKEY event\n");
 			return;
 		}
 
@@ -2008,7 +2008,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 					ignore_acpi_ev = 1;
 				}
 			} else {
-				printk(IBM_ERR
+				printk(TPACPI_ERR
 				       "hotkey 0x%04x out of range for keyboard map\n",
 				       hkey);
 				send_acpi_ev = 1;
@@ -2019,7 +2019,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* we don't handle it through this path, just
 			 * eat up known LID events */
 			if (hkey != 0x5001 && hkey != 0x5002) {
-				printk(IBM_ERR
+				printk(TPACPI_ERR
 				       "unknown LID-related HKEY event: 0x%04x\n",
 				       hkey);
 				send_acpi_ev = 1;
@@ -2039,7 +2039,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/*	0x2305 - T43 waking up due to bay lever eject while aslept */
 			/* case 3: ultra-bay related. maybe bay in dock? */
 			/*	0x3003 - T43 after wake up by bay lever eject (0x2305) */
-			printk(IBM_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
+			printk(TPACPI_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
 			send_acpi_ev = 1;
 		}
 
@@ -2060,7 +2060,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 static void hotkey_resume(void)
 {
 	if (hotkey_mask_get())
-		printk(IBM_ERR "error while trying to read hot key mask from firmware\n");
+		printk(TPACPI_ERR "error while trying to read hot key mask from firmware\n");
 	tpacpi_input_send_radiosw();
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup_safe(0);
@@ -2145,7 +2145,7 @@ errexit:
 }
 
 static const struct acpi_device_id ibm_htk_device_ids[] = {
-	{IBM_HKEY_HID, 0},
+	{TPACPI_ACPI_HKEY_HID, 0},
 	{"", 0},
 };
 
@@ -2230,7 +2230,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bluetooth subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(hkey);
+	TPACPI_ACPIHANDLE_INIT(hkey);
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
@@ -2404,7 +2404,7 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing wan subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(hkey);
+	TPACPI_ACPIHANDLE_INIT(hkey);
 
 	tp_features.wan = hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GWAN", "qd");
@@ -2543,14 +2543,14 @@ static int video_orig_autosw;
 static int video_autosw_get(void);
 static int video_autosw_set(int enable);
 
-IBM_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
+TPACPI_HANDLE(vid, root, "\\_SB.PCI.AGP.VGA",	/* 570 */
 	   "\\_SB.PCI0.AGP0.VID0",	/* 600e/x, 770x */
 	   "\\_SB.PCI0.VID0",	/* 770e */
 	   "\\_SB.PCI0.VID",	/* A21e, G4x, R50e, X30, X40 */
 	   "\\_SB.PCI0.AGP.VID",	/* all others */
 	   );				/* R30, R31 */
 
-IBM_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
+TPACPI_HANDLE(vid2, root, "\\_SB.PCI0.AGPB.VID");	/* G41 */
 
 static int __init video_init(struct ibm_init_struct *iibm)
 {
@@ -2558,8 +2558,8 @@ static int __init video_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing video subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(vid);
-	IBM_ACPIHANDLE_INIT(vid2);
+	TPACPI_ACPIHANDLE_INIT(vid);
+	TPACPI_ACPIHANDLE_INIT(vid2);
 
 	if (vid2_handle && acpi_evalf(NULL, &ivga, "\\IVGA", "d") && ivga)
 		/* G41, assume IVGA doesn't change */
@@ -2590,7 +2590,7 @@ static void video_exit(void)
 	dbg_printk(TPACPI_DBG_EXIT,
 		   "restoring original video autoswitch mode\n");
 	if (video_autosw_set(video_orig_autosw))
-		printk(IBM_ERR "error while trying to restore original "
+		printk(TPACPI_ERR "error while trying to restore original "
 			"video autoswitch mode\n");
 }
 
@@ -2663,7 +2663,7 @@ static int video_outputsw_set(int status)
 		res = acpi_evalf(vid_handle, NULL,
 				 "ASWT", "vdd", status * 0x100, 0);
 		if (!autosw && video_autosw_set(autosw)) {
-			printk(IBM_ERR "video auto-switch left enabled due to error\n");
+			printk(TPACPI_ERR "video auto-switch left enabled due to error\n");
 			return -EIO;
 		}
 		break;
@@ -2732,7 +2732,7 @@ static int video_outputsw_cycle(void)
 		return -ENOSYS;
 	}
 	if (!autosw && video_autosw_set(autosw)) {
-		printk(IBM_ERR "video auto-switch left enabled due to error\n");
+		printk(TPACPI_ERR "video auto-switch left enabled due to error\n");
 		return -EIO;
 	}
 
@@ -2861,16 +2861,16 @@ static struct ibm_struct video_driver_data = {
  * Light (thinklight) subdriver
  */
 
-IBM_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
-IBM_HANDLE(ledb, ec, "LEDB");		/* G4x */
+TPACPI_HANDLE(lght, root, "\\LGHT");	/* A21e, A2xm/p, T20-22, X20-21 */
+TPACPI_HANDLE(ledb, ec, "LEDB");		/* G4x */
 
 static int __init light_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing light subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(ledb);
-	IBM_ACPIHANDLE_INIT(lght);
-	IBM_ACPIHANDLE_INIT(cmos);
+	TPACPI_ACPIHANDLE_INIT(ledb);
+	TPACPI_ACPIHANDLE_INIT(lght);
+	TPACPI_ACPIHANDLE_INIT(cmos);
 
 	/* light not supported on 570, 600e/x, 770e, 770x, G4x, R30, R31 */
 	tp_features.light = (cmos_handle || lght_handle) && !ledb_handle;
@@ -2952,14 +2952,14 @@ static void dock_notify(struct ibm_struct *ibm, u32 event);
 static int dock_read(char *p);
 static int dock_write(char *buf);
 
-IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
+TPACPI_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
 	   "\\_SB.PCI0.PCI1.DOCK",	/* all others */
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
 
 /* don't list other alternatives as we install a notify handler on the 570 */
-IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
+TPACPI_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
 static const struct acpi_device_id ibm_pci_device_ids[] = {
 	{PCI_ROOT_HID_STRING, 0},
@@ -3002,7 +3002,7 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(dock);
+	TPACPI_ACPIHANDLE_INIT(dock);
 
 	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
 		str_supported(dock_handle != NULL));
@@ -3018,7 +3018,7 @@ static int __init dock_init2(struct ibm_init_struct *iibm)
 
 	if (dock_driver_data[0].flags.acpi_driver_registered &&
 	    dock_driver_data[0].flags.acpi_notify_installed) {
-		IBM_ACPIHANDLE_INIT(pci);
+		TPACPI_ACPIHANDLE_INIT(pci);
 		dock2_needed = (pci_handle != NULL);
 		vdbg_printk(TPACPI_DBG_INIT,
 			    "dock PCI handler for the TP 570 is %s\n",
@@ -3050,7 +3050,7 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 	else if (event == 0 && docked)
 		data = 3;	/* dock */
 	else {
-		printk(IBM_ERR "unknown dock event %d, status %d\n",
+		printk(TPACPI_ERR "unknown dock event %d, status %d\n",
 		       event, _sta(dock_handle));
 		data = 0;	/* unknown */
 	}
@@ -3107,18 +3107,18 @@ static int dock_write(char *buf)
 
 #ifdef CONFIG_THINKPAD_ACPI_BAY
 
-IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
+TPACPI_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */
 	   "\\_SB.PCI0.IDE0.SCND.MSTR",	/* all others */
 	   );				/* A21e, R30, R31 */
-IBM_HANDLE(bay_ej, bay, "_EJ3",	/* 600e/x, A2xm/p, A3x */
+TPACPI_HANDLE(bay_ej, bay, "_EJ3",	/* 600e/x, A2xm/p, A3x */
 	   "_EJ0",		/* all others */
 	   );			/* 570,A21e,G4x,R30,R31,R32,R40e,R50e */
-IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
+TPACPI_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
 	   "\\_SB.PCI0.IDE0.IDEP.IDPS",	/* 600e/x, 770e, 770x */
 	   );				/* all others */
-IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
+TPACPI_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 	   "_EJ0",			/* 770x */
 	   );				/* all others */
 
@@ -3126,12 +3126,12 @@ static int __init bay_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing bay subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(bay);
+	TPACPI_ACPIHANDLE_INIT(bay);
 	if (bay_handle)
-		IBM_ACPIHANDLE_INIT(bay_ej);
-	IBM_ACPIHANDLE_INIT(bay2);
+		TPACPI_ACPIHANDLE_INIT(bay_ej);
+	TPACPI_ACPIHANDLE_INIT(bay2);
 	if (bay2_handle)
-		IBM_ACPIHANDLE_INIT(bay2_ej);
+		TPACPI_ACPIHANDLE_INIT(bay2_ej);
 
 	tp_features.bay_status = bay_handle &&
 		acpi_evalf(bay_handle, NULL, "_STA", "qv");
@@ -3260,7 +3260,7 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT,
 		"initializing cmos commands subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(cmos);
+	TPACPI_ACPIHANDLE_INIT(cmos);
 
 	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
 		str_supported(cmos_handle != NULL));
@@ -3339,7 +3339,7 @@ enum {	/* For TPACPI_LED_OLD */
 
 static enum led_access_mode led_supported;
 
-IBM_HANDLE(led, ec, "SLED",	/* 570 */
+TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
 	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
@@ -3348,7 +3348,7 @@ static int __init led_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing LED subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(led);
+	TPACPI_ACPIHANDLE_INIT(led);
 
 	if (!led_handle)
 		/* led not supported on R30, R31 */
@@ -3467,13 +3467,13 @@ static struct ibm_struct led_driver_data = {
  * Beep subdriver
  */
 
-IBM_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
+TPACPI_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 
 static int __init beep_init(struct ibm_init_struct *iibm)
 {
 	vdbg_printk(TPACPI_DBG_INIT, "initializing beep subdriver\n");
 
-	IBM_ACPIHANDLE_INIT(beep);
+	TPACPI_ACPIHANDLE_INIT(beep);
 
 	vdbg_printk(TPACPI_DBG_INIT, "beep is %s\n",
 		str_supported(beep_handle != NULL));
@@ -3745,12 +3745,12 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 		if (ta1 == 0) {
 			/* This is sheer paranoia, but we handle it anyway */
 			if (acpi_tmp7) {
-				printk(IBM_ERR
+				printk(TPACPI_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
 				       "falling back to ACPI TMPx access mode\n");
 				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
 			} else {
-				printk(IBM_ERR
+				printk(TPACPI_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
 				       "disabling thermal sensors access\n");
 				thermal_read_mode = TPACPI_THERMAL_NONE;
@@ -3953,7 +3953,7 @@ static int brightness_get(struct backlight_device *bd)
 	}
 
 	if (brightness_mode == 3 && lec != lcmos) {
-		printk(IBM_ERR
+		printk(TPACPI_ERR
 			"CMOS NVRAM (%u) and EC (%u) do not agree "
 			"on display brightness level\n",
 			(unsigned int) lcmos,
@@ -4035,8 +4035,8 @@ static int __init tpacpi_query_bcll_levels(acpi_handle handle)
 	if (ACPI_SUCCESS(acpi_evaluate_object(handle, NULL, NULL, &buffer))) {
 		obj = (union acpi_object *)buffer.pointer;
 		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-			printk(IBM_ERR "Unknown BCLL data, "
-			       "please report this to %s\n", IBM_MAIL);
+			printk(TPACPI_ERR "Unknown BCLL data, "
+			       "please report this to %s\n", TPACPI_MAIL);
 			rc = 0;
 		} else {
 			rc = obj->package.count;
@@ -4074,7 +4074,7 @@ static int __init brightness_check_levels(void)
 	void *found_node = NULL;
 
 	if (!vid_handle) {
-		IBM_ACPIHANDLE_INIT(vid);
+		TPACPI_ACPIHANDLE_INIT(vid);
 	}
 	if (!vid_handle)
 		return 0;
@@ -4107,7 +4107,7 @@ static int __init brightness_check_std_acpi_support(void)
 	void *found_node = NULL;
 
 	if (!vid_handle) {
-		IBM_ACPIHANDLE_INIT(vid);
+		TPACPI_ACPIHANDLE_INIT(vid);
 	}
 	if (!vid_handle)
 		return 0;
@@ -4133,7 +4133,7 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		return 1;
 	} else if (brightness_enable > 1) {
 		if (brightness_check_std_acpi_support()) {
-			printk(IBM_NOTICE
+			printk(TPACPI_NOTICE
 			       "standard ACPI backlight interface available, not loading native one...\n");
 			return 1;
 		}
@@ -4161,13 +4161,13 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		return 1;
 
 	if (tp_features.bright_16levels)
-		printk(IBM_INFO "detected a 16-level brightness capable ThinkPad\n");
+		printk(TPACPI_INFO "detected a 16-level brightness capable ThinkPad\n");
 
 	ibm_backlight_device = backlight_device_register(
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
 					&ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
-		printk(IBM_ERR "Could not register backlight device\n");
+		printk(TPACPI_ERR "Could not register backlight device\n");
 		return PTR_ERR(ibm_backlight_device);
 	}
 	vdbg_printk(TPACPI_DBG_INIT, "brightness is supported\n");
@@ -4491,11 +4491,11 @@ static struct mutex fan_mutex;
 static void fan_watchdog_fire(struct work_struct *ignored);
 static DECLARE_DELAYED_WORK(fan_watchdog_task, fan_watchdog_fire);
 
-IBM_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
-IBM_HANDLE(gfan, ec, "GFAN",	/* 570 */
+TPACPI_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
+TPACPI_HANDLE(gfan, ec, "GFAN",	/* 570 */
 	   "\\FSPD",		/* 600e/x, 770e, 770x */
 	   );			/* all others */
-IBM_HANDLE(sfan, ec, "SFAN",	/* 570 */
+TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
 	   "JFNS",		/* 770x-JL */
 	   );			/* all others */
 
@@ -4790,7 +4790,7 @@ static void fan_watchdog_reset(void)
 		if (!schedule_delayed_work(&fan_watchdog_task,
 				msecs_to_jiffies(fan_watchdog_maxinterval
 						 * 1000))) {
-			printk(IBM_ERR "failed to schedule the fan watchdog, "
+			printk(TPACPI_ERR "failed to schedule the fan watchdog, "
 			       "watchdog will not trigger\n");
 		}
 	} else
@@ -4804,10 +4804,10 @@ static void fan_watchdog_fire(struct work_struct *ignored)
 	if (tpacpi_lifecycle != TPACPI_LIFE_RUNNING)
 		return;
 
-	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
+	printk(TPACPI_NOTICE "fan watchdog: enabling fan\n");
 	rc = fan_set_enable();
 	if (rc < 0) {
-		printk(IBM_ERR "fan watchdog: error %d while enabling fan, "
+		printk(TPACPI_ERR "fan watchdog: error %d while enabling fan, "
 			"will try again later...\n", -rc);
 		/* reschedule for later */
 		fan_watchdog_reset();
@@ -5047,9 +5047,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 	tp_features.fan_ctrl_status_undef = 0;
 	fan_control_desired_level = 7;
 
-	IBM_ACPIHANDLE_INIT(fans);
-	IBM_ACPIHANDLE_INIT(gfan);
-	IBM_ACPIHANDLE_INIT(sfan);
+	TPACPI_ACPIHANDLE_INIT(fans);
+	TPACPI_ACPIHANDLE_INIT(gfan);
+	TPACPI_ACPIHANDLE_INIT(sfan);
 
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
@@ -5075,7 +5075,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 				case 0x3837: /* TP-78 */
 				case 0x3637: /* TP-76 */
 				case 0x3037: /* TP-70 */
-					printk(IBM_NOTICE
+					printk(TPACPI_NOTICE
 					       "fan_init: initial fan status is "
 					       "unknown, assuming it is in auto "
 					       "mode\n");
@@ -5084,7 +5084,7 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 				}
 			}
 		} else {
-			printk(IBM_ERR
+			printk(TPACPI_ERR
 			       "ThinkPad ACPI EC access misbehaving, "
 			       "fan status and control unavailable\n");
 			return 1;
@@ -5255,7 +5255,7 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 		return 0;
 
 	if ((*rc = fan_set_level_safe(level)) == -ENXIO)
-		printk(IBM_ERR "level command accepted for unsupported "
+		printk(TPACPI_ERR "level command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
 	return 1;
@@ -5267,7 +5267,7 @@ static int fan_write_cmd_enable(const char *cmd, int *rc)
 		return 0;
 
 	if ((*rc = fan_set_enable()) == -ENXIO)
-		printk(IBM_ERR "enable command accepted for unsupported "
+		printk(TPACPI_ERR "enable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
 	return 1;
@@ -5279,7 +5279,7 @@ static int fan_write_cmd_disable(const char *cmd, int *rc)
 		return 0;
 
 	if ((*rc = fan_set_disable()) == -ENXIO)
-		printk(IBM_ERR "disable command accepted for unsupported "
+		printk(TPACPI_ERR "disable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
 	return 1;
@@ -5296,7 +5296,7 @@ static int fan_write_cmd_speed(const char *cmd, int *rc)
 		return 0;
 
 	if ((*rc = fan_set_speed(speed)) == -ENXIO)
-		printk(IBM_ERR "speed command accepted for unsupported "
+		printk(TPACPI_ERR "speed command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
 	return 1;
@@ -5360,7 +5360,7 @@ static ssize_t thinkpad_acpi_pdev_name_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", IBM_NAME);
+	return snprintf(buf, PAGE_SIZE, "%s\n", TPACPI_NAME);
 }
 
 static struct device_attribute dev_attr_thinkpad_acpi_pdev_name =
@@ -5464,7 +5464,7 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		if (ibm->acpi->notify) {
 			ret = setup_acpi_notify(ibm);
 			if (ret == -ENODEV) {
-				printk(IBM_NOTICE "disabling subdriver %s\n",
+				printk(TPACPI_NOTICE "disabling subdriver %s\n",
 					ibm->name);
 				ret = 0;
 				goto err_out;
@@ -5482,7 +5482,7 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 					  S_IFREG | S_IRUGO | S_IWUSR,
 					  proc_dir);
 		if (!entry) {
-			printk(IBM_ERR "unable to create proc entry %s\n",
+			printk(TPACPI_ERR "unable to create proc entry %s\n",
 			       ibm->name);
 			ret = -ENODEV;
 			goto err_out;
@@ -5577,10 +5577,10 @@ static int __init probe_for_thinkpad(void)
 	is_thinkpad = (thinkpad_id.model_str != NULL);
 
 	/* ec is required because many other handles are relative to it */
-	IBM_ACPIHANDLE_INIT(ec);
+	TPACPI_ACPIHANDLE_INIT(ec);
 	if (!ec_handle) {
 		if (is_thinkpad)
-			printk(IBM_ERR
+			printk(TPACPI_ERR
 				"Not yet supported ThinkPad detected!\n");
 		return -ENODEV;
 	}
@@ -5731,28 +5731,28 @@ MODULE_PARM_DESC(hotkey_report_mode,
                  "used for backwards compatibility with userspace, "
                  "see documentation");
 
-#define IBM_PARAM(feature) \
+#define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-aci procfs command " \
 	                 "at module load, see documentation")
 
-IBM_PARAM(hotkey);
-IBM_PARAM(bluetooth);
-IBM_PARAM(video);
-IBM_PARAM(light);
+TPACPI_PARAM(hotkey);
+TPACPI_PARAM(bluetooth);
+TPACPI_PARAM(video);
+TPACPI_PARAM(light);
 #ifdef CONFIG_THINKPAD_ACPI_DOCK
-IBM_PARAM(dock);
+TPACPI_PARAM(dock);
 #endif
 #ifdef CONFIG_THINKPAD_ACPI_BAY
-IBM_PARAM(bay);
+TPACPI_PARAM(bay);
 #endif /* CONFIG_THINKPAD_ACPI_BAY */
-IBM_PARAM(cmos);
-IBM_PARAM(led);
-IBM_PARAM(beep);
-IBM_PARAM(ecdump);
-IBM_PARAM(brightness);
-IBM_PARAM(volume);
-IBM_PARAM(fan);
+TPACPI_PARAM(cmos);
+TPACPI_PARAM(led);
+TPACPI_PARAM(beep);
+TPACPI_PARAM(ecdump);
+TPACPI_PARAM(brightness);
+TPACPI_PARAM(volume);
+TPACPI_PARAM(fan);
 
 static void thinkpad_acpi_module_exit(void)
 {
@@ -5798,7 +5798,7 @@ static void thinkpad_acpi_module_exit(void)
 		platform_driver_unregister(&tpacpi_pdriver);
 
 	if (proc_dir)
-		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
+		remove_proc_entry(TPACPI_PROC_DIR, acpi_root_dir);
 
 	kfree(thinkpad_id.bios_version_str);
 	kfree(thinkpad_id.ec_version_str);
@@ -5827,12 +5827,12 @@ static int __init thinkpad_acpi_module_init(void)
 
 	/* Driver initialization */
 
-	IBM_ACPIHANDLE_INIT(ecrd);
-	IBM_ACPIHANDLE_INIT(ecwr);
+	TPACPI_ACPIHANDLE_INIT(ecrd);
+	TPACPI_ACPIHANDLE_INIT(ecwr);
 
-	proc_dir = proc_mkdir(IBM_PROC_DIR, acpi_root_dir);
+	proc_dir = proc_mkdir(TPACPI_PROC_DIR, acpi_root_dir);
 	if (!proc_dir) {
-		printk(IBM_ERR "unable to create proc dir " IBM_PROC_DIR);
+		printk(TPACPI_ERR "unable to create proc dir " TPACPI_PROC_DIR);
 		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
@@ -5840,7 +5840,7 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_pdriver);
 	if (ret) {
-		printk(IBM_ERR "unable to register main platform driver\n");
+		printk(TPACPI_ERR "unable to register main platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5848,7 +5848,7 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
 	if (ret) {
-		printk(IBM_ERR "unable to register hwmon platform driver\n");
+		printk(TPACPI_ERR "unable to register hwmon platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5860,7 +5860,7 @@ static int __init thinkpad_acpi_module_init(void)
 		ret = tpacpi_create_driver_attributes(&tpacpi_hwmon_pdriver.driver);
 	}
 	if (ret) {
-		printk(IBM_ERR "unable to create sysfs driver attributes\n");
+		printk(TPACPI_ERR "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5868,29 +5868,29 @@ static int __init thinkpad_acpi_module_init(void)
 
 
 	/* Device initialization */
-	tpacpi_pdev = platform_device_register_simple(IBM_DRVR_NAME, -1,
+	tpacpi_pdev = platform_device_register_simple(TPACPI_DRVR_NAME, -1,
 							NULL, 0);
 	if (IS_ERR(tpacpi_pdev)) {
 		ret = PTR_ERR(tpacpi_pdev);
 		tpacpi_pdev = NULL;
-		printk(IBM_ERR "unable to register platform device\n");
+		printk(TPACPI_ERR "unable to register platform device\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
 	tpacpi_sensors_pdev = platform_device_register_simple(
-							IBM_HWMON_DRVR_NAME,
+							TPACPI_HWMON_DRVR_NAME,
 							-1, NULL, 0);
 	if (IS_ERR(tpacpi_sensors_pdev)) {
 		ret = PTR_ERR(tpacpi_sensors_pdev);
 		tpacpi_sensors_pdev = NULL;
-		printk(IBM_ERR "unable to register hwmon platform device\n");
+		printk(TPACPI_ERR "unable to register hwmon platform device\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
 	ret = device_create_file(&tpacpi_sensors_pdev->dev,
 				 &dev_attr_thinkpad_acpi_pdev_name);
 	if (ret) {
-		printk(IBM_ERR
+		printk(TPACPI_ERR
 			"unable to create sysfs hwmon device attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
@@ -5900,20 +5900,20 @@ static int __init thinkpad_acpi_module_init(void)
 	if (IS_ERR(tpacpi_hwmon)) {
 		ret = PTR_ERR(tpacpi_hwmon);
 		tpacpi_hwmon = NULL;
-		printk(IBM_ERR "unable to register hwmon device\n");
+		printk(TPACPI_ERR "unable to register hwmon device\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
 	mutex_init(&tpacpi_inputdev_send_mutex);
 	tpacpi_inputdev = input_allocate_device();
 	if (!tpacpi_inputdev) {
-		printk(IBM_ERR "unable to allocate input device\n");
+		printk(TPACPI_ERR "unable to allocate input device\n");
 		thinkpad_acpi_module_exit();
 		return -ENOMEM;
 	} else {
 		/* Prepare input device, but don't register */
 		tpacpi_inputdev->name = "ThinkPad Extra Buttons";
-		tpacpi_inputdev->phys = IBM_DRVR_NAME "/input0";
+		tpacpi_inputdev->phys = TPACPI_DRVR_NAME "/input0";
 		tpacpi_inputdev->id.bustype = BUS_HOST;
 		tpacpi_inputdev->id.vendor = (thinkpad_id.vendor) ?
 						thinkpad_id.vendor :
@@ -5932,7 +5932,7 @@ static int __init thinkpad_acpi_module_init(void)
 	}
 	ret = input_register_device(tpacpi_inputdev);
 	if (ret < 0) {
-		printk(IBM_ERR "unable to register input device\n");
+		printk(TPACPI_ERR "unable to register input device\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	} else {
@@ -5970,8 +5970,8 @@ IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
 IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
 
 MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
-MODULE_DESCRIPTION(IBM_DESC);
-MODULE_VERSION(IBM_VERSION);
+MODULE_DESCRIPTION(TPACPI_DESC);
+MODULE_VERSION(TPACPI_VERSION);
 MODULE_LICENSE("GPL");
 
 module_init(thinkpad_acpi_module_init);
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
