From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/4] thinkpad-acpi: support MUTE-only ThinkPads
Date: Tue,  8 Dec 2009 23:48:20 -0200
Message-ID: <1260323302-6040-3-git-send-email-hmh@hmh.eng.br>
References: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53456 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756185AbZLIBsa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:48:30 -0500
In-Reply-To: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lorne Applebaum <lorne.applebaum@gmail.com>, Matthew Garrett <mjg@redhat.com>

Lenovo removed the extra mixer since the T61 and thereabouts.
Newer Lenovo models only have the mute gate function, and leave
the volume control to the HDA mixer.

Until a way to automatically query the firmware about its audio
control capabilities is discovered (there might not be any), use a
white/black list.

We will likely need to ask T60 (old and new model) and Z60/Z61 users
whether they have volume control to populate the black/white list.
Meanwhile, provide a volume_capabilities parameter that can be used to
override the defaults.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lorne Applebaum <lorne.applebaum@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   19 ++++-
 drivers/platform/x86/thinkpad_acpi.c    |  159 +++++++++++++++++++++++++-----
 2 files changed, 149 insertions(+), 29 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 96687d0..bd87682 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1098,18 +1098,31 @@ Volume control
 procfs: /proc/acpi/ibm/volume
 
 This feature allows volume control on ThinkPad models with a digital
-volume knob, as well as mute/unmute control.  The available commands are:
+volume knob (when available, not all models have it), as well as
+mute/unmute control.  The available commands are:
 
 	echo up   >/proc/acpi/ibm/volume
 	echo down >/proc/acpi/ibm/volume
 	echo mute >/proc/acpi/ibm/volume
+	echo unmute >/proc/acpi/ibm/volume
 	echo 'level <level>' >/proc/acpi/ibm/volume
 
 The <level> number range is 0 to 14 although not all of them may be
 distinct. The unmute the volume after the mute command, use either the
-up or down command (the level command will not unmute the volume).
+up or down command (the level command will not unmute the volume), or
+the unmute command.
+
 The current volume level and mute state is shown in the file.
 
+You can use the volume_capabilities parameter to tell the driver
+whether your thinkpad has volume control or mute-only control:
+volume_capabilities=1 for mixers with mute and volume control,
+volume_capabilities=2 for mixers with only mute control.
+
+If the driver misdetects the capabilities for your ThinkPad model,
+please report this to ibm-acpi-devel@lists.sourceforge.net, so that we
+can update the driver.
+
 There are two strategies for volume control.  To select which one
 should be used, use the volume_mode module parameter: volume_mode=1
 selects EC mode, and volume_mode=3 selects EC mode with NVRAM backing
@@ -1450,3 +1463,5 @@ Sysfs interface changelog:
 		is deprecated and marked for removal.
 
 0x020600:	Marker for backlight change event support.
+
+0x020700:	Support for mute-only mixers.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c7400b4..1b7e7f8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define TPACPI_VERSION "0.23"
-#define TPACPI_SYSFS_VERSION 0x020600
+#define TPACPI_SYSFS_VERSION 0x020700
 
 /*
  *  Changelog:
@@ -299,6 +299,7 @@ static struct {
 	u32 fan_ctrl_status_undef:1;
 	u32 second_fan:1;
 	u32 beep_needs_two_args:1;
+	u32 mixer_no_level_control:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
 	u32 platform_drv_attrs_registered:1;
@@ -426,6 +427,12 @@ static void tpacpi_log_usertask(const char * const what)
 	  .ec = TPACPI_MATCH_ANY,		\
 	  .quirks = (__quirk) }
 
+#define TPACPI_QEC_LNV(__id1, __id2, __quirk)	\
+	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
+	  .bios = TPACPI_MATCH_ANY,		\
+	  .ec = TPID(__id1, __id2),		\
+	  .quirks = (__quirk) }
+
 struct tpacpi_quirk {
 	unsigned int vendor;
 	u16 bios;
@@ -6411,9 +6418,17 @@ enum tpacpi_volume_access_mode {
 	TPACPI_VOL_MODE_MAX
 };
 
+enum tpacpi_volume_capabilities {
+	TPACPI_VOL_CAP_AUTO = 0,	/* Use white/blacklist */
+	TPACPI_VOL_CAP_VOLMUTE,		/* Output vol and mute */
+	TPACPI_VOL_CAP_MUTEONLY,	/* Output mute only */
+	TPACPI_VOL_CAP_MAX
+};
+
 static enum tpacpi_volume_access_mode volume_mode =
 	TPACPI_VOL_MODE_MAX;
 
+static enum tpacpi_volume_capabilities volume_capabilities;
 
 /*
  * Used to syncronize writers to TP_EC_AUDIO and
@@ -6425,7 +6440,7 @@ static void tpacpi_volume_checkpoint_nvram(void)
 {
 	u8 lec = 0;
 	u8 b_nvram;
-	const u8 ec_mask = TP_EC_AUDIO_LVL_MSK | TP_EC_AUDIO_MUTESW_MSK;
+	u8 ec_mask;
 
 	if (volume_mode != TPACPI_VOL_MODE_ECNVRAM)
 		return;
@@ -6433,6 +6448,11 @@ static void tpacpi_volume_checkpoint_nvram(void)
 	vdbg_printk(TPACPI_DBG_MIXER,
 		"trying to checkpoint mixer state to NVRAM...\n");
 
+	if (tp_features.mixer_no_level_control)
+		ec_mask = TP_EC_AUDIO_MUTESW_MSK;
+	else
+		ec_mask = TP_EC_AUDIO_MUTESW_MSK | TP_EC_AUDIO_LVL_MSK;
+
 	if (mutex_lock_killable(&volume_mutex) < 0)
 		return;
 
@@ -6570,8 +6590,36 @@ static void volume_exit(void)
 	tpacpi_volume_checkpoint_nvram();
 }
 
+#define TPACPI_VOL_Q_MUTEONLY	0x0001	/* Mute-only control available */
+#define TPACPI_VOL_Q_LEVEL	0x0002  /* Volume control available */
+
+static const struct tpacpi_quirk volume_quirk_table[] __initconst = {
+	/* Whitelist volume level on all IBM by default */
+	{ .vendor = PCI_VENDOR_ID_IBM,
+	  .bios   = TPACPI_MATCH_ANY,
+	  .ec     = TPACPI_MATCH_ANY,
+	  .quirks = TPACPI_VOL_Q_LEVEL },
+
+	/* Lenovo models with volume control (needs confirmation) */
+	TPACPI_QEC_LNV('7', 'C', TPACPI_VOL_Q_LEVEL), /* R60/i */
+	TPACPI_QEC_LNV('7', 'E', TPACPI_VOL_Q_LEVEL), /* R60e/i */
+	TPACPI_QEC_LNV('7', '9', TPACPI_VOL_Q_LEVEL), /* T60/p */
+	TPACPI_QEC_LNV('7', 'B', TPACPI_VOL_Q_LEVEL), /* X60/s */
+	TPACPI_QEC_LNV('7', 'J', TPACPI_VOL_Q_LEVEL), /* X60t */
+	TPACPI_QEC_LNV('7', '7', TPACPI_VOL_Q_LEVEL), /* Z60 */
+	TPACPI_QEC_LNV('7', 'F', TPACPI_VOL_Q_LEVEL), /* Z61 */
+
+	/* Whitelist mute-only on all Lenovo by default */
+	{ .vendor = PCI_VENDOR_ID_LENOVO,
+	  .bios   = TPACPI_MATCH_ANY,
+	  .ec	  = TPACPI_MATCH_ANY,
+	  .quirks = TPACPI_VOL_Q_MUTEONLY }
+};
+
 static int __init volume_init(struct ibm_init_struct *iibm)
 {
+	unsigned long quirks;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing volume subdriver\n");
 
 	mutex_init(&volume_mutex);
@@ -6591,6 +6639,36 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 		return 1;
 	}
 
+	if (volume_capabilities >= TPACPI_VOL_CAP_MAX)
+		return -EINVAL;
+
+	quirks = tpacpi_check_quirks(volume_quirk_table,
+				     ARRAY_SIZE(volume_quirk_table));
+
+	switch (volume_capabilities) {
+	case TPACPI_VOL_CAP_AUTO:
+		if (quirks & TPACPI_VOL_Q_MUTEONLY)
+			tp_features.mixer_no_level_control = 1;
+		else if (quirks & TPACPI_VOL_Q_LEVEL)
+			tp_features.mixer_no_level_control = 0;
+		else
+			return 1; /* no mixer */
+		break;
+	case TPACPI_VOL_CAP_VOLMUTE:
+		tp_features.mixer_no_level_control = 0;
+		break;
+	case TPACPI_VOL_CAP_MUTEONLY:
+		tp_features.mixer_no_level_control = 1;
+		break;
+	default:
+		return 1;
+	}
+
+	if (volume_capabilities != TPACPI_VOL_CAP_AUTO)
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+				"using user-supplied volume_capabilities=%d\n",
+				volume_capabilities);
+
 	if (volume_mode == TPACPI_VOL_MODE_AUTO ||
 	    volume_mode == TPACPI_VOL_MODE_MAX) {
 		volume_mode = TPACPI_VOL_MODE_ECNVRAM;
@@ -6605,7 +6683,8 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 	}
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
-			"volume is supported\n");
+			"mute is supported, volume control is %s\n",
+			str_supported(!tp_features.mixer_no_level_control));
 
 	return 0;
 }
@@ -6618,13 +6697,21 @@ static int volume_read(char *p)
 	if (volume_get_status(&status) < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
-		len += sprintf(p + len, "level:\t\t%d\n",
-				status & TP_EC_AUDIO_LVL_MSK);
+		if (tp_features.mixer_no_level_control)
+			len += sprintf(p + len, "level:\t\tunsupported\n");
+		else
+			len += sprintf(p + len, "level:\t\t%d\n",
+					status & TP_EC_AUDIO_LVL_MSK);
+
 		len += sprintf(p + len, "mute:\t\t%s\n",
 				onoff(status, TP_EC_AUDIO_MUTESW));
-		len += sprintf(p + len, "commands:\tup, down, mute\n");
-		len += sprintf(p + len, "commands:\tlevel <level>"
+
+		len += sprintf(p + len, "commands:\tunmute, mute\n");
+		if (!tp_features.mixer_no_level_control) {
+			len += sprintf(p + len, "commands:\tup, down\n");
+			len += sprintf(p + len, "commands:\tlevel <level>"
 			       " (<level> is 0-%d)\n", TP_EC_VOLUME_MAX);
+		}
 	}
 
 	return len;
@@ -6646,30 +6733,43 @@ static int volume_write(char *buf)
 	new_mute  = s & TP_EC_AUDIO_MUTESW_MSK;
 
 	while ((cmd = next_cmd(&buf))) {
-		if (strlencmp(cmd, "up") == 0) {
-			if (new_mute)
-				new_mute = 0;
-			else if (new_level < TP_EC_VOLUME_MAX)
-				new_level++;
-		} else if (strlencmp(cmd, "down") == 0) {
-			if (new_mute)
-				new_mute = 0;
-			else if (new_level > 0)
-				new_level--;
-		} else if (sscanf(cmd, "level %u", &l) == 1 &&
-			   l >= 0 && l <= TP_EC_VOLUME_MAX) {
-				new_level = l;
-		} else if (strlencmp(cmd, "mute") == 0) {
+		if (!tp_features.mixer_no_level_control) {
+			if (strlencmp(cmd, "up") == 0) {
+				if (new_mute)
+					new_mute = 0;
+				else if (new_level < TP_EC_VOLUME_MAX)
+					new_level++;
+				continue;
+			} else if (strlencmp(cmd, "down") == 0) {
+				if (new_mute)
+					new_mute = 0;
+				else if (new_level > 0)
+					new_level--;
+				continue;
+			} else if (sscanf(cmd, "level %u", &l) == 1 &&
+				   l >= 0 && l <= TP_EC_VOLUME_MAX) {
+					new_level = l;
+				continue;
+			}
+		}
+		if (strlencmp(cmd, "mute") == 0)
 			new_mute = TP_EC_AUDIO_MUTESW_MSK;
-		} else
+		else if (strlencmp(cmd, "unmute") == 0)
+			new_mute = 0;
+		else
 			return -EINVAL;
 	}
 
-	tpacpi_disclose_usertask("procfs volume",
-				"%smute and set level to %d\n",
-				new_mute ? "" : "un", new_level);
-
-	rc = volume_set_status(new_mute | new_level);
+	if (tp_features.mixer_no_level_control) {
+		tpacpi_disclose_usertask("procfs volume", "%smute\n",
+					new_mute ? "" : "un");
+		rc = volume_set_mute(!!new_mute);
+	} else {
+		tpacpi_disclose_usertask("procfs volume",
+					"%smute and set level to %d\n",
+					new_mute ? "" : "un", new_level);
+		rc = volume_set_status(new_mute | new_level);
+	}
 
 	return (rc == -EINTR) ? -ERESTARTSYS : rc;
 }
@@ -8405,6 +8505,11 @@ MODULE_PARM_DESC(volume_mode,
 		 "Selects volume control strategy: "
 		 "0=auto, 1=EC, 2=N/A, 3=EC+NVRAM");
 
+module_param_named(volume_capabilities, volume_capabilities, uint, 0444);
+MODULE_PARM_DESC(volume_capabilities,
+		 "Selects the mixer capabilites: "
+		 "0=auto, 1=volume and mute, 2=mute only");
+
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-acpi procfs command " \
-- 
1.6.5.4

