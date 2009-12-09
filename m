From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/4] thinkpad-acpi: volume subdriver rewrite
Date: Tue,  8 Dec 2009 23:48:19 -0200
Message-ID: <1260323302-6040-2-git-send-email-hmh@hmh.eng.br>
References: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39077 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756426AbZLIBsb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:48:31 -0500
In-Reply-To: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lorne Applebaum <lorne.applebaum@gmail.com>, Matthew Garrett <mjg@redhat.com>

I don't trust the coupled EC writes and SMI calls the current volume
control code does very much, although it is exactly what the IBM DSDTs
seem to do (they never do more than a single step though).

Change the driver to stop issuing SMIs, and just drive the EC directly
to the desired level (DSDTs seem to confirm this will work even on
very old models like the 570 and 600e/x).

We checkpoint directly to NVRAM (this can be turned off) at
suspend/shutdown/driver unload, which from what I can see in tbp,
should also work on every ThinkPad.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lorne Applebaum <lorne.applebaum@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   22 ++-
 drivers/platform/x86/thinkpad_acpi.c    |  340 +++++++++++++++++++++++++------
 2 files changed, 299 insertions(+), 63 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index f5056c7..96687d0 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1092,22 +1092,33 @@ WARNING:
     its level up and down at every change.
 
 
-Volume control -- /proc/acpi/ibm/volume
----------------------------------------
+Volume control
+--------------
+
+procfs: /proc/acpi/ibm/volume
 
-This feature allows volume control on ThinkPad models which don't have
-a hardware volume knob. The available commands are:
+This feature allows volume control on ThinkPad models with a digital
+volume knob, as well as mute/unmute control.  The available commands are:
 
 	echo up   >/proc/acpi/ibm/volume
 	echo down >/proc/acpi/ibm/volume
 	echo mute >/proc/acpi/ibm/volume
 	echo 'level <level>' >/proc/acpi/ibm/volume
 
-The <level> number range is 0 to 15 although not all of them may be
+The <level> number range is 0 to 14 although not all of them may be
 distinct. The unmute the volume after the mute command, use either the
 up or down command (the level command will not unmute the volume).
 The current volume level and mute state is shown in the file.
 
+There are two strategies for volume control.  To select which one
+should be used, use the volume_mode module parameter: volume_mode=1
+selects EC mode, and volume_mode=3 selects EC mode with NVRAM backing
+(so that volume/mute changes are remembered across shutdown/reboot).
+
+The driver will operate in volume_mode=3 by default. If that does not
+work well on your ThinkPad model, please report this to
+ibm-acpi-devel@lists.sourceforge.net.
+
 The ALSA mixer interface to this feature is still missing, but patches
 to add it exist.  That problem should be addressed in the not so
 distant future.
@@ -1376,6 +1387,7 @@ to enable more than one output class, just add their values.
 	0x0008			HKEY event interface, hotkeys
 	0x0010			Fan control
 	0x0020			Backlight brightness
+	0x0040			Audio mixer/volume control
 
 There is also a kernel build option to enable more debugging
 information, which may be necessary to debug driver problems.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e7ff6c7..c7400b4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -231,6 +231,7 @@ enum tpacpi_hkey_event_t {
 #define TPACPI_DBG_HKEY		0x0008
 #define TPACPI_DBG_FAN		0x0010
 #define TPACPI_DBG_BRGHT	0x0020
+#define TPACPI_DBG_MIXER	0x0040
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -6370,21 +6371,260 @@ static struct ibm_struct brightness_driver_data = {
  * Volume subdriver
  */
 
-static int volume_offset = 0x30;
+/*
+ * IBM ThinkPads have a simple volume controller with MUTE gating.
+ * Very early Lenovo ThinkPads follow the IBM ThinkPad spec.
+ *
+ * Since the *61 series (and probably also the later *60 series), Lenovo
+ * ThinkPads only implement the MUTE gate.
+ *
+ * EC register 0x30
+ *   Bit 6: MUTE (1 mutes sound)
+ *   Bit 3-0: Volume
+ *   Other bits should be zero as far as we know.
+ *
+ * This is also stored in CMOS NVRAM, byte 0x60, bit 6 (MUTE), and
+ * bits 3-0 (volume).  Other bits in NVRAM may have other functions,
+ * such as bit 7 which is used to detect repeated presses of MUTE,
+ * and we leave them unchanged.
+ */
+
+enum {
+	TP_EC_AUDIO = 0x30,
+
+	/* TP_EC_AUDIO bits */
+	TP_EC_AUDIO_MUTESW = 6,
+
+	/* TP_EC_AUDIO bitmasks */
+	TP_EC_AUDIO_LVL_MSK = 0x0F,
+	TP_EC_AUDIO_MUTESW_MSK = (1 << TP_EC_AUDIO_MUTESW),
+
+	/* Maximum volume */
+	TP_EC_VOLUME_MAX = 14,
+};
+
+enum tpacpi_volume_access_mode {
+	TPACPI_VOL_MODE_AUTO = 0,	/* Not implemented yet */
+	TPACPI_VOL_MODE_EC,		/* Pure EC control */
+	TPACPI_VOL_MODE_UCMS_STEP,	/* UCMS step-based control: N/A */
+	TPACPI_VOL_MODE_ECNVRAM,	/* EC control w/ NVRAM store */
+	TPACPI_VOL_MODE_MAX
+};
+
+static enum tpacpi_volume_access_mode volume_mode =
+	TPACPI_VOL_MODE_MAX;
+
+
+/*
+ * Used to syncronize writers to TP_EC_AUDIO and
+ * TP_NVRAM_ADDR_MIXER, as we need to do read-modify-write
+ */
+static struct mutex volume_mutex;
+
+static void tpacpi_volume_checkpoint_nvram(void)
+{
+	u8 lec = 0;
+	u8 b_nvram;
+	const u8 ec_mask = TP_EC_AUDIO_LVL_MSK | TP_EC_AUDIO_MUTESW_MSK;
+
+	if (volume_mode != TPACPI_VOL_MODE_ECNVRAM)
+		return;
+
+	vdbg_printk(TPACPI_DBG_MIXER,
+		"trying to checkpoint mixer state to NVRAM...\n");
+
+	if (mutex_lock_killable(&volume_mutex) < 0)
+		return;
+
+	if (unlikely(!acpi_ec_read(TP_EC_AUDIO, &lec)))
+		goto unlock;
+	lec &= ec_mask;
+	b_nvram = nvram_read_byte(TP_NVRAM_ADDR_MIXER);
+
+	if (lec != (b_nvram & ec_mask)) {
+		/* NVRAM needs update */
+		b_nvram &= ~ec_mask;
+		b_nvram |= lec;
+		nvram_write_byte(b_nvram, TP_NVRAM_ADDR_MIXER);
+		dbg_printk(TPACPI_DBG_MIXER,
+			   "updated NVRAM mixer status to 0x%02x (0x%02x)\n",
+			   (unsigned int) lec, (unsigned int) b_nvram);
+	} else {
+		vdbg_printk(TPACPI_DBG_MIXER,
+			   "NVRAM mixer status already is 0x%02x (0x%02x)\n",
+			   (unsigned int) lec, (unsigned int) b_nvram);
+	}
+
+unlock:
+	mutex_unlock(&volume_mutex);
+}
+
+static int volume_get_status_ec(u8 *status)
+{
+	u8 s;
+
+	if (!acpi_ec_read(TP_EC_AUDIO, &s))
+		return -EIO;
+
+	*status = s;
+
+	dbg_printk(TPACPI_DBG_MIXER, "status 0x%02x\n", s);
+
+	return 0;
+}
+
+static int volume_get_status(u8 *status)
+{
+	return volume_get_status_ec(status);
+}
+
+static int volume_set_status_ec(const u8 status)
+{
+	if (!acpi_ec_write(TP_EC_AUDIO, status))
+		return -EIO;
+
+	dbg_printk(TPACPI_DBG_MIXER, "set EC mixer to 0x%02x\n", status);
+
+	return 0;
+}
+
+static int volume_set_status(const u8 status)
+{
+	return volume_set_status_ec(status);
+}
+
+static int volume_set_mute_ec(const bool mute)
+{
+	int rc;
+	u8 s, n;
+
+	if (mutex_lock_killable(&volume_mutex) < 0)
+		return -EINTR;
+
+	rc = volume_get_status_ec(&s);
+	if (rc)
+		goto unlock;
+
+	n = (mute) ? s | TP_EC_AUDIO_MUTESW_MSK :
+		     s & ~TP_EC_AUDIO_MUTESW_MSK;
+
+	if (n != s)
+		rc = volume_set_status_ec(n);
+
+unlock:
+	mutex_unlock(&volume_mutex);
+	return rc;
+}
+
+static int volume_set_mute(const bool mute)
+{
+	dbg_printk(TPACPI_DBG_MIXER, "trying to %smute\n",
+		   (mute) ? "" : "un");
+	return volume_set_mute_ec(mute);
+}
+
+static int volume_set_volume_ec(const u8 vol)
+{
+	int rc;
+	u8 s, n;
+
+	if (vol > TP_EC_VOLUME_MAX)
+		return -EINVAL;
+
+	if (mutex_lock_killable(&volume_mutex) < 0)
+		return -EINTR;
+
+	rc = volume_get_status_ec(&s);
+	if (rc)
+		goto unlock;
+
+	n = (s & ~TP_EC_AUDIO_LVL_MSK) | vol;
+
+	if (n != s)
+		rc = volume_set_status_ec(n);
+
+unlock:
+	mutex_unlock(&volume_mutex);
+	return rc;
+}
+
+static int volume_set_volume(const u8 vol)
+{
+	dbg_printk(TPACPI_DBG_MIXER,
+		   "trying to set volume level to %hu\n", vol);
+	return volume_set_volume_ec(vol);
+}
+
+static void volume_suspend(pm_message_t state)
+{
+	tpacpi_volume_checkpoint_nvram();
+}
+
+static void volume_shutdown(void)
+{
+	tpacpi_volume_checkpoint_nvram();
+}
+
+static void volume_exit(void)
+{
+	tpacpi_volume_checkpoint_nvram();
+}
+
+static int __init volume_init(struct ibm_init_struct *iibm)
+{
+	vdbg_printk(TPACPI_DBG_INIT, "initializing volume subdriver\n");
+
+	mutex_init(&volume_mutex);
+
+	/*
+	 * Check for module parameter bogosity, note that we
+	 * init volume_mode to TPACPI_VOL_MODE_MAX in order to be
+	 * able to detect "unspecified"
+	 */
+	if (volume_mode > TPACPI_VOL_MODE_MAX)
+		return -EINVAL;
+
+	if (volume_mode == TPACPI_VOL_MODE_UCMS_STEP) {
+		printk(TPACPI_ERR
+			"UCMS step volume mode not implemented, "
+			"please contact %s\n", TPACPI_MAIL);
+		return 1;
+	}
+
+	if (volume_mode == TPACPI_VOL_MODE_AUTO ||
+	    volume_mode == TPACPI_VOL_MODE_MAX) {
+		volume_mode = TPACPI_VOL_MODE_ECNVRAM;
+
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+				"driver auto-selected volume_mode=%d\n",
+				volume_mode);
+	} else {
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+				"using user-supplied volume_mode=%d\n",
+				volume_mode);
+	}
+
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+			"volume is supported\n");
+
+	return 0;
+}
 
 static int volume_read(char *p)
 {
 	int len = 0;
-	u8 level;
+	u8 status;
 
-	if (!acpi_ec_read(volume_offset, &level)) {
+	if (volume_get_status(&status) < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
-		len += sprintf(p + len, "level:\t\t%d\n", level & 0xf);
-		len += sprintf(p + len, "mute:\t\t%s\n", onoff(level, 6));
+		len += sprintf(p + len, "level:\t\t%d\n",
+				status & TP_EC_AUDIO_LVL_MSK);
+		len += sprintf(p + len, "mute:\t\t%s\n",
+				onoff(status, TP_EC_AUDIO_MUTESW));
 		len += sprintf(p + len, "commands:\tup, down, mute\n");
 		len += sprintf(p + len, "commands:\tlevel <level>"
-			       " (<level> is 0-15)\n");
+			       " (<level> is 0-%d)\n", TP_EC_VOLUME_MAX);
 	}
 
 	return len;
@@ -6392,77 +6632,55 @@ static int volume_read(char *p)
 
 static int volume_write(char *buf)
 {
-	int cmos_cmd, inc, i;
-	u8 level, mute;
-	int new_level, new_mute;
+	u8 s;
+	u8 new_level, new_mute;
+	int l;
 	char *cmd;
+	int rc;
 
-	while ((cmd = next_cmd(&buf))) {
-		if (!acpi_ec_read(volume_offset, &level))
-			return -EIO;
-		new_mute = mute = level & 0x40;
-		new_level = level = level & 0xf;
+	rc = volume_get_status(&s);
+	if (rc < 0)
+		return rc;
 
+	new_level = s & TP_EC_AUDIO_LVL_MSK;
+	new_mute  = s & TP_EC_AUDIO_MUTESW_MSK;
+
+	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "up") == 0) {
-			if (mute)
+			if (new_mute)
 				new_mute = 0;
-			else
-				new_level = level == 15 ? 15 : level + 1;
+			else if (new_level < TP_EC_VOLUME_MAX)
+				new_level++;
 		} else if (strlencmp(cmd, "down") == 0) {
-			if (mute)
+			if (new_mute)
 				new_mute = 0;
-			else
-				new_level = level == 0 ? 0 : level - 1;
-		} else if (sscanf(cmd, "level %d", &new_level) == 1 &&
-			   new_level >= 0 && new_level <= 15) {
-			/* new_level set */
+			else if (new_level > 0)
+				new_level--;
+		} else if (sscanf(cmd, "level %u", &l) == 1 &&
+			   l >= 0 && l <= TP_EC_VOLUME_MAX) {
+				new_level = l;
 		} else if (strlencmp(cmd, "mute") == 0) {
-			new_mute = 0x40;
+			new_mute = TP_EC_AUDIO_MUTESW_MSK;
 		} else
 			return -EINVAL;
+	}
 
-		if (new_level != level) {
-			/* mute doesn't change */
-
-			cmos_cmd = (new_level > level) ?
-					TP_CMOS_VOLUME_UP : TP_CMOS_VOLUME_DOWN;
-			inc = new_level > level ? 1 : -1;
-
-			if (mute && (issue_thinkpad_cmos_command(cmos_cmd) ||
-				     !acpi_ec_write(volume_offset, level)))
-				return -EIO;
-
-			for (i = level; i != new_level; i += inc)
-				if (issue_thinkpad_cmos_command(cmos_cmd) ||
-				    !acpi_ec_write(volume_offset, i + inc))
-					return -EIO;
-
-			if (mute &&
-			    (issue_thinkpad_cmos_command(TP_CMOS_VOLUME_MUTE) ||
-			     !acpi_ec_write(volume_offset, new_level + mute))) {
-				return -EIO;
-			}
-		}
-
-		if (new_mute != mute) {
-			/* level doesn't change */
+	tpacpi_disclose_usertask("procfs volume",
+				"%smute and set level to %d\n",
+				new_mute ? "" : "un", new_level);
 
-			cmos_cmd = (new_mute) ?
-				   TP_CMOS_VOLUME_MUTE : TP_CMOS_VOLUME_UP;
+	rc = volume_set_status(new_mute | new_level);
 
-			if (issue_thinkpad_cmos_command(cmos_cmd) ||
-			    !acpi_ec_write(volume_offset, level + new_mute))
-				return -EIO;
-		}
-	}
-
-	return 0;
+	return (rc == -EINTR) ? -ERESTARTSYS : rc;
 }
 
 static struct ibm_struct volume_driver_data = {
 	.name = "volume",
 	.read = volume_read,
 	.write = volume_write,
+	.exit = volume_exit,
+	.suspend = volume_suspend,
+	.shutdown = volume_shutdown,
 };
 
 /*************************************************************************
@@ -8116,6 +8334,7 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.data = &brightness_driver_data,
 	},
 	{
+		.init = volume_init,
 		.data = &volume_driver_data,
 	},
 	{
@@ -8181,6 +8400,11 @@ MODULE_PARM_DESC(hotkey_report_mode,
 		 "used for backwards compatibility with userspace, "
 		 "see documentation");
 
+module_param_named(volume_mode, volume_mode, uint, 0444);
+MODULE_PARM_DESC(volume_mode,
+		 "Selects volume control strategy: "
+		 "0=auto, 1=EC, 2=N/A, 3=EC+NVRAM");
+
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-acpi procfs command " \
-- 
1.6.5.4

