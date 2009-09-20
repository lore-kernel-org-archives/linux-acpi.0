From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/6] thinkpad-acpi: hotkey event driver update
Date: Sun, 20 Sep 2009 14:09:25 -0300
Message-ID: <1253466567-4285-5-git-send-email-hmh@hmh.eng.br>
References: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33860 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754723AbZITRJ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Sep 2009 13:09:59 -0400
In-Reply-To: <1253466567-4285-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update the HKEY event driver to:

1. Handle better the second-gen firmware, which has no HKEY mask
   support but does report FN+F3, FN+F4 and FN+F12 without the need
   for NVRAM polling.

   a) always make the mask-related attributes available in sysfs;
   b) use DMI quirks to detect the second-gen firmware;
   c) properly report that FN+F3, FN+F4 and FN+F12 are enabled,
      and available even on mask-less second-gen firmware;

2. Decouple the issuing of hotkey events towards userspace from
   their reception from the firmware.  ALSA mixer and brightness
   event reporting support will need this feature.

3. Clean up the mess in the hotkey driver a great deal.  It is
   still very convoluted, and wants a full refactoring into a
   proper event API interface, but that is not going to happen
   today.

4. Fully reset firmware interface on resume (restore hotkey
   mask and status).

5. Stop losing polled events for no good reason when changing the
   mask and poll frequencies.  We will still lose them when the
   hotkey_source_mask is changed, as well as any that happened
   between driver suspend and driver resume.

The hotkey subdriver now has the notion of user-space-visible hotkey
event mask, as well as of the set of "hotkey" events the driver needs
(because brightness/volume change reports are not just keypress
reports in most ThinkPad models).

With this rewrite, the ABI level is bumped to 0x020500 should
userspace need to know it is dealing with the updated hotkey
subdriver.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   46 ++--
 drivers/platform/x86/thinkpad_acpi.c    |  478 +++++++++++++++++++------------
 2 files changed, 328 insertions(+), 196 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index f635fb0..aafcaa6 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -199,18 +199,22 @@ kind to allow it (and it often doesn't!).
 
 Not all bits in the mask can be modified.  Not all bits that can be
 modified do anything.  Not all hot keys can be individually controlled
-by the mask.  Some models do not support the mask at all, and in those
-models, hot keys cannot be controlled individually.  The behaviour of
-the mask is, therefore, highly dependent on the ThinkPad model.
+by the mask.  Some models do not support the mask at all.  The behaviour
+of the mask is, therefore, highly dependent on the ThinkPad model.
+
+The driver will filter out any unmasked hotkeys, so even if the firmware
+doesn't allow disabling an specific hotkey, the driver will not report
+events for unmasked hotkeys.
 
 Note that unmasking some keys prevents their default behavior.  For
 example, if Fn+F5 is unmasked, that key will no longer enable/disable
-Bluetooth by itself.
+Bluetooth by itself in firmware.
 
-Note also that not all Fn key combinations are supported through ACPI.
-For example, on the X40, the brightness, volume and "Access IBM" buttons
-do not generate ACPI events even with this driver.  They *can* be used
-through the "ThinkPad Buttons" utility, see http://www.nongnu.org/tpb/
+Note also that not all Fn key combinations are supported through ACPI
+depending on the ThinkPad model and firmware version.  On those
+ThinkPads, it is still possible to support some extra hotkeys by
+polling the "CMOS NVRAM" at least 10 times per second.  The driver
+attempts to enables this functionality automatically when required.
 
 procfs notes:
 
@@ -255,18 +259,11 @@ sysfs notes:
 		1: does nothing
 
 	hotkey_mask:
-		bit mask to enable driver-handling (and depending on
+		bit mask to enable reporting (and depending on
 		the firmware, ACPI event generation) for each hot key
 		(see above).  Returns the current status of the hot keys
 		mask, and allows one to modify it.
 
-		Note: when NVRAM polling is active, the firmware mask
-		will be different from the value returned by
-		hotkey_mask.  The driver will retain enabled bits for
-		hotkeys that are under NVRAM polling even if the
-		firmware refuses them, and will not set these bits on
-		the firmware hot key mask.
-
 	hotkey_all_mask:
 		bit mask that should enable event reporting for all
 		supported hot keys, when echoed to hotkey_mask above.
@@ -279,7 +276,8 @@ sysfs notes:
 		bit mask that should enable event reporting for all
 		supported hot keys, except those which are always
 		handled by the firmware anyway.  Echo it to
-		hotkey_mask above, to use.
+		hotkey_mask above, to use.  This is the default mask
+		used by the driver.
 
 	hotkey_source_mask:
 		bit mask that selects which hot keys will the driver
@@ -287,9 +285,10 @@ sysfs notes:
 		based on the capabilities reported by the ACPI firmware,
 		but it can be overridden at runtime.
 
-		Hot keys whose bits are set in both hotkey_source_mask
-		and also on hotkey_mask are polled for in NVRAM.  Only a
-		few hot keys are available through CMOS NVRAM polling.
+		Hot keys whose bits are set in hotkey_source_mask are
+		polled for in NVRAM, and reported as hotkey events if
+		enabled in hotkey_mask.  Only a few hot keys are
+		available through CMOS NVRAM polling.
 
 		Warning: when in NVRAM mode, the volume up/down/mute
 		keys are synthesized according to changes in the mixer,
@@ -621,6 +620,8 @@ For Lenovo models *with* ACPI backlight control:
 2. Do *NOT* load up ACPI video, enable the hotkeys in thinkpad-acpi,
    and map them to KEY_BRIGHTNESS_UP and KEY_BRIGHTNESS_DOWN.  Process
    these keys on userspace somehow (e.g. by calling xbacklight).
+   The driver will do this automatically if it detects that ACPI video
+   has been disabled.
 
 
 Bluetooth
@@ -1459,3 +1460,8 @@ Sysfs interface changelog:
 0x020400:	Marker for 16 LEDs support.  Also, LEDs that are known
 		to not exist in a given model are not registered with
 		the LED sysfs class anymore.
+
+0x020500:	Updated hotkey driver, hotkey_mask is always available
+		and it is always able to disable hot keys.  Very old
+		thinkpads are properly supported.  hotkey_bios_mask
+		is deprecated and marked for removal.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 66ba5f5..50aa4c1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define TPACPI_VERSION "0.23"
-#define TPACPI_SYSFS_VERSION 0x020400
+#define TPACPI_SYSFS_VERSION 0x020500
 
 /*
  *  Changelog:
@@ -1848,6 +1848,27 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
  * Hotkey subdriver
  */
 
+/*
+ * ThinkPad firmware event model
+ *
+ * The ThinkPad firmware has two main event interfaces: normal ACPI
+ * notifications (which follow the ACPI standard), and a private event
+ * interface.
+ *
+ * The private event interface also issues events for the hotkeys.  As
+ * the driver gained features, the event handling code ended up being
+ * built around the hotkey subdriver.  This will need to be refactored
+ * to a more formal event API eventually.
+ *
+ * Some "hotkeys" are actually supposed to be used as event reports,
+ * such as "brightness has changed", "volume has changed", depending on
+ * the ThinkPad model and how the firmware is operating.
+ *
+ * Unlike other classes, hotkey-class events have mask/unmask control on
+ * non-ancient firmware.  However, how it behaves changes a lot with the
+ * firmware model and version.
+ */
+
 enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_FNF1		= 0,
 	TP_ACPI_HOTKEYSCAN_FNF2,
@@ -1875,7 +1896,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 	TP_ACPI_HOTKEYSCAN_THINKPAD,
 };
 
-enum {	/* Keys available through NVRAM polling */
+enum {	/* Keys/events available through NVRAM polling */
 	TPACPI_HKEY_NVRAM_KNOWN_MASK = 0x00fb88c0U,
 	TPACPI_HKEY_NVRAM_GOOD_MASK  = 0x00fb8000U,
 };
@@ -1930,8 +1951,11 @@ static struct task_struct *tpacpi_hotkey_task;
 static struct mutex hotkey_thread_mutex;
 
 /*
- * Acquire mutex to write poller control variables.
- * Increment hotkey_config_change when changing them.
+ * Acquire mutex to write poller control variables as an
+ * atomic block.
+ *
+ * Increment hotkey_config_change when changing them if you
+ * want the kthread to forget old state.
  *
  * See HOTKEY_CONFIG_CRITICAL_START/HOTKEY_CONFIG_CRITICAL_END
  */
@@ -1942,6 +1966,11 @@ static unsigned int hotkey_config_change;
  * hotkey poller control variables
  *
  * Must be atomic or readers will also need to acquire mutex
+ *
+ * HOTKEY_CONFIG_CRITICAL_START/HOTKEY_CONFIG_CRITICAL_END
+ * should be used only when the changes need to be taken as
+ * a block, OR when one needs to force the kthread to forget
+ * old state.
  */
 static u32 hotkey_source_mask;		/* bit mask 0=ACPI,1=NVRAM */
 static unsigned int hotkey_poll_freq = 10; /* Hz */
@@ -1972,10 +2001,12 @@ static enum {	/* Reasons for waking up */
 
 static int hotkey_autosleep_ack;
 
-static u32 hotkey_orig_mask;
-static u32 hotkey_all_mask;
-static u32 hotkey_reserved_mask;
-static u32 hotkey_mask;
+static u32 hotkey_orig_mask;		/* events the BIOS had enabled */
+static u32 hotkey_all_mask;		/* all events supported in fw */
+static u32 hotkey_reserved_mask;	/* events better left disabled */
+static u32 hotkey_driver_mask;		/* events needed by the driver */
+static u32 hotkey_user_mask;		/* events visible to userspace */
+static u32 hotkey_acpi_mask;		/* events enabled in firmware */
 
 static unsigned int hotkey_report_mode;
 
@@ -2017,24 +2048,53 @@ static int hotkey_get_tablet_mode(int *status)
 }
 
 /*
+ * Reads current event mask from firmware, and updates
+ * hotkey_acpi_mask accordingly.  Also resets any bits
+ * from hotkey_user_mask that are unavailable to be
+ * delivered (shadow requirement of the userspace ABI).
+ *
  * Call with hotkey_mutex held
  */
 static int hotkey_mask_get(void)
 {
-	u32 m = 0;
-
 	if (tp_features.hotkey_mask) {
+		u32 m = 0;
+
 		if (!acpi_evalf(hkey_handle, &m, "DHKN", "d"))
 			return -EIO;
+
+		hotkey_acpi_mask = m;
+	} else {
+		/* no mask support doesn't mean no event support... */
+		hotkey_acpi_mask = hotkey_all_mask;
 	}
-	HOTKEY_CONFIG_CRITICAL_START
-	hotkey_mask = m | (hotkey_source_mask & hotkey_mask);
-	HOTKEY_CONFIG_CRITICAL_END
+
+	/* sync userspace-visible mask */
+	hotkey_user_mask &= (hotkey_acpi_mask | hotkey_source_mask);
 
 	return 0;
 }
 
+void static hotkey_mask_warn_incomplete_mask(void)
+{
+	/* log only what the user can fix... */
+	const u32 wantedmask = hotkey_driver_mask &
+		~(hotkey_acpi_mask | hotkey_source_mask) &
+		(hotkey_all_mask | TPACPI_HKEY_NVRAM_KNOWN_MASK);
+
+	if (wantedmask)
+		printk(TPACPI_NOTICE
+			"required events 0x%08x not enabled!\n",
+			wantedmask);
+}
+
 /*
+ * Set the firmware mask when supported
+ *
+ * Also calls hotkey_mask_get to update hotkey_acpi_mask.
+ *
+ * NOTE: does not set bits in hotkey_user_mask, but may reset them.
+ *
  * Call with hotkey_mutex held
  */
 static int hotkey_mask_set(u32 mask)
@@ -2042,66 +2102,69 @@ static int hotkey_mask_set(u32 mask)
 	int i;
 	int rc = 0;
 
-	if (tp_features.hotkey_mask) {
-		if (!tp_warned.hotkey_mask_ff &&
-		    (mask == 0xffff || mask == 0xffffff ||
-		     mask == 0xffffffff)) {
-			tp_warned.hotkey_mask_ff = 1;
-			printk(TPACPI_NOTICE
-			       "setting the hotkey mask to 0x%08x is likely "
-			       "not the best way to go about it\n", mask);
-			printk(TPACPI_NOTICE
-			       "please consider using the driver defaults, "
-			       "and refer to up-to-date thinkpad-acpi "
-			       "documentation\n");
-		}
+	const u32 fwmask = mask & ~hotkey_source_mask;
 
-		HOTKEY_CONFIG_CRITICAL_START
+	if (tp_features.hotkey_mask) {
 		for (i = 0; i < 32; i++) {
-			u32 m = 1 << i;
-			/* enable in firmware mask only keys not in NVRAM
-			 * mode, but enable the key in the cached hotkey_mask
-			 * regardless of mode, or the key will end up
-			 * disabled by hotkey_mask_get() */
 			if (!acpi_evalf(hkey_handle,
 					NULL, "MHKM", "vdd", i + 1,
-					!!((mask & ~hotkey_source_mask) & m))) {
+					!!(mask & (1 << i)))) {
 				rc = -EIO;
 				break;
-			} else {
-				hotkey_mask = (hotkey_mask & ~m) | (mask & m);
 			}
 		}
-		HOTKEY_CONFIG_CRITICAL_END
+	}
 
-		/* hotkey_mask_get must be called unconditionally below */
-		if (!hotkey_mask_get() && !rc &&
-		    (hotkey_mask & ~hotkey_source_mask) !=
-		     (mask & ~hotkey_source_mask)) {
-			printk(TPACPI_NOTICE
-			       "requested hot key mask 0x%08x, but "
-			       "firmware forced it to 0x%08x\n",
-			       mask, hotkey_mask);
-		}
-	} else {
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-		HOTKEY_CONFIG_CRITICAL_START
-		hotkey_mask = mask & hotkey_source_mask;
-		HOTKEY_CONFIG_CRITICAL_END
-		hotkey_mask_get();
-		if (hotkey_mask != mask) {
-			printk(TPACPI_NOTICE
-			       "requested hot key mask 0x%08x, "
-			       "forced to 0x%08x (NVRAM poll mask is "
-			       "0x%08x): no firmware mask support\n",
-			       mask, hotkey_mask, hotkey_source_mask);
-		}
-#else
-		hotkey_mask_get();
-		rc = -ENXIO;
-#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+	/*
+	 * We *must* make an inconditional call to hotkey_mask_get to
+	 * refresh hotkey_acpi_mask and update hotkey_user_mask
+	 *
+	 * Take the opportunity to also log when we cannot _enable_
+	 * a given event.
+	 */
+	if (!hotkey_mask_get() && !rc && (fwmask & ~hotkey_acpi_mask)) {
+		printk(TPACPI_NOTICE
+		       "asked for hotkey mask 0x%08x, but "
+		       "firmware forced it to 0x%08x\n",
+		       fwmask, hotkey_acpi_mask);
+	}
+
+	hotkey_mask_warn_incomplete_mask();
+
+	return rc;
+}
+
+/*
+ * Sets hotkey_user_mask and tries to set the firmware mask
+ *
+ * Call with hotkey_mutex held
+ */
+static int hotkey_user_mask_set(const u32 mask)
+{
+	int rc;
+
+	/* Give people a chance to notice they are doing something that
+	 * is bound to go boom on their users sooner or later */
+	if (!tp_warned.hotkey_mask_ff &&
+	    (mask == 0xffff || mask == 0xffffff ||
+	     mask == 0xffffffff)) {
+		tp_warned.hotkey_mask_ff = 1;
+		printk(TPACPI_NOTICE
+		       "setting the hotkey mask to 0x%08x is likely "
+		       "not the best way to go about it\n", mask);
+		printk(TPACPI_NOTICE
+		       "please consider using the driver defaults, "
+		       "and refer to up-to-date thinkpad-acpi "
+		       "documentation\n");
 	}
 
+	/* Try to enable what the user asked for, plus whatever we need.
+	 * this syncs everything but won't enable bits in hotkey_user_mask */
+	rc = hotkey_mask_set((mask | hotkey_driver_mask) & ~hotkey_source_mask);
+
+	/* Enable the available bits in hotkey_user_mask */
+	hotkey_user_mask = mask & (hotkey_acpi_mask | hotkey_source_mask);
+
 	return rc;
 }
 
@@ -2137,11 +2200,10 @@ static void tpacpi_input_send_tabletsw(void)
 	}
 }
 
-static void tpacpi_input_send_key(unsigned int scancode)
+/* Do NOT call without validating scancode first */
+static void tpacpi_input_send_key(const unsigned int scancode)
 {
-	unsigned int keycode;
-
-	keycode = hotkey_keycode_map[scancode];
+	const unsigned int keycode = hotkey_keycode_map[scancode];
 
 	if (keycode != KEY_RESERVED) {
 		mutex_lock(&tpacpi_inputdev_send_mutex);
@@ -2162,19 +2224,27 @@ static void tpacpi_input_send_key(unsigned int scancode)
 	}
 }
 
+/* Do NOT call without validating scancode first */
+static void tpacpi_input_send_key_masked(const unsigned int scancode)
+{
+	if (hotkey_user_mask & (1 << scancode))
+		tpacpi_input_send_key(scancode);
+}
+
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 static struct tp_acpi_drv_struct ibm_hotkey_acpidriver;
 
+/* Do NOT call without validating scancode first */
 static void tpacpi_hotkey_send_key(unsigned int scancode)
 {
-	tpacpi_input_send_key(scancode);
+	tpacpi_input_send_key_masked(scancode);
 	if (hotkey_report_mode < 2) {
 		acpi_bus_generate_proc_event(ibm_hotkey_acpidriver.device,
 						0x80, 0x1001 + scancode);
 	}
 }
 
-static void hotkey_read_nvram(struct tp_nvram_state *n, u32 m)
+static void hotkey_read_nvram(struct tp_nvram_state *n, const u32 m)
 {
 	u8 d;
 
@@ -2210,21 +2280,24 @@ static void hotkey_read_nvram(struct tp_nvram_state *n, u32 m)
 	}
 }
 
+static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
+					   struct tp_nvram_state *newn,
+					   const u32 event_mask)
+{
+
 #define TPACPI_COMPARE_KEY(__scancode, __member) \
 	do { \
-		if ((mask & (1 << __scancode)) && \
+		if ((event_mask & (1 << __scancode)) && \
 		    oldn->__member != newn->__member) \
-		tpacpi_hotkey_send_key(__scancode); \
+			tpacpi_hotkey_send_key(__scancode); \
 	} while (0)
 
 #define TPACPI_MAY_SEND_KEY(__scancode) \
-	do { if (mask & (1 << __scancode)) \
-		tpacpi_hotkey_send_key(__scancode); } while (0)
+	do { \
+		if (event_mask & (1 << __scancode)) \
+			tpacpi_hotkey_send_key(__scancode); \
+	} while (0)
 
-static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
-					   struct tp_nvram_state *newn,
-					   u32 mask)
-{
 	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_THINKPAD, thinkpad_toggle);
 	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNSPACE, zoom_toggle);
 	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNF7, display_toggle);
@@ -2270,15 +2343,22 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
 			}
 		}
 	}
-}
 
 #undef TPACPI_COMPARE_KEY
 #undef TPACPI_MAY_SEND_KEY
+}
 
+/*
+ * Polling driver
+ *
+ * We track all events in hotkey_source_mask all the time, since
+ * most of them are edge-based.  We only issue those requested by
+ * hotkey_user_mask or hotkey_driver_mask, though.
+ */
 static int hotkey_kthread(void *data)
 {
 	struct tp_nvram_state s[2];
-	u32 mask;
+	u32 poll_mask, event_mask;
 	unsigned int si, so;
 	unsigned long t;
 	unsigned int change_detector, must_reset;
@@ -2298,10 +2378,12 @@ static int hotkey_kthread(void *data)
 	/* Initial state for compares */
 	mutex_lock(&hotkey_thread_data_mutex);
 	change_detector = hotkey_config_change;
-	mask = hotkey_source_mask & hotkey_mask;
+	poll_mask = hotkey_source_mask;
+	event_mask = hotkey_source_mask &
+			(hotkey_driver_mask | hotkey_user_mask);
 	poll_freq = hotkey_poll_freq;
 	mutex_unlock(&hotkey_thread_data_mutex);
-	hotkey_read_nvram(&s[so], mask);
+	hotkey_read_nvram(&s[so], poll_mask);
 
 	while (!kthread_should_stop()) {
 		if (t == 0) {
@@ -2324,15 +2406,17 @@ static int hotkey_kthread(void *data)
 			t = 0;
 			change_detector = hotkey_config_change;
 		}
-		mask = hotkey_source_mask & hotkey_mask;
+		poll_mask = hotkey_source_mask;
+		event_mask = hotkey_source_mask &
+				(hotkey_driver_mask | hotkey_user_mask);
 		poll_freq = hotkey_poll_freq;
 		mutex_unlock(&hotkey_thread_data_mutex);
 
-		if (likely(mask)) {
-			hotkey_read_nvram(&s[si], mask);
+		if (likely(poll_mask)) {
+			hotkey_read_nvram(&s[si], poll_mask);
 			if (likely(si != so)) {
 				hotkey_compare_and_issue_event(&s[so], &s[si],
-								mask);
+								event_mask);
 			}
 		}
 
@@ -2364,10 +2448,12 @@ static void hotkey_poll_stop_sync(void)
 /* call with hotkey_mutex held */
 static void hotkey_poll_setup(bool may_warn)
 {
-	u32 hotkeys_to_poll = hotkey_source_mask & hotkey_mask;
+	const u32 poll_driver_mask = hotkey_driver_mask & hotkey_source_mask;
+	const u32 poll_user_mask = hotkey_user_mask & hotkey_source_mask;
 
-	if (hotkeys_to_poll != 0 && hotkey_poll_freq > 0 &&
-	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
+	if (hotkey_poll_freq > 0 &&
+	    (poll_driver_mask ||
+	     (poll_user_mask && tpacpi_inputdev->users > 0))) {
 		if (!tpacpi_hotkey_task) {
 			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
 					NULL, TPACPI_NVRAM_KTHREAD_NAME);
@@ -2380,12 +2466,13 @@ static void hotkey_poll_setup(bool may_warn)
 		}
 	} else {
 		hotkey_poll_stop_sync();
-		if (may_warn && hotkeys_to_poll != 0 &&
+		if (may_warn && (poll_driver_mask || poll_user_mask) &&
 		    hotkey_poll_freq == 0) {
 			printk(TPACPI_NOTICE
-				"hot keys 0x%08x require polling, "
-				"which is currently disabled\n",
-				hotkeys_to_poll);
+				"hot keys 0x%08x and/or events 0x%08x "
+				"require polling, which is currently "
+				"disabled\n",
+				poll_user_mask, poll_driver_mask);
 		}
 	}
 }
@@ -2403,9 +2490,7 @@ static void hotkey_poll_set_freq(unsigned int freq)
 	if (!freq)
 		hotkey_poll_stop_sync();
 
-	HOTKEY_CONFIG_CRITICAL_START
 	hotkey_poll_freq = freq;
-	HOTKEY_CONFIG_CRITICAL_END
 }
 
 #else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
@@ -2440,7 +2525,8 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 static void hotkey_inputdev_close(struct input_dev *dev)
 {
 	/* disable hotkey polling when possible */
-	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING)
+	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING &&
+	    !(hotkey_source_mask & hotkey_driver_mask))
 		hotkey_poll_setup_safe(false);
 }
 
@@ -2488,15 +2574,7 @@ static ssize_t hotkey_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	int res;
-
-	if (mutex_lock_killable(&hotkey_mutex))
-		return -ERESTARTSYS;
-	res = hotkey_mask_get();
-	mutex_unlock(&hotkey_mutex);
-
-	return (res)?
-		res : snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_mask);
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_user_mask);
 }
 
 static ssize_t hotkey_mask_store(struct device *dev,
@@ -2512,7 +2590,7 @@ static ssize_t hotkey_mask_store(struct device *dev,
 	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
-	res = hotkey_mask_set(t);
+	res = hotkey_user_mask_set(t);
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup(true);
@@ -2594,6 +2672,8 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 			    const char *buf, size_t count)
 {
 	unsigned long t;
+	u32 r_ev;
+	int rc;
 
 	if (parse_strtoul(buf, 0xffffffffUL, &t) ||
 		((t & ~TPACPI_HKEY_NVRAM_KNOWN_MASK) != 0))
@@ -2606,14 +2686,28 @@ static ssize_t hotkey_source_mask_store(struct device *dev,
 	hotkey_source_mask = t;
 	HOTKEY_CONFIG_CRITICAL_END
 
+	rc = hotkey_mask_set((hotkey_user_mask | hotkey_driver_mask) &
+			~hotkey_source_mask);
 	hotkey_poll_setup(true);
-	hotkey_mask_set(hotkey_mask);
+
+	/* check if events needed by the driver got disabled */
+	r_ev = hotkey_driver_mask & ~(hotkey_acpi_mask & hotkey_all_mask)
+		& ~hotkey_source_mask & TPACPI_HKEY_NVRAM_KNOWN_MASK;
 
 	mutex_unlock(&hotkey_mutex);
 
+	if (rc < 0)
+		printk(TPACPI_ERR "hotkey_source_mask: failed to update the"
+			"firmware event mask!\n");
+
+	if (r_ev)
+		printk(TPACPI_NOTICE "hotkey_source_mask: "
+			"some important events were disabled: "
+			"0x%04x\n", r_ev);
+
 	tpacpi_disclose_usertask("hotkey_source_mask", "set to 0x%08lx\n", t);
 
-	return count;
+	return (rc < 0) ? rc : count;
 }
 
 static struct device_attribute dev_attr_hotkey_source_mask =
@@ -2731,9 +2825,8 @@ static struct device_attribute dev_attr_hotkey_wakeup_reason =
 
 static void hotkey_wakeup_reason_notify_change(void)
 {
-	if (tp_features.hotkey_mask)
-		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
-			     "wakeup_reason");
+	sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+		     "wakeup_reason");
 }
 
 /* sysfs wakeup hotunplug_complete (pollable) -------------------------- */
@@ -2750,9 +2843,8 @@ static struct device_attribute dev_attr_hotkey_wakeup_hotunplug_complete =
 
 static void hotkey_wakeup_hotunplug_complete_notify_change(void)
 {
-	if (tp_features.hotkey_mask)
-		sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
-			     "wakeup_hotunplug_complete");
+	sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+		     "wakeup_hotunplug_complete");
 }
 
 /* --------------------------------------------------------------------- */
@@ -2760,27 +2852,19 @@ static void hotkey_wakeup_hotunplug_complete_notify_change(void)
 static struct attribute *hotkey_attributes[] __initdata = {
 	&dev_attr_hotkey_enable.attr,
 	&dev_attr_hotkey_bios_enabled.attr,
+	&dev_attr_hotkey_bios_mask.attr,
 	&dev_attr_hotkey_report_mode.attr,
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	&dev_attr_hotkey_wakeup_reason.attr,
+	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
 	&dev_attr_hotkey_mask.attr,
 	&dev_attr_hotkey_all_mask.attr,
 	&dev_attr_hotkey_recommended_mask.attr,
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	&dev_attr_hotkey_source_mask.attr,
 	&dev_attr_hotkey_poll_freq.attr,
 #endif
 };
 
-static struct attribute *hotkey_mask_attributes[] __initdata = {
-	&dev_attr_hotkey_bios_mask.attr,
-#ifndef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-	&dev_attr_hotkey_mask.attr,
-	&dev_attr_hotkey_all_mask.attr,
-	&dev_attr_hotkey_recommended_mask.attr,
-#endif
-	&dev_attr_hotkey_wakeup_reason.attr,
-	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
-};
-
 /*
  * Sync both the hw and sw blocking state of all switches
  */
@@ -2844,10 +2928,12 @@ static void hotkey_exit(void)
 	kfree(hotkey_keycode_map);
 
 	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
-		   "restoring original hot key mask\n");
-	/* no short-circuit boolean operator below! */
-	if (((tp_features.hotkey_mask && hotkey_mask_set(hotkey_orig_mask))
-	     | hotkey_status_set(false)) != 0)
+		   "restoring original HKEY status and mask\n");
+	/* yes, there is a bitwise or below, we want the
+	 * functions to be called even if one of them fail */
+	if (((tp_features.hotkey_mask &&
+	      hotkey_mask_set(hotkey_orig_mask)) |
+	     hotkey_status_set(false)) != 0)
 		printk(TPACPI_ERR
 		       "failed to restore hot key mask "
 		       "to BIOS defaults\n");
@@ -2862,6 +2948,35 @@ static void __init hotkey_unmap(const unsigned int scancode)
 	}
 }
 
+/*
+ * HKEY quirks:
+ *   TPACPI_HK_Q_INIMASK:	Supports FN+F3,FN+F4,FN+F12
+ */
+
+#define	TPACPI_HK_Q_INIMASK	0x0001
+
+static const struct tpacpi_quirk tpacpi_hotkey_qtable[] __initconst = {
+	TPACPI_Q_IBM('I', 'H', TPACPI_HK_Q_INIMASK), /* 600E */
+	TPACPI_Q_IBM('I', 'N', TPACPI_HK_Q_INIMASK), /* 600E */
+	TPACPI_Q_IBM('I', 'D', TPACPI_HK_Q_INIMASK), /* 770, 770E, 770ED */
+	TPACPI_Q_IBM('I', 'W', TPACPI_HK_Q_INIMASK), /* A20m */
+	TPACPI_Q_IBM('I', 'V', TPACPI_HK_Q_INIMASK), /* A20p */
+	TPACPI_Q_IBM('1', '0', TPACPI_HK_Q_INIMASK), /* A21e, A22e */
+	TPACPI_Q_IBM('K', 'U', TPACPI_HK_Q_INIMASK), /* A21e */
+	TPACPI_Q_IBM('K', 'X', TPACPI_HK_Q_INIMASK), /* A21m, A22m */
+	TPACPI_Q_IBM('K', 'Y', TPACPI_HK_Q_INIMASK), /* A21p, A22p */
+	TPACPI_Q_IBM('1', 'B', TPACPI_HK_Q_INIMASK), /* A22e */
+	TPACPI_Q_IBM('1', '3', TPACPI_HK_Q_INIMASK), /* A22m */
+	TPACPI_Q_IBM('1', 'E', TPACPI_HK_Q_INIMASK), /* A30/p (0) */
+	TPACPI_Q_IBM('1', 'C', TPACPI_HK_Q_INIMASK), /* R30 */
+	TPACPI_Q_IBM('1', 'F', TPACPI_HK_Q_INIMASK), /* R31 */
+	TPACPI_Q_IBM('I', 'Y', TPACPI_HK_Q_INIMASK), /* T20 */
+	TPACPI_Q_IBM('K', 'Z', TPACPI_HK_Q_INIMASK), /* T21 */
+	TPACPI_Q_IBM('1', '6', TPACPI_HK_Q_INIMASK), /* T22 */
+	TPACPI_Q_IBM('I', 'Z', TPACPI_HK_Q_INIMASK), /* X20, X21 */
+	TPACPI_Q_IBM('1', 'D', TPACPI_HK_Q_INIMASK), /* X22, X23, X24 */
+};
+
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
 	/* Requirements for changing the default keymaps:
@@ -2904,9 +3019,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN,	/* 0x0D: FN+INSERT */
 		KEY_UNKNOWN,	/* 0x0E: FN+DELETE */
 
-		/* brightness: firmware always reacts to them, unless
-		 * X.org did some tricks in the radeon BIOS scratch
-		 * registers of *some* models */
+		/* brightness: firmware always reacts to them */
 		KEY_RESERVED,	/* 0x0F: FN+HOME (brightness up) */
 		KEY_RESERVED,	/* 0x10: FN+END (brightness down) */
 
@@ -2981,6 +3094,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	int status;
 	int hkeyv;
 
+	unsigned long quirks;
+
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 			"initializing hotkey subdriver\n");
 
@@ -3006,9 +3121,16 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (!tp_features.hotkey)
 		return 1;
 
+	quirks = tpacpi_check_quirks(tpacpi_hotkey_qtable,
+				     ARRAY_SIZE(tpacpi_hotkey_qtable));
+
 	tpacpi_disable_brightness_delay();
 
-	hotkey_dev_attributes = create_attr_set(13, NULL);
+	/* MUST have enough space for all attributes to be added to
+	 * hotkey_dev_attributes */
+	hotkey_dev_attributes = create_attr_set(
+					ARRAY_SIZE(hotkey_attributes) + 2,
+					NULL);
 	if (!hotkey_dev_attributes)
 		return -ENOMEM;
 	res = add_many_to_attr_set(hotkey_dev_attributes,
@@ -3017,7 +3139,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (res)
 		goto err_exit;
 
-	/* mask not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
+	/* mask not supported on 600e/x, 770e, 770x, A21e, A2xm/p,
 	   A30, R30, R31, T20-22, X20-21, X22-24.  Detected by checking
 	   for HKEY interface version 0x100 */
 	if (acpi_evalf(hkey_handle, &hkeyv, "MHKV", "qd")) {
@@ -3031,10 +3153,22 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			 * MHKV 0x100 in A31, R40, R40e,
 			 * T4x, X31, and later
 			 */
-			tp_features.hotkey_mask = 1;
 			vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 				"firmware HKEY interface version: 0x%x\n",
 				hkeyv);
+
+			/* Paranoia check AND init hotkey_all_mask */
+			if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
+					"MHKA", "qd")) {
+				printk(TPACPI_ERR
+				       "missing MHKA handler, "
+				       "please report this to %s\n",
+				       TPACPI_MAIL);
+				/* Fallback: pre-init for FN+F3,F4,F12 */
+				hotkey_all_mask = 0x080cU;
+			} else {
+				tp_features.hotkey_mask = 1;
+			}
 		}
 	}
 
@@ -3042,32 +3176,23 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		"hotkey masks are %s\n",
 		str_supported(tp_features.hotkey_mask));
 
-	if (tp_features.hotkey_mask) {
-		if (!acpi_evalf(hkey_handle, &hotkey_all_mask,
-				"MHKA", "qd")) {
-			printk(TPACPI_ERR
-			       "missing MHKA handler, "
-			       "please report this to %s\n",
-			       TPACPI_MAIL);
-			/* FN+F12, FN+F4, FN+F3 */
-			hotkey_all_mask = 0x080cU;
-		}
-	}
+	/* Init hotkey_all_mask if not initialized yet */
+	if (!tp_features.hotkey_mask && !hotkey_all_mask &&
+	    (quirks & TPACPI_HK_Q_INIMASK))
+		hotkey_all_mask = 0x080cU;  /* FN+F12, FN+F4, FN+F3 */
 
-	/* hotkey_source_mask *must* be zero for
-	 * the first hotkey_mask_get */
+	/* Init hotkey_acpi_mask and hotkey_orig_mask */
 	if (tp_features.hotkey_mask) {
+		/* hotkey_source_mask *must* be zero for
+		 * the first hotkey_mask_get to return hotkey_orig_mask */
 		res = hotkey_mask_get();
 		if (res)
 			goto err_exit;
 
-		hotkey_orig_mask = hotkey_mask;
-		res = add_many_to_attr_set(
-				hotkey_dev_attributes,
-				hotkey_mask_attributes,
-				ARRAY_SIZE(hotkey_mask_attributes));
-		if (res)
-			goto err_exit;
+		hotkey_orig_mask = hotkey_acpi_mask;
+	} else {
+		hotkey_orig_mask = hotkey_all_mask;
+		hotkey_acpi_mask = hotkey_all_mask;
 	}
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
@@ -3181,14 +3306,9 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	}
 
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
-	if (tp_features.hotkey_mask) {
-		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
-					& ~hotkey_all_mask
-					& ~hotkey_reserved_mask;
-	} else {
-		hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
-					& ~hotkey_reserved_mask;
-	}
+	hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
+				& ~hotkey_all_mask
+				& ~hotkey_reserved_mask;
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 		    "hotkey source mask 0x%08x, polling freq %u\n",
@@ -3202,13 +3322,18 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		hotkey_exit();
 		return res;
 	}
-	res = hotkey_mask_set(((hotkey_all_mask | hotkey_source_mask)
-				& ~hotkey_reserved_mask)
-				| hotkey_orig_mask);
+	res = hotkey_mask_set(((hotkey_all_mask & ~hotkey_reserved_mask)
+			       | hotkey_driver_mask)
+			      & ~hotkey_source_mask);
 	if (res < 0 && res != -ENXIO) {
 		hotkey_exit();
 		return res;
 	}
+	hotkey_user_mask = (hotkey_acpi_mask | hotkey_source_mask)
+				& ~hotkey_reserved_mask;
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
+		"initial masks: user=0x%08x, fw=0x%08x, poll=0x%08x\n",
+		hotkey_user_mask, hotkey_acpi_mask, hotkey_source_mask);
 
 	dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_HKEY,
 			"legacy ibm/hotkey event reporting over procfs %s\n",
@@ -3243,7 +3368,7 @@ static bool hotkey_notify_hotkey(const u32 hkey,
 	if (scancode > 0 && scancode < 0x21) {
 		scancode--;
 		if (!(hotkey_source_mask & (1 << scancode))) {
-			tpacpi_input_send_key(scancode);
+			tpacpi_input_send_key_masked(scancode);
 			*send_acpi_ev = false;
 		} else {
 			*ignore_acpi_ev = true;
@@ -3498,10 +3623,12 @@ static void hotkey_resume(void)
 {
 	tpacpi_disable_brightness_delay();
 
-	if (hotkey_mask_get())
+	if (hotkey_status_set(true) < 0 ||
+	    hotkey_mask_set(hotkey_acpi_mask) < 0)
 		printk(TPACPI_ERR
-		       "error while trying to read hot key mask "
-		       "from firmware\n");
+		       "error while attempting to reset the event "
+		       "firmware interface\n");
+
 	tpacpi_send_radiosw_update();
 	hotkey_tablet_mode_notify_change();
 	hotkey_wakeup_reason_notify_change();
@@ -3530,8 +3657,8 @@ static int hotkey_read(char *p)
 		return res;
 
 	len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 0));
-	if (tp_features.hotkey_mask) {
-		len += sprintf(p + len, "mask:\t\t0x%08x\n", hotkey_mask);
+	if (hotkey_all_mask) {
+		len += sprintf(p + len, "mask:\t\t0x%08x\n", hotkey_user_mask);
 		len += sprintf(p + len,
 			       "commands:\tenable, disable, reset, <mask>\n");
 	} else {
@@ -3568,7 +3695,7 @@ static int hotkey_write(char *buf)
 	if (mutex_lock_killable(&hotkey_mutex))
 		return -ERESTARTSYS;
 
-	mask = hotkey_mask;
+	mask = hotkey_user_mask;
 
 	res = 0;
 	while ((cmd = next_cmd(&buf))) {
@@ -3590,12 +3717,11 @@ static int hotkey_write(char *buf)
 		}
 	}
 
-	if (!res)
+	if (!res) {
 		tpacpi_disclose_usertask("procfs hotkey",
 			"set mask to 0x%08x\n", mask);
-
-	if (!res && mask != hotkey_mask)
-		res = hotkey_mask_set(mask);
+		res = hotkey_user_mask_set(mask);
+	}
 
 errexit:
 	mutex_unlock(&hotkey_mutex);
-- 
1.6.3.3

