From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/4] thinkpad-acpi: disable volume control
Date: Tue,  8 Dec 2009 23:48:21 -0200
Message-ID: <1260323302-6040-4-git-send-email-hmh@hmh.eng.br>
References: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33214 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836AbZLIBs3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:48:29 -0500
In-Reply-To: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lorne Applebaum <lorne.applebaum@gmail.com>, Matthew Garrett <mjg@redhat.com>

Disable volume control by default.  It can be enabled at module load
time by a module parameter (volume_control=1).

The audio control mixer that thinkpad-acpi interacts with is fully
functional without any drivers, and operated by hotkeys.

The idea behind the console audio control is that the human operator
is the only one that can interact with it.  The ThinkVantage suite in
Windows does not allow any software-based overrides, and only does OSD
(on-screen-display) functions.

The Linux driver will, with the addition of the ALSA interface, try to
follow and enforce the ThinkVantage UI design:

The user is supposed to use the keyboard hotkeys to interact with the
console audio control.  The kernel and the desktop environment is
supposed to cooperate to provide proper user feedback through
on-screen-display functions.

Distros are urged to not to enable volume control by default.
Enabling this must be a local admin's decision.  This is the reason
why there is no Kconfig option.

Keep in mind that all ThinkPads have a normal, main mixer (AC97 or
HDA) for regular software-based audio control.  We are not talking
about that mixer here.

Advanced users are, of course, free to enable volume control and do as
they please.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lorne Applebaum <lorne.applebaum@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   13 ++++++++
 drivers/platform/x86/thinkpad_acpi.c    |   47 +++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index bd87682..6a58143 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1097,6 +1097,18 @@ Volume control
 
 procfs: /proc/acpi/ibm/volume
 
+NOTE: by default, the volume control interface operates in read-only
+mode, as it is supposed to be used for on-screen-display purposes.
+The read/write mode can be enabled through the use of the
+"volume_control=1" module parameter.
+
+NOTE: distros are urged to not enable volume_control by default, this
+should be done by the local admin only.  The ThinkPad UI is for the
+console audio control to be done through the volume keys only, and for
+the desktop environment to just provide on-screen-display feedback.
+Software volume control should be done only in the main AC97/HDA
+mixer.
+
 This feature allows volume control on ThinkPad models with a digital
 volume knob (when available, not all models have it), as well as
 mute/unmute control.  The available commands are:
@@ -1465,3 +1477,4 @@ Sysfs interface changelog:
 0x020600:	Marker for backlight change event support.
 
 0x020700:	Support for mute-only mixers.
+		Volume control in read-only mode by default.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 1b7e7f8..c1b45d4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -311,6 +311,7 @@ static struct {
 
 static struct {
 	u16 hotkey_mask_ff:1;
+	u16 volume_ctrl_forbidden:1;
 } tp_warned;
 
 struct thinkpad_id_data {
@@ -6429,6 +6430,7 @@ static enum tpacpi_volume_access_mode volume_mode =
 	TPACPI_VOL_MODE_MAX;
 
 static enum tpacpi_volume_capabilities volume_capabilities;
+static int volume_control_allowed;
 
 /*
  * Used to syncronize writers to TP_EC_AUDIO and
@@ -6444,6 +6446,8 @@ static void tpacpi_volume_checkpoint_nvram(void)
 
 	if (volume_mode != TPACPI_VOL_MODE_ECNVRAM)
 		return;
+	if (!volume_control_allowed)
+		return;
 
 	vdbg_printk(TPACPI_DBG_MIXER,
 		"trying to checkpoint mixer state to NVRAM...\n");
@@ -6686,6 +6690,12 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 			"mute is supported, volume control is %s\n",
 			str_supported(!tp_features.mixer_no_level_control));
 
+	printk(TPACPI_INFO
+		"Console audio control enabled, mode: %s\n",
+		(volume_control_allowed) ?
+			"override (read/write)" :
+			"monitor (read only)");
+
 	return 0;
 }
 
@@ -6706,11 +6716,16 @@ static int volume_read(char *p)
 		len += sprintf(p + len, "mute:\t\t%s\n",
 				onoff(status, TP_EC_AUDIO_MUTESW));
 
-		len += sprintf(p + len, "commands:\tunmute, mute\n");
-		if (!tp_features.mixer_no_level_control) {
-			len += sprintf(p + len, "commands:\tup, down\n");
-			len += sprintf(p + len, "commands:\tlevel <level>"
-			       " (<level> is 0-%d)\n", TP_EC_VOLUME_MAX);
+		if (volume_control_allowed) {
+			len += sprintf(p + len, "commands:\tunmute, mute\n");
+			if (!tp_features.mixer_no_level_control) {
+				len += sprintf(p + len,
+					       "commands:\tup, down\n");
+				len += sprintf(p + len,
+					       "commands:\tlevel <level>"
+					       " (<level> is 0-%d)\n",
+					       TP_EC_VOLUME_MAX);
+			}
 		}
 	}
 
@@ -6725,6 +6740,23 @@ static int volume_write(char *buf)
 	char *cmd;
 	int rc;
 
+	/*
+	 * We do allow volume control at driver startup, so that the
+	 * user can set initial state through the volume=... parameter hack.
+	 */
+	if (!volume_control_allowed && tpacpi_lifecycle != TPACPI_LIFE_INIT) {
+		if (unlikely(!tp_warned.volume_ctrl_forbidden)) {
+			tp_warned.volume_ctrl_forbidden = 1;
+			printk(TPACPI_NOTICE
+				"Console audio control in monitor mode, "
+				"changes are not allowed.\n");
+			printk(TPACPI_NOTICE
+				"Use the volume_control=1 module parameter "
+				"to enable volume control\n");
+		}
+		return -EPERM;
+	}
+
 	rc = volume_get_status(&s);
 	if (rc < 0)
 		return rc;
@@ -8510,6 +8542,11 @@ MODULE_PARM_DESC(volume_capabilities,
 		 "Selects the mixer capabilites: "
 		 "0=auto, 1=volume and mute, 2=mute only");
 
+module_param_named(volume_control, volume_control_allowed, bool, 0444);
+MODULE_PARM_DESC(volume_control,
+		 "Enables software override for the console audio "
+		 "control when true");
+
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-acpi procfs command " \
-- 
1.6.5.4

