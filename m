From: Len Brown <lenb@kernel.org>
Subject: [PATCH 043/112] ACPI: thinkpad-acpi: some checkpatch.pl fluff
Date: Thu,  7 Feb 2008 04:34:05 -0500
Message-ID: <35ff8b9fa90d97f3a19ea3e2311385927535ebc9.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754204AbYBGJgL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:11 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix some of the crap reported by checkpatch.pl.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |  291 +++++++++++++++++++++++++-----------------
 1 files changed, 175 insertions(+), 116 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c92ae8d..dd6fa81 100644
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
@@ -1205,15 +1212,18 @@ static void hotkey_read_nvram(struct tp_nvram_state *n, u32 m)
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
 	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_THINKPAD, thinkpad_toggle);
@@ -1316,7 +1326,7 @@ static int hotkey_kthread(void *data)
 			hotkey_read_nvram(&s[si], mask);
 			if (likely(si != so)) {
 				hotkey_compare_and_issue_event(&s[so], &s[si],
-				                               mask);
+								mask);
 			}
 		}
 
@@ -1352,10 +1362,12 @@ static void hotkey_poll_setup(int may_warn)
 	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
-			                       NULL, TPACPI_FILE "d");
+							 NULL,
+							 TPACPI_FILE "d");
 			if (IS_ERR(tpacpi_hotkey_task)) {
 				tpacpi_hotkey_task = NULL;
-				printk(TPACPI_ERR "could not create kernel thread "
+				printk(TPACPI_ERR
+				       "could not create kernel thread "
 				       "for hotkey polling\n");
 			}
 		}
@@ -1363,7 +1375,8 @@ static void hotkey_poll_setup(int may_warn)
 		hotkey_poll_stop_sync();
 		if (may_warn &&
 		    hotkey_source_mask != 0 && hotkey_poll_freq == 0) {
-			printk(TPACPI_NOTICE "hot keys 0x%08x require polling, "
+			printk(TPACPI_NOTICE
+				"hot keys 0x%08x require polling, "
 				"which is currently disabled\n",
 				hotkey_source_mask);
 		}
@@ -1829,7 +1842,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				       "missing MHKA handler, "
 				       "please report this to %s\n",
 				       TPACPI_MAIL);
-				hotkey_all_mask = 0x080cU; /* FN+F12, FN+F4, FN+F3 */
+				/* FN+F12, FN+F4, FN+F3 */
+				hotkey_all_mask = 0x080cU;
 			}
 		}
 
@@ -1882,7 +1896,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_keycode_map = kmalloc(TPACPI_HOTKEY_MAP_SIZE,
 						GFP_KERNEL);
 		if (!hotkey_keycode_map) {
-			printk(TPACPI_ERR "failed to allocate memory for key map\n");
+			printk(TPACPI_ERR
+				"failed to allocate memory for key map\n");
 			return -ENOMEM;
 		}
 
@@ -1953,11 +1968,14 @@ static void hotkey_exit(void)
 #endif
 
 	if (tp_features.hotkey) {
-		dbg_printk(TPACPI_DBG_EXIT, "restoring original hot key mask\n");
+		dbg_printk(TPACPI_DBG_EXIT,
+			   "restoring original hot key mask\n");
 		/* no short-circuit boolean operator below! */
 		if ((hotkey_mask_set(hotkey_orig_mask) |
 		     hotkey_status_set(hotkey_orig_status)) != 0)
-			printk(TPACPI_ERR "failed to restore hot key mask to BIOS defaults\n");
+			printk(TPACPI_ERR
+			       "failed to restore hot key mask "
+			       "to BIOS defaults\n");
 	}
 
 	if (hotkey_dev_attributes) {
@@ -1974,11 +1992,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
 
@@ -2009,8 +2029,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
@@ -2020,8 +2040,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
@@ -2036,23 +2056,29 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
+						     event, hkey);
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
@@ -2060,7 +2086,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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
@@ -2663,13 +2691,14 @@ static int video_outputsw_set(int status)
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
@@ -2732,7 +2761,8 @@ static int video_outputsw_cycle(void)
 		return -ENOSYS;
 	}
 	if (!autosw && video_autosw_set(autosw)) {
-		printk(TPACPI_ERR "video auto-switch left enabled due to error\n");
+		printk(TPACPI_ERR
+		       "video auto-switch left enabled due to error\n");
 		return -EIO;
 	}
 
@@ -3340,7 +3370,8 @@ enum {	/* For TPACPI_LED_OLD */
 static enum led_access_mode led_supported;
 
 TPACPI_HANDLE(led, ec, "SLED",	/* 570 */
-	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20-21 */
+	   "SYSL",		/* 600e/x, 770e, 770x, A21e, A2xm/p, */
+				/* T20-22, X20-21 */
 	   "LED",		/* all others */
 	   );			/* R30, R31 */
 
@@ -3437,13 +3468,11 @@ static int led_write(char *buf)
 			led = 1 << led;
 			ret = ec_write(TPACPI_LED_EC_HLMS, led);
 			if (ret >= 0)
-				ret =
-				    ec_write(TPACPI_LED_EC_HLBL,
-				    	     led * led_exp_hlbl[ind]);
+				ret = ec_write(TPACPI_LED_EC_HLBL,
+						led * led_exp_hlbl[ind]);
 			if (ret >= 0)
-				ret =
-				    ec_write(TPACPI_LED_EC_HLCL,
-				    	     led * led_exp_hlcl[ind]);
+				ret = ec_write(TPACPI_LED_EC_HLCL,
+						led * led_exp_hlcl[ind]);
 			if (ret < 0)
 				return ret;
 		} else {
@@ -3620,7 +3649,7 @@ static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
 	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
 		n = 16;
 
-	for(i = 0 ; i < n; i++) {
+	for (i = 0 ; i < n; i++) {
 		res = thermal_get_sensor(i, &s->temp[i]);
 		if (res)
 			return res;
@@ -3651,7 +3680,8 @@ static ssize_t thermal_temp_input_show(struct device *dev,
 }
 
 #define THERMAL_SENSOR_ATTR_TEMP(_idxA, _idxB) \
-	 SENSOR_ATTR(temp##_idxA##_input, S_IRUGO, thermal_temp_input_show, NULL, _idxB)
+	 SENSOR_ATTR(temp##_idxA##_input, S_IRUGO, \
+		     thermal_temp_input_show, NULL, _idxB)
 
 static struct sensor_device_attribute sensor_dev_attr_thermal_temp_input[] = {
 	THERMAL_SENSOR_ATTR_TEMP(1, 0),
@@ -3747,7 +3777,8 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 			if (acpi_tmp7) {
 				printk(TPACPI_ERR
 				       "ThinkPad ACPI EC access misbehaving, "
-				       "falling back to ACPI TMPx access mode\n");
+				       "falling back to ACPI TMPx access "
+				       "mode\n");
 				thermal_read_mode = TPACPI_THERMAL_ACPI_TMP07;
 			} else {
 				printk(TPACPI_ERR
@@ -3777,7 +3808,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 		str_supported(thermal_read_mode != TPACPI_THERMAL_NONE),
 		thermal_read_mode);
 
-	switch(thermal_read_mode) {
+	switch (thermal_read_mode) {
 	case TPACPI_THERMAL_TPEC_16:
 		res = sysfs_create_group(&tpacpi_sensors_pdev->dev.kobj,
 				&thermal_temp_input16_group);
@@ -3802,7 +3833,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 static void thermal_exit(void)
 {
-	switch(thermal_read_mode) {
+	switch (thermal_read_mode) {
 	case TPACPI_THERMAL_TPEC_16:
 		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
 				   &thermal_temp_input16_group);
@@ -4020,8 +4051,8 @@ static int brightness_update_status(struct backlight_device *bd)
 }
 
 static struct backlight_ops ibm_backlight_data = {
-        .get_brightness = brightness_get,
-        .update_status  = brightness_update_status,
+	.get_brightness = brightness_get,
+	.update_status  = brightness_update_status,
 };
 
 /* --------------------------------------------------------------------- */
@@ -4081,7 +4112,8 @@ static int __init brightness_check_levels(void)
 
 	/* Search for a BCLL package with 16 levels */
 	status = acpi_walk_namespace(ACPI_TYPE_PACKAGE, vid_handle, 3,
-					brightness_find_bcll, NULL, &found_node);
+					brightness_find_bcll, NULL,
+					&found_node);
 
 	return (ACPI_SUCCESS(status) && found_node != NULL);
 }
@@ -4114,7 +4146,7 @@ static int __init brightness_check_std_acpi_support(void)
 
 	/* Search for a _BCL method, but don't execute it */
 	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
-	                             brightness_find_bcl, NULL, &found_node);
+				     brightness_find_bcl, NULL, &found_node);
 
 	return (ACPI_SUCCESS(status) && found_node != NULL);
 }
@@ -4129,12 +4161,14 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 
 	if (!brightness_enable) {
 		dbg_printk(TPACPI_DBG_INIT,
-		           "brightness support disabled by module parameter\n");
+			   "brightness support disabled by "
+			   "module parameter\n");
 		return 1;
 	} else if (brightness_enable > 1) {
 		if (brightness_check_std_acpi_support()) {
 			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface available, not loading native one...\n");
+			       "standard ACPI backlight interface "
+			       "available, not loading native one...\n");
 			return 1;
 		}
 	}
@@ -4161,7 +4195,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		return 1;
 
 	if (tp_features.bright_16levels)
-		printk(TPACPI_INFO "detected a 16-level brightness capable ThinkPad\n");
+		printk(TPACPI_INFO
+		       "detected a 16-level brightness capable ThinkPad\n");
 
 	ibm_backlight_device = backlight_device_register(
 					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
@@ -4195,7 +4230,8 @@ static int brightness_read(char *p)
 	int len = 0;
 	int level;
 
-	if ((level = brightness_get(NULL)) < 0) {
+	level = brightness_get(NULL);
+	if (level < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
 		len += sprintf(p + len, "level:\t\t%d\n", level);
@@ -4303,8 +4339,11 @@ static int volume_write(char *buf)
 		} else
 			return -EINVAL;
 
-		if (new_level != level) {	/* mute doesn't change */
-			cmos_cmd = new_level > level ? TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
+		if (new_level != level) {
+			/* mute doesn't change */
+
+			cmos_cmd = (new_level > level) ?
+					TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
 			inc = new_level > level ? 1 : -1;
 
 			if (mute && (issue_thinkpad_cmos_command(cmos_cmd) ||
@@ -4316,14 +4355,18 @@ static int volume_write(char *buf)
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
 
-		if (new_mute != mute) {	/* level doesn't change */
-			cmos_cmd = new_mute ? TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
+		if (new_mute != mute) {
+			/* level doesn't change */
+
+			cmos_cmd = (new_mute) ?
+				   TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
 
 			if (issue_thinkpad_cmos_command(cmos_cmd) ||
 			    !acpi_ec_write(volume_offset, level + new_mute))
@@ -4694,7 +4737,7 @@ static int fan_set_enable(void)
 		s |= 4;
 
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
-			rc= -EIO;
+			rc = -EIO;
 		else
 			rc = 0;
 		break;
@@ -4790,7 +4833,8 @@ static void fan_watchdog_reset(void)
 		if (!schedule_delayed_work(&fan_watchdog_task,
 				msecs_to_jiffies(fan_watchdog_maxinterval
 						 * 1000))) {
-			printk(TPACPI_ERR "failed to schedule the fan watchdog, "
+			printk(TPACPI_ERR
+			       "failed to schedule the fan watchdog, "
 			       "watchdog will not trigger\n");
 		}
 	} else
@@ -5076,9 +5120,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
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
@@ -5151,11 +5195,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 static void fan_exit(void)
 {
-	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
+	vdbg_printk(TPACPI_DBG_EXIT,
+		    "cancelling any pending fan watchdog tasks\n");
 
 	/* FIXME: can we really do this unconditionally? */
 	sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj, &fan_attr_group);
-	driver_remove_file(&tpacpi_hwmon_pdriver.driver, &driver_attr_fan_watchdog);
+	driver_remove_file(&tpacpi_hwmon_pdriver.driver,
+			   &driver_attr_fan_watchdog);
 
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_scheduled_work();
@@ -5171,7 +5217,8 @@ static int fan_read(char *p)
 	switch (fan_status_access_mode) {
 	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status_safe(&status)) < 0)
+		rc = fan_get_status_safe(&status);
+		if (rc < 0)
 			return rc;
 
 		len += sprintf(p + len, "status:\t\t%s\n"
@@ -5181,7 +5228,8 @@ static int fan_read(char *p)
 
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
-		if ((rc = fan_get_status_safe(&status)) < 0)
+		rc = fan_get_status_safe(&status);
+		if (rc < 0)
 			return rc;
 
 		if (unlikely(tp_features.fan_ctrl_status_undef)) {
@@ -5196,7 +5244,8 @@ static int fan_read(char *p)
 		len += sprintf(p + len, "status:\t\t%s\n",
 			       (status != 0) ? "enabled" : "disabled");
 
-		if ((rc = fan_get_speed(&speed)) < 0)
+		rc = fan_get_speed(&speed);
+		if (rc < 0)
 			return rc;
 
 		len += sprintf(p + len, "speed:\t\t%d\n", speed);
@@ -5232,8 +5281,8 @@ static int fan_read(char *p)
 
 	if (fan_control_commands & TPACPI_FAN_CMD_ENABLE)
 		len += sprintf(p + len, "commands:\tenable, disable\n"
-			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
-			       "1-120 (seconds))\n");
+			       "commands:\twatchdog <timeout> (<timeout> "
+			       "is 0 (off), 1-120 (seconds))\n");
 
 	if (fan_control_commands & TPACPI_FAN_CMD_SPEED)
 		len += sprintf(p + len, "commands:\tspeed <speed>"
@@ -5249,12 +5298,13 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 	if (strlencmp(cmd, "level auto") == 0)
 		level = TP_EC_FAN_AUTO;
 	else if ((strlencmp(cmd, "level disengaged") == 0) |
-	         (strlencmp(cmd, "level full-speed") == 0))
+			(strlencmp(cmd, "level full-speed") == 0))
 		level = TP_EC_FAN_FULLSPEED;
 	else if (sscanf(cmd, "level %d", &level) != 1)
 		return 0;
 
-	if ((*rc = fan_set_level_safe(level)) == -ENXIO)
+	*rc = fan_set_level_safe(level);
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "level command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5266,7 +5316,8 @@ static int fan_write_cmd_enable(const char *cmd, int *rc)
 	if (strlencmp(cmd, "enable") != 0)
 		return 0;
 
-	if ((*rc = fan_set_enable()) == -ENXIO)
+	*rc = fan_set_enable();
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "enable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5278,7 +5329,8 @@ static int fan_write_cmd_disable(const char *cmd, int *rc)
 	if (strlencmp(cmd, "disable") != 0)
 		return 0;
 
-	if ((*rc = fan_set_disable()) == -ENXIO)
+	*rc = fan_set_disable();
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "disable command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5295,7 +5347,8 @@ static int fan_write_cmd_speed(const char *cmd, int *rc)
 	if (sscanf(cmd, "speed %d", &speed) != 1)
 		return 0;
 
-	if ((*rc = fan_set_speed(speed)) == -ENXIO)
+	*rc = fan_set_speed(speed);
+	if (*rc == -ENXIO)
 		printk(TPACPI_ERR "speed command accepted for unsupported "
 		       "access mode %d", fan_control_access_mode);
 
@@ -5703,38 +5756,38 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 
 module_param(experimental, int, 0);
 MODULE_PARM_DESC(experimental,
-                 "Enables experimental features when non-zero");
+		 "Enables experimental features when non-zero");
 
 module_param_named(debug, dbg_level, uint, 0);
 MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
 
 module_param(force_load, bool, 0);
 MODULE_PARM_DESC(force_load,
-                 "Attempts to load the driver even on a "
-                 "mis-identified ThinkPad when true");
+		 "Attempts to load the driver even on a "
+		 "mis-identified ThinkPad when true");
 
 module_param_named(fan_control, fan_control_allowed, bool, 0);
 MODULE_PARM_DESC(fan_control,
-                 "Enables setting fan parameters features when true");
+		 "Enables setting fan parameters features when true");
 
 module_param_named(brightness_mode, brightness_mode, int, 0);
 MODULE_PARM_DESC(brightness_mode,
-                 "Selects brightness control strategy: "
-                 "0=auto, 1=EC, 2=CMOS, 3=both");
+		 "Selects brightness control strategy: "
+		 "0=auto, 1=EC, 2=CMOS, 3=both");
 
 module_param(brightness_enable, uint, 0);
 MODULE_PARM_DESC(brightness_enable,
-                 "Enables backlight control when 1, disables when 0");
+		 "Enables backlight control when 1, disables when 0");
 
 module_param(hotkey_report_mode, uint, 0);
 MODULE_PARM_DESC(hotkey_report_mode,
-                 "used for backwards compatibility with userspace, "
-                 "see documentation");
+		 "used for backwards compatibility with userspace, "
+		 "see documentation");
 
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-aci procfs command " \
-	                 "at module load, see documentation")
+			 "at module load, see documentation")
 
 TPACPI_PARAM(hotkey);
 TPACPI_PARAM(bluetooth);
@@ -5832,7 +5885,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	proc_dir = proc_mkdir(TPACPI_PROC_DIR, acpi_root_dir);
 	if (!proc_dir) {
-		printk(TPACPI_ERR "unable to create proc dir " TPACPI_PROC_DIR);
+		printk(TPACPI_ERR
+		       "unable to create proc dir " TPACPI_PROC_DIR);
 		thinkpad_acpi_module_exit();
 		return -ENODEV;
 	}
@@ -5840,7 +5894,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_pdriver);
 	if (ret) {
-		printk(TPACPI_ERR "unable to register main platform driver\n");
+		printk(TPACPI_ERR
+		       "unable to register main platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5848,7 +5903,8 @@ static int __init thinkpad_acpi_module_init(void)
 
 	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
 	if (ret) {
-		printk(TPACPI_ERR "unable to register hwmon platform driver\n");
+		printk(TPACPI_ERR
+		       "unable to register hwmon platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
@@ -5857,10 +5913,12 @@ static int __init thinkpad_acpi_module_init(void)
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
@@ -5878,12 +5936,13 @@ static int __init thinkpad_acpi_module_init(void)
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
@@ -5891,7 +5950,7 @@ static int __init thinkpad_acpi_module_init(void)
 				 &dev_attr_thinkpad_acpi_pdev_name);
 	if (ret) {
 		printk(TPACPI_ERR
-			"unable to create sysfs hwmon device attributes\n");
+		       "unable to create sysfs hwmon device attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
-- 
1.5.4.23.gef5b9

