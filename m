From: Len Brown <lenb@kernel.org>
Subject: [PATCH 035/112] ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v9)
Date: Thu,  7 Feb 2008 04:33:57 -0500
Message-ID: <01e88f25985d8ea5866c9a73d56b3a9a9145066f.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753203AbYBGJgB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:01 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Older ThinkPad models do not export some of the hot keys over the
event-based ACPI hot key interface.  For these models, one has to poll
the CMOS NVRAM to check the key state at a rate faster than the expected
rate at which the user might repeatedly press the same hot key.

This patch implements this functionality for many of the hotkeys in a
transparent way: hot keys will now Just Work, and the driver knows the
best approach (events or NVRAM polling) to employ, based on the
HKEY.MHKA ACPI method.

Also, the driver can turn off the polling when there are no users for
the hot keys that need such polling.

The NVRAM-based hot keys of the A3x series that have never been
implemented by later models are not supported, to avoid changes in the
keymap of the input devices that could cause headaches in the future.

There is a Kconfig option to avoid compiling the NVRAM polling code, as
it is not very small, and unlikely to be useful on any ThinkPad newer
than a T40, X31 or R52.

This feature is based on a previous effort by Richard Hughes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   71 +++++-
 drivers/misc/Kconfig            |   19 ++
 drivers/misc/thinkpad_acpi.c    |  505 ++++++++++++++++++++++++++++++++++++++-
 drivers/misc/thinkpad_acpi.h    |   60 +++++-
 4 files changed, 632 insertions(+), 23 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 10c041c..70d91a5 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -215,6 +215,11 @@ The following commands can be written to the /proc/acpi/ibm/hotkey file:
 	... any other 8-hex-digit mask ...
 	echo reset > /proc/acpi/ibm/hotkey -- restore the original mask
 
+The procfs interface does not support NVRAM polling control.  So as to
+maintain maximum bug-to-bug compatibility, it does not report any masks,
+nor does it allow one to manipulate the hot key mask when the firmware
+does not support masks at all, even if NVRAM polling is in use.
+
 sysfs notes:
 
 	hotkey_bios_enabled:
@@ -231,17 +236,26 @@ sysfs notes:
 		to this value.
 
 	hotkey_enable:
-		Enables/disables the hot keys feature, and reports
-		current status of the hot keys feature.
+		Enables/disables the hot keys feature in the ACPI
+		firmware, and reports current status of the hot keys
+		feature.  Has no effect on the NVRAM hot key polling
+		functionality.
 
 		0: disables the hot keys feature / feature disabled
 		1: enables the hot keys feature / feature enabled
 
 	hotkey_mask:
-		bit mask to enable driver-handling and ACPI event
-		generation for each hot key (see above).  Returns the
-		current status of the hot keys mask, and allows one to
-		modify it.
+		bit mask to enable driver-handling (and depending on
+		the firmware, ACPI event generation) for each hot key
+		(see above).  Returns the current status of the hot keys
+		mask, and allows one to modify it.
+
+		Note: when NVRAM polling is active, the firmware mask
+		will be different from the value returned by
+		hotkey_mask.  The driver will retain enabled bits for
+		hotkeys that are under NVRAM polling even if the
+		firmware refuses them, and will not set these bits on
+		the firmware hot key mask.
 
 	hotkey_all_mask:
 		bit mask that should enable event reporting for all
@@ -257,6 +271,40 @@ sysfs notes:
 		handled by the firmware anyway.  Echo it to
 		hotkey_mask above, to use.
 
+	hotkey_source_mask:
+		bit mask that selects which hot keys will the driver
+		poll the NVRAM for.  This is auto-detected by the driver
+		based on the capabilities reported by the ACPI firmware,
+		but it can be overridden at runtime.
+
+		Hot keys whose bits are set in both hotkey_source_mask
+		and also on hotkey_mask are polled for in NVRAM.  Only a
+		few hot keys are available through CMOS NVRAM polling.
+
+		Warning: when in NVRAM mode, the volume up/down/mute
+		keys are synthesized according to changes in the mixer,
+		so you have to use volume up or volume down to unmute,
+		as per the ThinkPad volume mixer user interface.  When
+		in ACPI event mode, volume up/down/mute are reported as
+		separate events, but this behaviour may be corrected in
+		future releases of this driver, in which case the
+		ThinkPad volume mixer user interface semanthics will be
+		enforced.
+
+	hotkey_poll_freq:
+		frequency in Hz for hot key polling. It must be between
+		0 and 25 Hz.  Polling is only carried out when strictly
+		needed.
+
+		Setting hotkey_poll_freq to zero disables polling, and
+		will cause hot key presses that require NVRAM polling
+		to never be reported.
+
+		Setting hotkey_poll_freq too low will cause repeated
+		pressings of the same hot key to be misreported as a
+		single key press, or to not even be detected at all.
+		The recommended polling frequency is 10Hz.
+
 	hotkey_radio_sw:
 		if the ThinkPad has a hardware radio switch, this
 		attribute will read 0 if the switch is in the "radios
@@ -1263,3 +1311,14 @@ Sysfs interface changelog:
 		and the hwmon class for libsensors4 (lm-sensors 3)
 		compatibility.  Moved all hwmon attributes to this
 		new platform device.
+
+0x020100:	Marker for thinkpad-acpi with hot key NVRAM polling
+		support.  If you must, use it to know you should not
+		start an userspace NVRAM poller (allows to detect when
+		NVRAM is compiled out by the user because it is
+		unneeded/undesired in the first place).
+0x020101:	Marker for thinkpad-acpi with hot key NVRAM polling
+		and proper hotkey_mask semanthics (version 8 of the
+		NVRAM polling patch).  Some development snapshots of
+		0.18 had an earlier version that did strange things
+		to hotkey_mask.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b5e67c0..b1f9a40 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -219,6 +219,25 @@ config THINKPAD_ACPI_BAY
 
 	  If you are not sure, say Y here.
 
+config THINKPAD_ACPI_HOTKEY_POLL
+	bool "Suport NVRAM polling for hot keys"
+	depends on THINKPAD_ACPI
+	default y
+	---help---
+	  Some thinkpad models benefit from NVRAM polling to detect a few of
+	  the hot key press events.  If you know your ThinkPad model does not
+	  need to do NVRAM polling to support any of the hot keys you use,
+	  unselecting this option will save about 1kB of memory.
+
+	  ThinkPads T40 and newer, R52 and newer, and X31 and newer are
+	  unlikely to need NVRAM polling in their latest BIOS versions.
+
+	  NVRAM polling can detect at most the following keys: ThinkPad/Access
+	  IBM, Zoom, Switch Display (fn+F7), ThinkLight, Volume up/down/mute,
+	  Brightness up/down, Display Expand (fn+F8), Hibernate (fn+F12).
+
+	  If you are not sure, say Y here.  The driver enables polling only if
+	  it is strictly necessary to do so.
 
 config ATMEL_SSC
 	tristate "Device driver for Atmel SSC peripheral"
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e7ac1c8..9ff9142 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define IBM_VERSION "0.17"
-#define TPACPI_SYSFS_VERSION 0x020000
+#define TPACPI_SYSFS_VERSION 0x020101
 
 /*
  *  Changelog:
@@ -773,6 +773,67 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
  * Hotkey subdriver
  */
 
+enum {	/* Keys available through NVRAM polling */
+	TPACPI_HKEY_NVRAM_KNOWN_MASK = 0x00fb88c0U,
+	TPACPI_HKEY_NVRAM_GOOD_MASK  = 0x00fb8000U,
+};
+
+enum {	/* Positions of some of the keys in hotkey masks */
+	TP_ACPI_HKEY_DISPSWTCH_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNF7,
+	TP_ACPI_HKEY_DISPXPAND_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNF8,
+	TP_ACPI_HKEY_HIBERNATE_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNF12,
+	TP_ACPI_HKEY_BRGHTUP_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNHOME,
+	TP_ACPI_HKEY_BRGHTDWN_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNEND,
+	TP_ACPI_HKEY_THNKLGHT_MASK	= 1 << TP_ACPI_HOTKEYSCAN_FNPAGEUP,
+	TP_ACPI_HKEY_ZOOM_MASK		= 1 << TP_ACPI_HOTKEYSCAN_FNSPACE,
+	TP_ACPI_HKEY_VOLUP_MASK		= 1 << TP_ACPI_HOTKEYSCAN_VOLUMEUP,
+	TP_ACPI_HKEY_VOLDWN_MASK	= 1 << TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
+	TP_ACPI_HKEY_MUTE_MASK		= 1 << TP_ACPI_HOTKEYSCAN_MUTE,
+	TP_ACPI_HKEY_THINKPAD_MASK	= 1 << TP_ACPI_HOTKEYSCAN_THINKPAD,
+};
+
+enum {	/* NVRAM to ACPI HKEY group map */
+	TP_NVRAM_HKEY_GROUP_HK2		= TP_ACPI_HKEY_THINKPAD_MASK |
+					  TP_ACPI_HKEY_ZOOM_MASK |
+					  TP_ACPI_HKEY_DISPSWTCH_MASK |
+					  TP_ACPI_HKEY_HIBERNATE_MASK,
+	TP_NVRAM_HKEY_GROUP_BRIGHTNESS	= TP_ACPI_HKEY_BRGHTUP_MASK |
+					  TP_ACPI_HKEY_BRGHTDWN_MASK,
+	TP_NVRAM_HKEY_GROUP_VOLUME	= TP_ACPI_HKEY_VOLUP_MASK |
+					  TP_ACPI_HKEY_VOLDWN_MASK |
+					  TP_ACPI_HKEY_MUTE_MASK,
+};
+
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+struct tp_nvram_state {
+       u16 thinkpad_toggle:1;
+       u16 zoom_toggle:1;
+       u16 display_toggle:1;
+       u16 thinklight_toggle:1;
+       u16 hibernate_toggle:1;
+       u16 displayexp_toggle:1;
+       u16 display_state:1;
+       u16 brightness_toggle:1;
+       u16 volume_toggle:1;
+       u16 mute:1;
+
+       u8 brightness_level;
+       u8 volume_level;
+};
+
+static struct task_struct *tpacpi_hotkey_task;
+static u32 hotkey_source_mask;		/* bit mask 0=ACPI,1=NVRAM */
+static int hotkey_poll_freq = 10;	/* Hz */
+static struct mutex hotkey_thread_mutex;
+static struct mutex hotkey_thread_data_mutex;
+static unsigned int hotkey_config_change;
+
+#else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
+#define hotkey_source_mask 0U
+
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 static u32 hotkey_all_mask;
@@ -783,6 +844,17 @@ static u16 *hotkey_keycode_map;
 
 static struct attribute_set *hotkey_dev_attributes;
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+#define HOTKEY_CONFIG_CRITICAL_START \
+	mutex_lock(&hotkey_thread_data_mutex); \
+	hotkey_config_change++;
+#define HOTKEY_CONFIG_CRITICAL_END \
+	mutex_unlock(&hotkey_thread_data_mutex);
+#else
+#define HOTKEY_CONFIG_CRITICAL_START
+#define HOTKEY_CONFIG_CRITICAL_END
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 static int hotkey_get_wlsw(int *status)
 {
 	if (!acpi_evalf(hkey_handle, status, "WLSW", "d"))
@@ -795,10 +867,13 @@ static int hotkey_get_wlsw(int *status)
  */
 static int hotkey_mask_get(void)
 {
+	u32 m = 0;
+
 	if (tp_features.hotkey_mask) {
-		if (!acpi_evalf(hkey_handle, &hotkey_mask, "DHKN", "d"))
+		if (!acpi_evalf(hkey_handle, &m, "DHKN", "d"))
 			return -EIO;
 	}
+	hotkey_mask = m | (hotkey_source_mask & hotkey_mask);
 
 	return 0;
 }
@@ -812,25 +887,50 @@ static int hotkey_mask_set(u32 mask)
 	int rc = 0;
 
 	if (tp_features.hotkey_mask) {
+		HOTKEY_CONFIG_CRITICAL_START
 		for (i = 0; i < 32; i++) {
 			u32 m = 1 << i;
+			/* enable in firmware mask only keys not in NVRAM
+			 * mode, but enable the key in the cached hotkey_mask
+			 * regardless of mode, or the key will end up
+			 * disabled by hotkey_mask_get() */
 			if (!acpi_evalf(hkey_handle,
 					NULL, "MHKM", "vdd", i + 1,
-					!!(mask & m))) {
+					!!((mask & ~hotkey_source_mask) & m))) {
 				rc = -EIO;
 				break;
 			} else {
 				hotkey_mask = (hotkey_mask & ~m) | (mask & m);
 			}
 		}
+		HOTKEY_CONFIG_CRITICAL_END
 
 		/* hotkey_mask_get must be called unconditionally below */
-		if (!hotkey_mask_get() && !rc && hotkey_mask != mask) {
+		if (!hotkey_mask_get() && !rc &&
+		    (hotkey_mask & ~hotkey_source_mask) !=
+		     (mask & ~hotkey_source_mask)) {
 			printk(IBM_NOTICE
 			       "requested hot key mask 0x%08x, but "
 			       "firmware forced it to 0x%08x\n",
 			       mask, hotkey_mask);
 		}
+	} else {
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+		HOTKEY_CONFIG_CRITICAL_START
+		hotkey_mask = mask & hotkey_source_mask;
+		HOTKEY_CONFIG_CRITICAL_END
+		hotkey_mask_get();
+		if (hotkey_mask != mask) {
+			printk(IBM_NOTICE
+			       "requested hot key mask 0x%08x, "
+			       "forced to 0x%08x (NVRAM poll mask is "
+			       "0x%08x): no firmware mask support\n",
+			       mask, hotkey_mask, hotkey_source_mask);
+		}
+#else
+		hotkey_mask_get();
+		rc = -ENXIO;
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 	}
 
 	return rc;
@@ -892,6 +992,256 @@ static void tpacpi_input_send_key(unsigned int scancode)
 	}
 }
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+static struct tp_acpi_drv_struct ibm_hotkey_acpidriver;
+
+static void tpacpi_hotkey_send_key(unsigned int scancode)
+{
+	tpacpi_input_send_key(scancode);
+	if (hotkey_report_mode < 2) {
+		acpi_bus_generate_proc_event(ibm_hotkey_acpidriver.device,
+						0x80, 0x1001 + scancode);
+	}
+}
+
+static void hotkey_read_nvram(struct tp_nvram_state *n, u32 m)
+{
+	u8 d;
+
+	if (m & TP_NVRAM_HKEY_GROUP_HK2) {
+		d = nvram_read_byte(TP_NVRAM_ADDR_HK2);
+		n->thinkpad_toggle = !!(d & TP_NVRAM_MASK_HKT_THINKPAD);
+		n->zoom_toggle = !!(d & TP_NVRAM_MASK_HKT_ZOOM);
+		n->display_toggle = !!(d & TP_NVRAM_MASK_HKT_DISPLAY);
+		n->hibernate_toggle = !!(d & TP_NVRAM_MASK_HKT_HIBERNATE);
+	}
+	if (m & TP_ACPI_HKEY_THNKLGHT_MASK) {
+		d = nvram_read_byte(TP_NVRAM_ADDR_THINKLIGHT);
+		n->thinklight_toggle = !!(d & TP_NVRAM_MASK_THINKLIGHT);
+	}
+	if (m & TP_ACPI_HKEY_DISPXPAND_MASK) {
+		d = nvram_read_byte(TP_NVRAM_ADDR_VIDEO);
+		n->displayexp_toggle =
+				!!(d & TP_NVRAM_MASK_HKT_DISPEXPND);
+	}
+	if (m & TP_NVRAM_HKEY_GROUP_BRIGHTNESS) {
+		d = nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS);
+		n->brightness_level = (d & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
+				>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
+		n->brightness_toggle =
+				!!(d & TP_NVRAM_MASK_HKT_BRIGHTNESS);
+	}
+	if (m & TP_NVRAM_HKEY_GROUP_VOLUME) {
+		d = nvram_read_byte(TP_NVRAM_ADDR_MIXER);
+		n->volume_level = (d & TP_NVRAM_MASK_LEVEL_VOLUME)
+				>> TP_NVRAM_POS_LEVEL_VOLUME;
+		n->mute = !!(d & TP_NVRAM_MASK_MUTE);
+		n->volume_toggle = !!(d & TP_NVRAM_MASK_HKT_VOLUME);
+	}
+}
+
+#define TPACPI_COMPARE_KEY(__scancode, __member) \
+	do { if ((mask & (1 << __scancode)) && oldn->__member != newn->__member) \
+		tpacpi_hotkey_send_key(__scancode); } while (0)
+
+#define TPACPI_MAY_SEND_KEY(__scancode) \
+	do { if (mask & (1 << __scancode)) \
+		tpacpi_hotkey_send_key(__scancode); } while (0)
+
+static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
+                                           struct tp_nvram_state *newn,
+					   u32 mask)
+{
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_THINKPAD, thinkpad_toggle);
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNSPACE, zoom_toggle);
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNF7, display_toggle);
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNF12, hibernate_toggle);
+
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNPAGEUP, thinklight_toggle);
+
+	TPACPI_COMPARE_KEY(TP_ACPI_HOTKEYSCAN_FNF8, displayexp_toggle);
+
+	/* handle volume */
+	if (oldn->volume_toggle != newn->volume_toggle) {
+		if (oldn->mute != newn->mute) {
+			TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_MUTE);
+		}
+		if (oldn->volume_level > newn->volume_level) {
+			TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEDOWN);
+		} else if (oldn->volume_level < newn->volume_level) {
+			TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEUP);
+		} else if (oldn->mute == newn->mute) {
+			/* repeated key presses that didn't change state */
+			if (newn->mute) {
+				TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_MUTE);
+			} else if (newn->volume_level != 0) {
+				TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEUP);
+			} else {
+				TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_VOLUMEDOWN);
+			}
+		}
+	}
+
+	/* handle brightness */
+	if (oldn->brightness_toggle != newn->brightness_toggle) {
+		if (oldn->brightness_level < newn->brightness_level) {
+			TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_FNHOME);
+		} else if (oldn->brightness_level > newn->brightness_level) {
+			TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_FNEND);
+		} else {
+			/* repeated key presses that didn't change state */
+			if (newn->brightness_level != 0) {
+				TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_FNHOME);
+			} else {
+				TPACPI_MAY_SEND_KEY(TP_ACPI_HOTKEYSCAN_FNEND);
+			}
+		}
+	}
+}
+
+#undef TPACPI_COMPARE_KEY
+#undef TPACPI_MAY_SEND_KEY
+
+static int hotkey_kthread(void *data)
+{
+	struct tp_nvram_state s[2];
+	u32 mask;
+	unsigned int si, so;
+	unsigned long t;
+	unsigned int change_detector, must_reset;
+
+	mutex_lock(&hotkey_thread_mutex);
+
+	if (tpacpi_lifecycle == TPACPI_LIFE_EXITING)
+		goto exit;
+
+	set_freezable();
+
+	so = 0;
+	si = 1;
+	t = 0;
+
+	/* Initial state for compares */
+	mutex_lock(&hotkey_thread_data_mutex);
+	change_detector = hotkey_config_change;
+	mask = hotkey_source_mask & hotkey_mask;
+	mutex_unlock(&hotkey_thread_data_mutex);
+	hotkey_read_nvram(&s[so], mask);
+
+	while (!kthread_should_stop() && hotkey_poll_freq) {
+		if (t == 0)
+			t = 1000/hotkey_poll_freq;
+		t = msleep_interruptible(t);
+		if (unlikely(kthread_should_stop()))
+			break;
+		must_reset = try_to_freeze();
+		if (t > 0 && !must_reset)
+			continue;
+
+		mutex_lock(&hotkey_thread_data_mutex);
+		if (must_reset || hotkey_config_change != change_detector) {
+			/* forget old state on thaw or config change */
+			si = so;
+			t = 0;
+			change_detector = hotkey_config_change;
+		}
+		mask = hotkey_source_mask & hotkey_mask;
+		mutex_unlock(&hotkey_thread_data_mutex);
+
+		if (likely(mask)) {
+			hotkey_read_nvram(&s[si], mask);
+			if (likely(si != so)) {
+				hotkey_compare_and_issue_event(&s[so], &s[si],
+				                               mask);
+			}
+		}
+
+		so = si;
+		si ^= 1;
+	}
+
+exit:
+	mutex_unlock(&hotkey_thread_mutex);
+	return 0;
+}
+
+static void hotkey_poll_stop_sync(void)
+{
+	if (tpacpi_hotkey_task) {
+		if (frozen(tpacpi_hotkey_task) ||
+		    freezing(tpacpi_hotkey_task))
+			thaw_process(tpacpi_hotkey_task);
+
+		kthread_stop(tpacpi_hotkey_task);
+		tpacpi_hotkey_task = NULL;
+		mutex_lock(&hotkey_thread_mutex);
+		/* at this point, the thread did exit */
+		mutex_unlock(&hotkey_thread_mutex);
+	}
+}
+
+/* call with hotkey_mutex held */
+static void hotkey_poll_setup(int may_warn)
+{
+	if ((hotkey_source_mask & hotkey_mask) != 0 &&
+	    hotkey_poll_freq > 0 &&
+	    (tpacpi_inputdev->users > 0 || hotkey_report_mode < 2)) {
+		if (!tpacpi_hotkey_task) {
+			tpacpi_hotkey_task = kthread_run(hotkey_kthread,
+			                       NULL, IBM_FILE "d");
+			if (IS_ERR(tpacpi_hotkey_task)) {
+				tpacpi_hotkey_task = NULL;
+				printk(IBM_ERR "could not create kernel thread "
+				       "for hotkey polling\n");
+			}
+		}
+	} else {
+		hotkey_poll_stop_sync();
+		if (may_warn &&
+		    hotkey_source_mask != 0 && hotkey_poll_freq == 0) {
+			printk(IBM_NOTICE "hot keys 0x%08x require polling, "
+				"which is currently disabled\n",
+				hotkey_source_mask);
+		}
+	}
+}
+
+static void hotkey_poll_setup_safe(int may_warn)
+{
+	mutex_lock(&hotkey_mutex);
+	hotkey_poll_setup(may_warn);
+	mutex_unlock(&hotkey_mutex);
+}
+
+static int hotkey_inputdev_open(struct input_dev *dev)
+{
+	switch (tpacpi_lifecycle) {
+	case TPACPI_LIFE_INIT:
+		/*
+		 * hotkey_init will call hotkey_poll_setup_safe
+		 * at the appropriate moment
+		 */
+		return 0;
+	case TPACPI_LIFE_EXITING:
+		return -EBUSY;
+	case TPACPI_LIFE_RUNNING:
+		hotkey_poll_setup_safe(0);
+		return 0;
+	}
+
+	/* Should only happen if tpacpi_lifecycle is corrupt */
+	BUG();
+	return -EBUSY;
+}
+
+static void hotkey_inputdev_close(struct input_dev *dev)
+{
+	/* disable hotkey polling when possible */
+	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING)
+		hotkey_poll_setup_safe(0);
+}
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -955,6 +1305,11 @@ static ssize_t hotkey_mask_store(struct device *dev,
 		return -ERESTARTSYS;
 
 	res = hotkey_mask_set(t);
+
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	hotkey_poll_setup(1);
+#endif
+
 	mutex_unlock(&hotkey_mutex);
 
 	return (res) ? res : count;
@@ -991,7 +1346,8 @@ static ssize_t hotkey_all_mask_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_all_mask);
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
+				hotkey_all_mask | hotkey_source_mask);
 }
 
 static struct device_attribute dev_attr_hotkey_all_mask =
@@ -1003,13 +1359,86 @@ static ssize_t hotkey_recommended_mask_show(struct device *dev,
 					    char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "0x%08x\n",
-			hotkey_all_mask & ~hotkey_reserved_mask);
+			(hotkey_all_mask | hotkey_source_mask)
+			& ~hotkey_reserved_mask);
 }
 
 static struct device_attribute dev_attr_hotkey_recommended_mask =
 	__ATTR(hotkey_recommended_mask, S_IRUGO,
 		hotkey_recommended_mask_show, NULL);
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+
+/* sysfs hotkey hotkey_source_mask ------------------------------------- */
+static ssize_t hotkey_source_mask_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_source_mask);
+}
+
+static ssize_t hotkey_source_mask_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 0xffffffffUL, &t) ||
+		((t & ~TPACPI_HKEY_NVRAM_KNOWN_MASK) != 0))
+		return -EINVAL;
+
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
+
+	HOTKEY_CONFIG_CRITICAL_START
+	hotkey_source_mask = t;
+	HOTKEY_CONFIG_CRITICAL_END
+
+	hotkey_poll_setup(1);
+
+	mutex_unlock(&hotkey_mutex);
+
+	return count;
+}
+
+static struct device_attribute dev_attr_hotkey_source_mask =
+	__ATTR(hotkey_source_mask, S_IWUSR | S_IRUGO,
+		hotkey_source_mask_show, hotkey_source_mask_store);
+
+/* sysfs hotkey hotkey_poll_freq --------------------------------------- */
+static ssize_t hotkey_poll_freq_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", hotkey_poll_freq);
+}
+
+static ssize_t hotkey_poll_freq_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long t;
+
+	if (parse_strtoul(buf, 25, &t))
+		return -EINVAL;
+
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
+
+	hotkey_poll_freq = t;
+
+	hotkey_poll_setup(1);
+	mutex_unlock(&hotkey_mutex);
+
+	return count;
+}
+
+static struct device_attribute dev_attr_hotkey_poll_freq =
+	__ATTR(hotkey_poll_freq, S_IWUSR | S_IRUGO,
+		hotkey_poll_freq_show, hotkey_poll_freq_store);
+
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 /* sysfs hotkey radio_sw ----------------------------------------------- */
 static ssize_t hotkey_radio_sw_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -1042,15 +1471,24 @@ static struct device_attribute dev_attr_hotkey_report_mode =
 
 static struct attribute *hotkey_attributes[] __initdata = {
 	&dev_attr_hotkey_enable.attr,
+	&dev_attr_hotkey_bios_enabled.attr,
 	&dev_attr_hotkey_report_mode.attr,
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	&dev_attr_hotkey_mask.attr,
+	&dev_attr_hotkey_all_mask.attr,
+	&dev_attr_hotkey_recommended_mask.attr,
+	&dev_attr_hotkey_source_mask.attr,
+	&dev_attr_hotkey_poll_freq.attr,
+#endif
 };
 
 static struct attribute *hotkey_mask_attributes[] __initdata = {
-	&dev_attr_hotkey_mask.attr,
-	&dev_attr_hotkey_bios_enabled.attr,
 	&dev_attr_hotkey_bios_mask.attr,
+#ifndef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	&dev_attr_hotkey_mask.attr,
 	&dev_attr_hotkey_all_mask.attr,
 	&dev_attr_hotkey_recommended_mask.attr,
+#endif
 };
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
@@ -1172,10 +1610,17 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
 	BUG_ON(!tpacpi_inputdev);
+	BUG_ON(tpacpi_inputdev->open != NULL ||
+	       tpacpi_inputdev->close != NULL);
 
 	IBM_ACPIHANDLE_INIT(hkey);
 	mutex_init(&hotkey_mutex);
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	mutex_init(&hotkey_thread_mutex);
+	mutex_init(&hotkey_thread_data_mutex);
+#endif
+
 	/* hotkey not supported on 570 */
 	tp_features.hotkey = hkey_handle != NULL;
 
@@ -1183,7 +1628,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		str_supported(tp_features.hotkey));
 
 	if (tp_features.hotkey) {
-		hotkey_dev_attributes = create_attr_set(8, NULL);
+		hotkey_dev_attributes = create_attr_set(10, NULL);
 		if (!hotkey_dev_attributes)
 			return -ENOMEM;
 		res = add_many_to_attr_set(hotkey_dev_attributes,
@@ -1205,7 +1650,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				/*
 				 * MHKV 0x100 in A31, R40, R40e,
 				 * T4x, X31, and later
-				 * */
+				 */
 				tp_features.hotkey_mask = 1;
 			}
 		}
@@ -1224,6 +1669,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			}
 		}
 
+		/* hotkey_source_mask *must* be zero for
+		 * the first hotkey_mask_get */
 		res = hotkey_status_get(&hotkey_orig_status);
 		if (!res && tp_features.hotkey_mask) {
 			res = hotkey_mask_get();
@@ -1236,6 +1683,19 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			}
 		}
 
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+		if (tp_features.hotkey_mask) {
+			hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK
+						& ~hotkey_all_mask;
+		} else {
+			hotkey_source_mask = TPACPI_HKEY_NVRAM_GOOD_MASK;
+		}
+
+		vdbg_printk(TPACPI_DBG_INIT,
+			    "hotkey source mask 0x%08x, polling freq %d\n",
+			    hotkey_source_mask, hotkey_poll_freq);
+#endif
+
 		/* Not all thinkpads have a hardware radio switch */
 		if (!res && acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
 			tp_features.hotkey_wlsw = 1;
@@ -1300,15 +1760,23 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		res = hotkey_status_set(1);
 		if (res)
 			return res;
-		res = hotkey_mask_set((hotkey_all_mask & ~hotkey_reserved_mask)
+		res = hotkey_mask_set(((hotkey_all_mask | hotkey_source_mask)
+					& ~hotkey_reserved_mask)
 					| hotkey_orig_mask);
-		if (res)
+		if (res < 0 && res != -ENXIO)
 			return res;
 
 		dbg_printk(TPACPI_DBG_INIT,
 				"legacy hot key reporting over procfs %s\n",
 				(hotkey_report_mode < 2) ?
 					"enabled" : "disabled");
+
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+		tpacpi_inputdev->open = &hotkey_inputdev_open;
+		tpacpi_inputdev->close = &hotkey_inputdev_close;
+
+		hotkey_poll_setup_safe(1);
+#endif
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -1316,6 +1784,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 static void hotkey_exit(void)
 {
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	hotkey_poll_stop_sync();
+#endif
+
 	if (tp_features.hotkey) {
 		dbg_printk(TPACPI_DBG_EXIT, "restoring original hot key mask\n");
 		/* no short-circuit boolean operator below! */
@@ -1366,7 +1838,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			scancode = hkey & 0xfff;
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
-				tpacpi_input_send_key(scancode);
+				if (!(hotkey_source_mask & (1 << scancode))) {
+					tpacpi_input_send_key(scancode);
+				} else {
+					ignore_acpi_ev = 1;
+				}
 			} else {
 				printk(IBM_ERR
 				       "hotkey 0x%04x out of range for keyboard map\n",
@@ -1422,6 +1898,9 @@ static void hotkey_resume(void)
 	if (hotkey_mask_get())
 		printk(IBM_ERR "error while trying to read hot key mask from firmware\n");
 	tpacpi_input_send_radiosw();
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
+	hotkey_poll_setup_safe(0);
+#endif
 }
 
 /* procfs -------------------------------------------------------------- */
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 3b03134..582184d 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -31,6 +31,9 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+#include <linux/delay.h>
 
 #include <linux/nvram.h>
 #include <linux/proc_fs.h>
@@ -82,10 +85,31 @@
 #define TP_CMOS_BRIGHTNESS_UP	4
 #define TP_CMOS_BRIGHTNESS_DOWN	5
 
-/* ThinkPad CMOS NVRAM constants */
-#define TP_NVRAM_ADDR_BRIGHTNESS       0x5e
-#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x0f
-#define TP_NVRAM_POS_LEVEL_BRIGHTNESS 0
+/* NVRAM Addresses */
+enum tp_nvram_addr {
+	TP_NVRAM_ADDR_HK2		= 0x57,
+	TP_NVRAM_ADDR_THINKLIGHT	= 0x58,
+	TP_NVRAM_ADDR_VIDEO		= 0x59,
+	TP_NVRAM_ADDR_BRIGHTNESS	= 0x5e,
+	TP_NVRAM_ADDR_MIXER		= 0x60,
+};
+
+/* NVRAM bit masks */
+enum {
+	TP_NVRAM_MASK_HKT_THINKPAD	= 0x08,
+	TP_NVRAM_MASK_HKT_ZOOM		= 0x20,
+	TP_NVRAM_MASK_HKT_DISPLAY	= 0x40,
+	TP_NVRAM_MASK_HKT_HIBERNATE	= 0x80,
+	TP_NVRAM_MASK_THINKLIGHT	= 0x10,
+	TP_NVRAM_MASK_HKT_DISPEXPND	= 0x30,
+	TP_NVRAM_MASK_HKT_BRIGHTNESS	= 0x20,
+	TP_NVRAM_MASK_LEVEL_BRIGHTNESS	= 0x0f,
+	TP_NVRAM_POS_LEVEL_BRIGHTNESS	= 0,
+	TP_NVRAM_MASK_MUTE		= 0x40,
+	TP_NVRAM_MASK_HKT_VOLUME	= 0x80,
+	TP_NVRAM_MASK_LEVEL_VOLUME	= 0x0f,
+	TP_NVRAM_POS_LEVEL_VOLUME	= 0,
+};
 
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -255,6 +279,7 @@ static struct {
 	u32 sensors_pdrv_registered:1;
 	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
+	u32 hotkey_poll_active:1;
 } tp_features;
 
 struct thinkpad_id_data {
@@ -454,6 +479,33 @@ static int fan_write_cmd_watchdog(const char *cmd, int *rc);
  * Hotkey subdriver
  */
 
+enum {	/* hot key scan codes (derived from ACPI DSDT) */
+	TP_ACPI_HOTKEYSCAN_FNF1		= 0,
+	TP_ACPI_HOTKEYSCAN_FNF2,
+	TP_ACPI_HOTKEYSCAN_FNF3,
+	TP_ACPI_HOTKEYSCAN_FNF4,
+	TP_ACPI_HOTKEYSCAN_FNF5,
+	TP_ACPI_HOTKEYSCAN_FNF6,
+	TP_ACPI_HOTKEYSCAN_FNF7,
+	TP_ACPI_HOTKEYSCAN_FNF8,
+	TP_ACPI_HOTKEYSCAN_FNF9,
+	TP_ACPI_HOTKEYSCAN_FNF10,
+	TP_ACPI_HOTKEYSCAN_FNF11,
+	TP_ACPI_HOTKEYSCAN_FNF12,
+	TP_ACPI_HOTKEYSCAN_FNBACKSPACE,
+	TP_ACPI_HOTKEYSCAN_FNINSERT,
+	TP_ACPI_HOTKEYSCAN_FNDELETE,
+	TP_ACPI_HOTKEYSCAN_FNHOME,
+	TP_ACPI_HOTKEYSCAN_FNEND,
+	TP_ACPI_HOTKEYSCAN_FNPAGEUP,
+	TP_ACPI_HOTKEYSCAN_FNPAGEDOWN,
+	TP_ACPI_HOTKEYSCAN_FNSPACE,
+	TP_ACPI_HOTKEYSCAN_VOLUMEUP,
+	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
+	TP_ACPI_HOTKEYSCAN_MUTE,
+	TP_ACPI_HOTKEYSCAN_THINKPAD,
+};
+
 static int hotkey_orig_status;
 static u32 hotkey_orig_mask;
 
-- 
1.5.4.23.gef5b9

