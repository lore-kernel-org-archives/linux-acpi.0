From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 12/15] ACPI: thinkpad-acpi: some
	checkpatch.pl fluff
Date: Thu, 15 Nov 2007 01:36:59 -0200
Message-ID: <1195097822-24738-13-git-send-email-hmh@hmh.eng.br>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1195097822-24738-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Fix some of the crap reported by checkpatch.pl.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  254 +++++++++++++++++++++++++-----------------
 1 files changed, 154 insertions(+), 100 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7bd9379..b650dee 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -150,7 +150,8 @@ enum {
 #define TPACPI_DBG_EXIT		0x0002
 #define dbg_printk(a_dbg_level, format, arg...) \
 	do { if (dbg_level & a_dbg_level) \
-		printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); } while (0)
+		printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); \
+	} while (0)
 #ifdef CONFIG_THINKPAD_ACPI_DEBUG
 #define vdbg_printk(a_dbg_level, format, arg...) \
 	dbg_printk(a_dbg_level, format, ## arg)
@@ -159,9 +160,9 @@ static const char *str_supported(int is_supported);
 #define vdbg_printk(a_dbg_level, format, arg...)
 #endif
 
-#define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
-#define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
-#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
+#define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
+#define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
+#define strlencmp(a, b) (strncmp((a), (b), strlen(b)))
 
 
 /****************************************************************************
@@ -288,7 +289,8 @@ TPACPI_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
 TPACPI_HANDLE(ecrd, ec, "ECRD");	/* 570 */
 TPACPI_HANDLE(ecwr, ec, "ECWR");	/* 570 */
 
-TPACPI_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, T4x, X31, X40 */
+TPACPI_HANDLE(cmos, root, "\\UCMS",	/* R50, R50e, R50p, R51, */
+					/* T4x, X31, X40 */
 	   "\\CMOS",		/* A3x, G4x, R32, T23, T30, X22-24, X30 */
 	   "\\CMS",		/* R40, R40e */
 	   );			/* all others */
@@ -382,7 +384,7 @@ static int acpi_evalf(acpi_handle handle,
 	return success;
 }
 
-static int acpi_ec_read(int i, u8 * p)
+static int acpi_ec_read(int i, u8 *p)
 {
 	int v;
 
@@ -436,8 +438,8 @@ static int issue_thinkpad_cmos_command(int cmos_cmd)
  * ACPI device model
  */
 
-#define TPACPI_ACPIHANDLE_INIT(object)						\
-	drv_acpi_handle_init(#object, &object##_handle, *object##_parent,	\
+#define TPACPI_ACPIHANDLE_INIT(object) \
+	drv_acpi_handle_init(#object, &object##_handle, *object##_parent, \
 		object##_paths, ARRAY_SIZE(object##_paths), &object##_path)
 
 static void drv_acpi_handle_init(char *name,
@@ -508,11 +510,13 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 			ibm->acpi->type, dispatch_acpi_notify, ibm);
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_ALREADY_EXISTS) {
-			printk(TPACPI_NOTICE "another device driver is already handling %s events\n",
-				ibm->name);
+			printk(TPACPI_NOTICE
+			       "another device driver is already "
+			       "handling %s events\n", ibm->name);
 		} else {
-			printk(TPACPI_ERR "acpi_install_notify_handler(%s) failed: %d\n",
-				ibm->name, status);
+			printk(TPACPI_ERR
+			       "acpi_install_notify_handler(%s) failed: %d\n",
+			       ibm->name, status);
 		}
 		return -ENODEV;
 	}
@@ -592,7 +596,7 @@ static int dispatch_procfs_read(char *page, char **start, off_t off,
 }
 
 static int dispatch_procfs_write(struct file *file,
-			const char __user * userbuf,
+			const char __user *userbuf,
 			unsigned long count, void *data)
 {
 	struct ibm_struct *ibm = data;
@@ -698,7 +702,7 @@ struct attribute_set_obj {
 } __attribute__((packed));
 
 static struct attribute_set *create_attr_set(unsigned int max_members,
-						const char* name)
+						const char *name)
 {
 	struct attribute_set_obj *sobj;
 
@@ -722,7 +726,7 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
 	kfree(_set);
 
 /* not multi-threaded safe, use it in a single thread per set */
-static int add_to_attr_set(struct attribute_set* s, struct attribute *attr)
+static int add_to_attr_set(struct attribute_set *s, struct attribute *attr)
 {
 	if (!s || !attr)
 		return -EINVAL;
@@ -736,7 +740,7 @@ static int add_to_attr_set(struct attribute_set* s, struct attribute *attr)
 	return 0;
 }
 
-static int add_many_to_attr_set(struct attribute_set* s,
+static int add_many_to_attr_set(struct attribute_set *s,
 			struct attribute **attr,
 			unsigned int count)
 {
@@ -751,7 +755,7 @@ static int add_many_to_attr_set(struct attribute_set* s,
 	return 0;
 }
 
-static void delete_attr_set(struct attribute_set* s, struct kobject *kobj)
+static void delete_attr_set(struct attribute_set *s, struct kobject *kobj)
 {
 	sysfs_remove_group(kobj, &s->group);
 	destroy_attr_set(s);
@@ -818,7 +822,8 @@ static DRIVER_ATTR(debug_level, S_IWUSR | S_IRUGO,
 static ssize_t tpacpi_driver_version_show(struct device_driver *drv,
 						char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s v%s\n", TPACPI_DESC, TPACPI_VERSION);
+	return snprintf(buf, PAGE_SIZE, "%s v%s\n",
+			TPACPI_DESC, TPACPI_VERSION);
 }
 
 static DRIVER_ATTR(version, S_IRUGO,
@@ -826,7 +831,7 @@ static DRIVER_ATTR(version, S_IRUGO,
 
 /* --------------------------------------------------------------------- */
 
-static struct driver_attribute* tpacpi_driver_attributes[] = {
+static struct driver_attribute *tpacpi_driver_attributes[] = {
 	&driver_attr_debug_level, &driver_attr_version,
 	&driver_attr_interface_version,
 };
@@ -849,7 +854,7 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
 {
 	int i;
 
-	for(i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
+	for (i = 0; i < ARRAY_SIZE(tpacpi_driver_attributes); i++)
 		driver_remove_file(drv, tpacpi_driver_attributes[i]);
 }
 
@@ -1010,8 +1015,10 @@ static struct attribute_set *hotkey_dev_attributes;
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 #define HOTKEY_CONFIG_CRITICAL_START \
-	mutex_lock(&hotkey_thread_data_mutex); \
-	hotkey_config_change++;
+	do { \
+		mutex_lock(&hotkey_thread_data_mutex); \
+		hotkey_config_change++; \
+	} while (0);
 #define HOTKEY_CONFIG_CRITICAL_END \
 	mutex_unlock(&hotkey_thread_data_mutex);
 #else
@@ -1184,15 +1191,18 @@ static void hotkey_read_nvram(struct tp_nvram_state *n, u32 m)
 }
 
 #define TPACPI_COMPARE_KEY(__scancode, __member) \
-	do { if ((mask & (1 << __scancode)) && oldn->__member != newn->__member) \
-		tpacpi_hotkey_send_key(__scancode); } while (0)
+	do { \
+		if ((mask & (1 << __scancode)) && \
+		    oldn->__member != newn->__member) \
+		tpacpi_hotkey_send_key(__scancode); \
+	} while (0)
 
 #define TPACPI_MAY_SEND_KEY(__scancode) \
 	do { if (mask & (1 << __scancode)) \
 		tpacpi_hotkey_send_key(__scancode); } while (0)
 
 static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
-                                           struct tp_nvram_state *newn,
+					   struct tp_nvram_state *newn,
 					   u32 mask)
 {
 	if (oldn == newn)
@@ -1329,10 +1339,12 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-			                       NULL, TPACPI_FILE "d");
+			                                 NULL,
+			                                 TPACPI_FILE "d");
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
-				printk(TPACPI_ERR "could not create kernel thread "
+				printk(TPACPI_ERR
+				       "could not create kernel thread "
 				       "for hotkey polling\n");
 			}
 		}
@@ -1340,7 +1352,8 @@ static void hotkey_poll_setup(int may_warn)
 		hotkey_poll_stop_sync();
 		if (may_warn &&
 		    hotkey_source_mask != 0 && hotkey_poll_freq == 0) {
-			printk(TPACPI_NOTICE "hot keys 0x%08x require polling, "
+			printk(TPACPI_NOTICE
+			        "hot keys 0x%08x require polling, "
 				"which is currently disabled\n",
 				hotkey_source_mask);
 		}
@@ -1743,7 +1756,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				       "missing MHKA handler, "
 				       "please report this to %s\n",
 				       TPACPI_MAIL);
-				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
+				/* FN+F12, FN+F4, FN+F3 */
+				hotkey_all_mask = 0x080cU;
 			}
 		}
 
@@ -1792,7 +1806,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
 						GFP_KERNEL);
 		if (!hotkey_keycode_map) {
-			printk(TPACPI_ERR "failed to allocate memory for key map\n");
+			printk(TPACPI_ERR
+				"failed to allocate memory for key map\n");
 			return -ENOMEM;
 		}
 
@@ -1863,11 +1878,14 @@ static void hotkey_exit(void)
 #endif
 
 	if (tp_features.hotkey) {
-		dbg_printk(TPACPI_DBG_EXIT, "restoring original hot key mask\n");
+		dbg_printk(TPACPI_DBG_EXIT,
+		           "restoring original hot key mask\n");
 		/* no short-circuit boolean operator below! */
 		if ((hotkey_mask_set(hotkey_orig_mask) |
 		     hotkey_status_set(hotkey_orig_status)) != 0)
-			printk(TPACPI_ERR "failed to restore hot key mask to BIOS defaults\n");
+			printk(TPACPI_ERR
+			       "failed to restore hot key mask "
+			       "to BIOS defaults\n");
 	}
 
 	if (hotkey_dev_attributes) {
@@ -1884,11 +1902,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	int ignore_acpi_ev;
 
 	if (event != 0x80) {
-		printk(TPACPI_ERR "unknown HKEY notification event %d\n", event);
+		printk(TPACPI_ERR
+		       "unknown HKEY notification event %d\n", event);
 		/* forward it to userspace, maybe it knows how to handle it */
-		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-						ibm->acpi->device->dev.bus_id,
-						event, 0);
+		acpi_bus_generate_netlink_event(
+					ibm->acpi->device->pnp.device_class,
+					ibm->acpi->device->dev.bus_id,
+					event, 0);
 		return;
 	}
 
@@ -1919,8 +1939,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				}
 			} else {
 				printk(TPACPI_ERR
-				       "hotkey 0x%04x out of range for keyboard map\n",
-				       hkey);
+				       "hotkey 0x%04x out of range "
+				       "for keyboard map\n", hkey);
 				send_acpi_ev = 1;
 			}
 			break;
@@ -1930,8 +1950,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			 * eat up known LID events */
 			if (hkey != 0x5001 && hkey != 0x5002) {
 				printk(TPACPI_ERR
-				       "unknown LID-related HKEY event: 0x%04x\n",
-				       hkey);
+				       "unknown LID-related HKEY event: "
+				       "0x%04x\n", hkey);
 				send_acpi_ev = 1;
 			} else {
 				ignore_acpi_ev = 1;
@@ -1946,23 +1966,29 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* fallthrough to default */
 		default:
 			/* case 2: dock-related */
-			/*	0x2305 - T43 waking up due to bay lever eject while aslept */
+			/*	0x2305 - T43 waking up due to bay lever
+			 *	         eject while aslept */
 			/* case 3: ultra-bay related. maybe bay in dock? */
-			/*	0x3003 - T43 after wake up by bay lever eject (0x2305) */
-			printk(TPACPI_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
+			/*	0x3003 - T43 after wake up by bay lever
+			 *	         eject (0x2305) */
+			printk(TPACPI_NOTICE
+			       "unhandled HKEY event 0x%04x\n", hkey);
 			send_acpi_ev = 1;
 		}
 
 		/* Legacy events */
-		if (!ignore_acpi_ev && (send_acpi_ev || hotkey_report_mode < 2)) {
-			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
+		if (!ignore_acpi_ev &&
+		    (send_acpi_ev || hotkey_report_mode < 2)) {
+			acpi_bus_generate_proc_event(ibm->acpi->device,
+			                             event, hkey);
 		}
 
 		/* netlink events */
 		if (!ignore_acpi_ev && send_acpi_ev) {
-			acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-							ibm->acpi->device->dev.bus_id,
-							event, hkey);
+			acpi_bus_generate_netlink_event(
+					ibm->acpi->device->pnp.device_class,
+					ibm->acpi->device->dev.bus_id,
+					event, hkey);
 		}
 	}
 }
@@ -1970,7 +1996,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 static void hotkey_resume(void)
 {
 	if (hotkey_mask_get())
-		printk(TPACPI_ERR "error while trying to read hot key mask from firmware\n");
+		printk(TPACPI_ERR
+		       "error while trying to read hot key mask "
+		       "from firmware\n");
 	tpacpi_input_send_radiosw();
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup_safe(0);
@@ -2573,13 +2601,14 @@ static int video_outputsw_set(int status)
 		res = acpi_evalf(vid_handle, NULL,
 				 "ASWT", "vdd", status * 0x100, 0);
 		if (!autosw && video_autosw_set(autosw)) {
-			printk(TPACPI_ERR "video auto-switch left enabled due to error\n");
+			printk(TPACPI_ERR
+			       "video auto-switch left enabled due to error\n");
 			return -EIO;
 		}
 		break;
 	case TPACPI_VIDEO_NEW:
 		res = acpi_evalf(NULL, NULL, "\\VUPS", "vd", 0x80) &&
-			acpi_evalf(NULL, NULL, "\\VSDS", "vdd", status, 1);
+		      acpi_evalf(NULL, NULL, "\\VSDS", "vdd", status, 1);
 		break;
 	default:
 		return -ENOSYS;
@@ -2642,7 +2671,8 @@ static int video_outputsw_cycle(void)
 		return -ENOSYS;
 	}
 	if (!autosw && video_autosw_set(autosw)) {
-		printk(TPACPI_ERR "video auto-switch left enabled due to error\n");
+		printk(TPACPI_ERR
+		       "video auto-switch left enabled due to error\n");
 		return -EIO;
 	}
 
@@ -3250,7 +3280,8 @@ enum {	/* For TPACPI_LED_OLD */
 static enum led_access_mode led_supported;
 
 TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
-	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, */
+				/* T20-22, X20-21 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
@@ -3347,13 +3378,11 @@ static int led_write(char *buf)
 			led = 1 << led;
 			ret = ec_write(TPACPI_LED_EC_HLMS, led);
 			if (ret >= 0)
-				ret =
-				    ec_write(TPACPI_LED_EC_HLBL,
-				    	     led * led_exp_hlbl[ind]);
+				ret = ec_write(TPACPI_LED_EC_HLBL,
+				               led * led_exp_hlbl[ind]);
 			if (ret >= 0)
-				ret =
-				    ec_write(TPACPI_LED_EC_HLCL,
-				    	     led * led_exp_hlcl[ind]);
+				ret = ec_write(TPACPI_LED_EC_HLCL,
+				               led * led_exp_hlcl[ind]);
 			if (ret < 0)
 				return ret;
 		} else {
@@ -3530,7 +3559,7 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
 
-	for(i = 0 ; i < n; i++) {
+	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
 		if (res)
 			return res;
@@ -3561,7 +3590,8 @@ static ssize_t thermal_temp_input_show(struct device *dev,
 }
 
 #define THERMAL_SENSOR_ATTR_TEMP(_idxA, _idxB) \
-	 SENSOR_ATTR(temp##_idxA##_input, S_IRUGO, thermal_temp_input_show, NULL, _idxB)
+	 SENSOR_ATTR(temp##_idxA##_input, S_IRUGO, \
+	             thermal_temp_input_show, NULL, _idxB)
 
 static struct sensor_device_attribute sensor_dev_attr_thermal_temp_input[] = {
 	THERMAL_SENSOR_ATTR_TEMP(1, 0),
@@ -3657,7 +3687,8 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 			if (acpi_tmp7) {
 				printk(TPACPI_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
-				       "falling back to ACPI TMPx access mode\n");
+				       "falling back to ACPI TMPx access "
+				       "mode\n");
 				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
 			} else {
 				printk(TPACPI_ERR
@@ -3687,7 +3718,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
 		thermal_read_mode);
 
-	switch(thermal_read_mode) {
+	switch (thermal_read_mode) {
 	case TPACPI_THERMAL_TPEC_16:
 		res = sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
 				&thermal_temp_input16_group);
@@ -3712,7 +3743,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 static void thermal_exit(void)
 {
-	switch(thermal_read_mode) {
+	switch (thermal_read_mode) {
 	case TPACPI_THERMAL_TPEC_16:
 		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
 				   &thermal_temp_input16_group);
@@ -3930,8 +3961,8 @@ static int brightness_update_status(struct backlight_device *bd)
 }
 
 static struct backlight_ops ibm_backlight_data = {
-        .get_brightness = brightness_get,
-        .update_status  = brightness_update_status,
+	.get_brightness = brightness_get,
+	.update_status  = brightness_update_status,
 };
 
 /* --------------------------------------------------------------------- */
@@ -3991,7 +4022,8 @@ static int __init brightness_check_levels(void)
 
 	/* Search for a BCLL package with 16 levels */
 	status = acpi_walk_namespace(ACPI_TYPE_PACKAGE, vid_handle, 3,
-					brightness_find_bcll, NULL, &found_node);
+					brightness_find_bcll, NULL,
+					&found_node);
 
 	return (ACPI_SUCCESS(status) && found_node != NULL);
 }
@@ -4044,7 +4076,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	} else if (brightness_enable > 1) {
 		if (brightness_check_std_acpi_support()) {
 			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface available, not loading native one...\n");
+			       "standard ACPI backlight interface "
+			       "available, not loading native one...\n");
 			return 1;
 		}
 	}
@@ -4071,7 +4104,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		return 1;
 
 	if (tp_features.bright_16levels)
-		printk(TPACPI_INFO "detected a 16-level brightness capable ThinkPad\n");
+		printk(TPACPI_INFO
+		       "detected a 16-level brightness capable ThinkPad\n");
 
 	ibm_backlight_device = backlight_device_register(
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
@@ -4105,7 +4139,8 @@ static int brightness_read(char *p)
 	int len = 0;
 	int level;
 
-	if ((level = brightness_get(NULL)) < 0) {
+	level = brightness_get(NULL);
+	if (level < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
 		len += sprintf(p + len, "level:\t\t%d\n", level);
@@ -4214,7 +4249,8 @@ static int volume_write(char *buf)
 			return -EINVAL;
 
 		if (new_level != level) {	/* mute doesn't change */
-			cmos_cmd = new_level > level ? TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
+			cmos_cmd = (new_level > level) ?
+					TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
 			if (mute && (issue_thinkpad_cmos_command(cmos_cmd) ||
@@ -4226,14 +4262,16 @@ static int volume_write(char *buf)
 				    !acpi_ec_write(volume_offset, i + inc))
 					return -EIO;
 
-			if (mute && (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
-				     !acpi_ec_write(volume_offset,
-						    new_level + mute)))
+			if (mute &&
+			    (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
+			     !acpi_ec_write(volume_offset, new_level + mute))) {
 				return -EIO;
+			}
 		}
 
 		if (new_mute != mute) {	/* level doesn't change */
-			cmos_cmd = new_mute ? TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
+			cmos_cmd = (new_mute) ?
+				   TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
 			if (issue_thinkpad_cmos_command(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
@@ -4604,7 +4642,7 @@ static int fan_set_enable(void)
 		s |= 4;
 
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
-			rc= -EIO;
+			rc = -EIO;
 		else
 			rc = 0;
 		break;
@@ -4700,7 +4738,8 @@ static void fan_watchdog_reset(void)
 		if (!schedule_delayed_work(&fan_watchdog_task,
 				msecs_to_jiffies(fan_watchdog_maxinterval
 						 * 1000))) {
-			printk(TPACPI_ERR "failed to schedule the fan watchdog, "
+			printk(TPACPI_ERR
+			       "failed to schedule the fan watchdog, "
 			       "watchdog will not trigger\n");
 		}
 	} else
@@ -4986,9 +5025,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 				case 0x3637: /* TP-76 */
 				case 0x3037: /* TP-70 */
 					printk(TPACPI_NOTICE
-					       "fan_init: initial fan status is "
-					       "unknown, assuming it is in auto "
-					       "mode\n");
+					       "fan_init: initial fan status "
+					       "is unknown, assuming it is "
+					       "in auto mode\n");
 					tp_features.fan_ctrl_status_undef = 1;
 					;;
 				}
@@ -5061,11 +5100,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 static void fan_exit(void)
 {
-	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
+	vdbg_printk(TPACPI_DBG_EXIT,
+	            "cancelling any pending fan watchdog tasks\n");
 
 	/* FIXME: can we really do this unconditionally? */
 	sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj, &fan_attr_group);
-	driver_remove_file(&tpacpi_hwmon_pdriver.driver, &driver_attr_fan_watchdog);
+	driver_remove_file(&tpacpi_hwmon_pdriver.driver,
+	                   &driver_attr_fan_watchdog);
 
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_scheduled_work();
@@ -5081,7 +5122,8 @@ static int fan_read(char *p)
 	switch (fan_status_access_mode) {
 	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status_safe(&status)) < 0)
+		rc = fan_get_status_safe(&status);
+		if (rc < 0)
 			return rc;
 
 		len += sprintf(p + len, "status:\t\t%s\n"
@@ -5091,7 +5133,8 @@ static int fan_read(char *p)
 
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status_safe(&status)) < 0)
+		rc = fan_get_status_safe(&status);
+		if (rc < 0)
 			return rc;
 
 		if (unlikely(tp_features.fan_ctrl_status_undef)) {
@@ -5106,7 +5149,8 @@ static int fan_read(char *p)
 		len += sprintf(p + len, "status:\t\t%s\n",
 			       (status != 0) ? "enabled" : "disabled");
 
-		if ((rc = fan_get_speed(&speed)) < 0)
+		rc = fan_get_speed(&speed);
+		if (rc < 0)
 			return rc;
 
 		len += sprintf(p + len, "speed:\t\t%d\n", speed);
@@ -5142,8 +5186,8 @@ static int fan_read(char *p)
 
 	if (fan_control_commands & TPACPI_FAN_CMD_ENABLE)
 		len += sprintf(p + len, "commands:\tenable, disable\n"
-			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
-			       "1-120 (seconds))\n");
+			       "commands:\twatchdog <timeout> (<timeout> "
+			       "is 0 (off), 1-120 (seconds))\n");
 
 	if (fan_control_commands & TPACPI_FAN_CMD_SPEED)
 		len += sprintf(p + len, "commands:\tspeed <speed>"
@@ -5164,7 +5208,8 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 	else if (sscanf(cmd, "level %d", &level) != 1)
 		return 0;
 
-	if ((*rc = fan_set_level_safe(level)) == -ENXIO)
+	*rc = fan_set_level_safe(level);
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "level command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5176,7 +5221,8 @@ static int fan_write_cmd_enable(const char *cmd, int *rc)
 	if (strlencmp(cmd, "enable") != 0)
 		return 0;
 
-	if ((*rc = fan_set_enable()) == -ENXIO)
+	*rc = fan_set_enable();
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "enable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5188,7 +5234,8 @@ static int fan_write_cmd_disable(const char *cmd, int *rc)
 	if (strlencmp(cmd, "disable") != 0)
 		return 0;
 
-	if ((*rc = fan_set_disable()) == -ENXIO)
+	*rc = fan_set_disable();
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "disable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5205,7 +5252,8 @@ static int fan_write_cmd_speed(const char *cmd, int *rc)
 	if (sscanf(cmd, "speed %d", &speed) != 1)
 		return 0;
 
-	if ((*rc = fan_set_speed(speed)) == -ENXIO)
+	*rc = fan_set_speed(speed);
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "speed command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5736,7 +5784,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	proc_dir = proc_mkdir(TPACPI_PROC_DIR, acpi_root_dir);
 	if (!proc_dir) {
-		printk(TPACPI_ERR "unable to create proc dir " TPACPI_PROC_DIR);
+		printk(TPACPI_ERR
+		       "unable to create proc dir " TPACPI_PROC_DIR);
 		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
@@ -5744,7 +5793,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_pdriver);
 	if (ret) {
-		printk(TPACPI_ERR "unable to register main platform driver\n");
+		printk(TPACPI_ERR
+		       "unable to register main platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5752,7 +5802,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
 	if (ret) {
-		printk(TPACPI_ERR "unable to register hwmon platform driver\n");
+		printk(TPACPI_ERR
+		       "unable to register hwmon platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5761,10 +5812,12 @@ static int __init thinkpad_acpi_module_init(void)
 	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
 	if (!ret) {
 		tp_features.platform_drv_attrs_registered = 1;
-		ret = tpacpi_create_driver_attributes(&tpacpi_hwmon_pdriver.driver);
+		ret = tpacpi_create_driver_attributes(
+					&tpacpi_hwmon_pdriver.driver);
 	}
 	if (ret) {
-		printk(TPACPI_ERR "unable to create sysfs driver attributes\n");
+		printk(TPACPI_ERR
+		       "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5782,12 +5835,13 @@ static int __init thinkpad_acpi_module_init(void)
 		return ret;
 	}
 	tpacpi_sensors_pdev = platform_device_register_simple(
-							TPACPI_HWMON_DRVR_NAME,
-							-1, NULL, 0);
+						TPACPI_HWMON_DRVR_NAME,
+						-1, NULL, 0);
 	if (IS_ERR(tpacpi_sensors_pdev)) {
 		ret = PTR_ERR(tpacpi_sensors_pdev);
 		tpacpi_sensors_pdev = NULL;
-		printk(TPACPI_ERR "unable to register hwmon platform device\n");
+		printk(TPACPI_ERR
+		       "unable to register hwmon platform device\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5795,7 +5849,7 @@ static int __init thinkpad_acpi_module_init(void)
 				 &dev_attr_thinkpad_acpi_pdev_name);
 	if (ret) {
 		printk(TPACPI_ERR
-			"unable to create sysfs hwmon device attributes\n");
+		       "unable to create sysfs hwmon device attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
-- 
1.5.3.4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
