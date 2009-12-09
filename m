From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/4] thinkpad-acpi: basic ALSA mixer support
Date: Tue,  8 Dec 2009 23:48:22 -0200
Message-ID: <1260323302-6040-5-git-send-email-hmh@hmh.eng.br>
References: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57294 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756429AbZLIBsb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:48:31 -0500
In-Reply-To: <1260323302-6040-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lorne Applebaum <lorne.applebaum@gmail.com>, Matthew Garrett <mjg@redhat.com>

Add the basic ALSA mixer functionality.  The mixer is event-driven,
and will work fine on IBM ThinkPads.  I expect Lenovo ThinkPads will
cause some trouble with the event interface.

Heavily based on work by Lorne Applebaum <lorne.applebaum@gmail.com>
and ideas from Matthew Garrett <mjg@redhat.com>.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lorne Applebaum <lorne.applebaum@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    7 +-
 drivers/platform/x86/thinkpad_acpi.c    |  230 ++++++++++++++++++++++++++++++-
 2 files changed, 232 insertions(+), 5 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 6a58143..b4ed30c 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1096,6 +1096,7 @@ Volume control
 --------------
 
 procfs: /proc/acpi/ibm/volume
+ALSA: "ThinkPad Console Audio Control", default ID: "ThinkPadEC"
 
 NOTE: by default, the volume control interface operates in read-only
 mode, as it is supposed to be used for on-screen-display purposes.
@@ -1144,9 +1145,8 @@ The driver will operate in volume_mode=3 by default. If that does not
 work well on your ThinkPad model, please report this to
 ibm-acpi-devel@lists.sourceforge.net.
 
-The ALSA mixer interface to this feature is still missing, but patches
-to add it exist.  That problem should be addressed in the not so
-distant future.
+The driver supports the standard ALSA module parameters.  If the ALSA
+mixer is disabled, the driver will disable all volume functionality.
 
 
 Fan control and monitoring: fan speed, fan enable/disable
@@ -1478,3 +1478,4 @@ Sysfs interface changelog:
 
 0x020700:	Support for mute-only mixers.
 		Volume control in read-only mode by default.
+		Marker for ALSA mixer support.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c1b45d4..8fefcd7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -76,6 +76,10 @@
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+
 #include <acpi/acpi_drivers.h>
 
 #include <linux/pci_ids.h>
@@ -6397,6 +6401,22 @@ static struct ibm_struct brightness_driver_data = {
  * and we leave them unchanged.
  */
 
+#define TPACPI_ALSA_DRVNAME  "ThinkPad EC"
+#define TPACPI_ALSA_SHRTNAME "ThinkPad Console Audio Control"
+#define TPACPI_ALSA_MIXERNAME TPACPI_ALSA_SHRTNAME
+
+static int alsa_index = SNDRV_DEFAULT_IDX1;
+static char *alsa_id = "ThinkPadEC";
+static int alsa_enable = SNDRV_DEFAULT_ENABLE1;
+
+struct tpacpi_alsa_data {
+	struct snd_card *card;
+	struct snd_ctl_elem_id *ctl_mute_id;
+	struct snd_ctl_elem_id *ctl_vol_id;
+};
+
+static struct snd_card *alsa_card;
+
 enum {
 	TP_EC_AUDIO = 0x30,
 
@@ -6591,9 +6611,175 @@ static void volume_shutdown(void)
 
 static void volume_exit(void)
 {
+	if (alsa_card) {
+		snd_card_free(alsa_card);
+		alsa_card = NULL;
+	}
+
 	tpacpi_volume_checkpoint_nvram();
 }
 
+static void volume_alsa_notify_change(void)
+{
+	struct tpacpi_alsa_data *d;
+
+	if (alsa_card && alsa_card->private_data) {
+		d = alsa_card->private_data;
+		if (d->ctl_mute_id)
+			snd_ctl_notify(alsa_card,
+					SNDRV_CTL_EVENT_MASK_VALUE,
+					d->ctl_mute_id);
+		if (d->ctl_vol_id)
+			snd_ctl_notify(alsa_card,
+					SNDRV_CTL_EVENT_MASK_VALUE,
+					d->ctl_vol_id);
+	}
+}
+
+static int volume_alsa_vol_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = TP_EC_VOLUME_MAX;
+	return 0;
+}
+
+static int volume_alsa_vol_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	u8 s;
+	int rc;
+
+	rc = volume_get_status(&s);
+	if (rc < 0)
+		return rc;
+
+	ucontrol->value.integer.value[0] = s & TP_EC_AUDIO_LVL_MSK;
+	return 0;
+}
+
+static int volume_alsa_vol_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	return volume_set_volume(ucontrol->value.integer.value[0]);
+}
+
+#define volume_alsa_mute_info snd_ctl_boolean_mono_info
+
+static int volume_alsa_mute_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	u8 s;
+	int rc;
+
+	rc = volume_get_status(&s);
+	if (rc < 0)
+		return rc;
+
+	ucontrol->value.integer.value[0] =
+				(s & TP_EC_AUDIO_MUTESW_MSK) ? 0 : 1;
+	return 0;
+}
+
+static int volume_alsa_mute_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	return volume_set_mute(!ucontrol->value.integer.value[0]);
+}
+
+static struct snd_kcontrol_new volume_alsa_control_vol __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Console Playback Volume",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = volume_alsa_vol_info,
+	.get = volume_alsa_vol_get,
+};
+
+static struct snd_kcontrol_new volume_alsa_control_mute __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Console Playback Switch",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = volume_alsa_mute_info,
+	.get = volume_alsa_mute_get,
+};
+
+static int __init volume_create_alsa_mixer(void)
+{
+	struct snd_card *card;
+	struct tpacpi_alsa_data *data;
+	struct snd_kcontrol *ctl_vol;
+	struct snd_kcontrol *ctl_mute;
+	int rc;
+
+	rc = snd_card_create(alsa_index, alsa_id, THIS_MODULE,
+			    sizeof(struct tpacpi_alsa_data), &card);
+	if (rc < 0)
+		return rc;
+	if (!card)
+		return -ENOMEM;
+
+	BUG_ON(!card->private_data);
+	data = card->private_data;
+	data->card = card;
+
+	strlcpy(card->driver, TPACPI_ALSA_DRVNAME,
+		sizeof(card->driver));
+	strlcpy(card->shortname, TPACPI_ALSA_SHRTNAME,
+		sizeof(card->shortname));
+	snprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
+		 (thinkpad_id.ec_version_str) ?
+			thinkpad_id.ec_version_str : "(unknown)");
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s at EC reg 0x%02x, fw %s", card->shortname, TP_EC_AUDIO,
+		 (thinkpad_id.ec_version_str) ?
+			thinkpad_id.ec_version_str : "unknown");
+
+	if (volume_control_allowed) {
+		volume_alsa_control_vol.put = volume_alsa_vol_put;
+		volume_alsa_control_vol.access =
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+
+		volume_alsa_control_mute.put = volume_alsa_mute_put;
+		volume_alsa_control_mute.access =
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	}
+
+	if (!tp_features.mixer_no_level_control) {
+		ctl_vol = snd_ctl_new1(&volume_alsa_control_vol, NULL);
+		rc = snd_ctl_add(card, ctl_vol);
+		if (rc < 0) {
+			printk(TPACPI_ERR
+				"Failed to create ALSA volume control\n");
+			goto err_out;
+		}
+		data->ctl_vol_id = &ctl_vol->id;
+	}
+
+	ctl_mute = snd_ctl_new1(&volume_alsa_control_mute, NULL);
+	rc = snd_ctl_add(card, ctl_mute);
+	if (rc < 0) {
+		printk(TPACPI_ERR "Failed to create ALSA mute control\n");
+		goto err_out;
+	}
+	data->ctl_mute_id = &ctl_mute->id;
+
+	snd_card_set_dev(card, &tpacpi_pdev->dev);
+	rc = snd_card_register(card);
+
+err_out:
+	if (rc < 0) {
+		snd_card_free(card);
+		card = NULL;
+	}
+
+	alsa_card = card;
+	return rc;
+}
+
 #define TPACPI_VOL_Q_MUTEONLY	0x0001	/* Mute-only control available */
 #define TPACPI_VOL_Q_LEVEL	0x0002  /* Volume control available */
 
@@ -6623,6 +6809,7 @@ static const struct tpacpi_quirk volume_quirk_table[] __initconst = {
 static int __init volume_init(struct ibm_init_struct *iibm)
 {
 	unsigned long quirks;
+	int rc;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing volume subdriver\n");
 
@@ -6646,6 +6833,17 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 	if (volume_capabilities >= TPACPI_VOL_CAP_MAX)
 		return -EINVAL;
 
+	/*
+	 * The ALSA mixer is our primary interface.
+	 * When disabled, don't install the subdriver at all
+	 */
+	if (!alsa_enable) {
+		vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+			    "ALSA mixer disabled by parameter, "
+			    "not loading volume subdriver...\n");
+		return 1;
+	}
+
 	quirks = tpacpi_check_quirks(volume_quirk_table,
 				     ARRAY_SIZE(volume_quirk_table));
 
@@ -6690,12 +6888,26 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 			"mute is supported, volume control is %s\n",
 			str_supported(!tp_features.mixer_no_level_control));
 
+	rc = volume_create_alsa_mixer();
+	if (rc) {
+		printk(TPACPI_ERR
+			"Could not create the ALSA mixer interface\n");
+		return rc;
+	}
+
 	printk(TPACPI_INFO
 		"Console audio control enabled, mode: %s\n",
 		(volume_control_allowed) ?
 			"override (read/write)" :
 			"monitor (read only)");
 
+	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+		"registering volume hotkeys as change notification\n");
+	tpacpi_hotkey_driver_mask_set(hotkey_driver_mask
+			| TP_ACPI_HKEY_VOLUP_MASK
+			| TP_ACPI_HKEY_VOLDWN_MASK
+			| TP_ACPI_HKEY_MUTE_MASK);
+
 	return 0;
 }
 
@@ -8110,10 +8322,16 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 			tpacpi_brightness_notify_change();
 		}
 	}
+	if (alsa_card) {
+		switch (hkey_event) {
+		case TP_HKEY_EV_VOL_UP:
+		case TP_HKEY_EV_VOL_DOWN:
+		case TP_HKEY_EV_VOL_MUTE:
+			volume_alsa_notify_change();
+		}
+	}
 }
 
-
-
 static void hotkey_driver_event(const unsigned int scancode)
 {
 	tpacpi_driver_event(TP_HKEY_EV_HOTKEY_BASE + scancode);
@@ -8547,6 +8765,14 @@ MODULE_PARM_DESC(volume_control,
 		 "Enables software override for the console audio "
 		 "control when true");
 
+/* ALSA module API parameters */
+module_param_named(index, alsa_index, int, 0444);
+MODULE_PARM_DESC(index, "ALSA index for the ACPI EC Mixer");
+module_param_named(id, alsa_id, charp, 0444);
+MODULE_PARM_DESC(id, "ALSA id for the ACPI EC Mixer");
+module_param_named(enable, alsa_enable, bool, 0444);
+MODULE_PARM_DESC(enable, "Enable the ALSA interface for the ACPI EC Mixer");
+
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
 	MODULE_PARM_DESC(feature, "Simulates thinkpad-acpi procfs command " \
-- 
1.6.5.4

