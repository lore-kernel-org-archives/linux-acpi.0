From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/14] thinkpad-acpi: make volume subdriver optional
Date: Wed, 30 Dec 2009 02:36:28 -0500
Message-ID: <ff850c339a1a6a7724537160c73cdc09a483fc5d.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:51894 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZL3Hgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:43 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG00HD5FT6VM6B@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:43 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Ingo Molnar <mingo@elte.hu>, Amerigo Wang <amwang@redhat.com>, Helight Xu <helight.xu@gmail.com>, Takashi Iwai <tiwai@suse.de>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Allow the user to choose through Kconfig if the Console Audio Control
interface (aka "volume subdriver") should be available or not.

This not only saves some memory, but also allows the thinkpad-acpi
driver to be built-in even if ALSA is modular when the console audio
control interface is not wanted.

This change fixes a build problem that is causing some annoyances, in
a way that doesn't disable the entire driver on kernels without ALSA
support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Amerigo Wang <amwang@redhat.com>
Cc: Helight Xu <helight.xu@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/Kconfig         |   23 +++++++++++++++++++++++
 drivers/platform/x86/thinkpad_acpi.c |   26 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ec4faff..2462dc3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -233,6 +233,29 @@ config THINKPAD_ACPI
 
 	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
 
+config THINKPAD_ACPI_ALSA_SUPPORT
+	bool "Console audio control ALSA interface"
+	depends on THINKPAD_ACPI
+	depends on SND
+	depends on SND = y || THINKPAD_ACPI = SND
+	default y
+	---help---
+	  Enables monitoring of the built-in console audio output control
+	  (headphone and speakers), which is operated by the mute and (in
+	  some ThinkPad models) volume hotkeys.
+
+	  If this option is enabled, ThinkPad-ACPI will export an ALSA card
+	  with a single read-only mixer control, which should be used for
+	  on-screen-display feedback purposes by the Desktop Environment.
+
+	  Optionally, the driver will also allow software control (the
+	  ALSA mixer will be made read-write).  Please refer to the driver
+	  documentation for details.
+
+	  All IBM models have both volume and mute control.  Newer Lenovo
+	  models only have mute control (the volume hotkeys are just normal
+	  keys and volume control is done through the main HDA mixer).
+
 config THINKPAD_ACPI_DEBUGFACILITIES
 	bool "Maintainer debug facilities"
 	depends on THINKPAD_ACPI
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9b7da9c..e67e4fe 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6384,6 +6384,8 @@ static struct ibm_struct brightness_driver_data = {
  * and we leave them unchanged.
  */
 
+#ifdef CONFIG_THINKPAD_ACPI_ALSA_SUPPORT
+
 #define TPACPI_ALSA_DRVNAME  "ThinkPad EC"
 #define TPACPI_ALSA_SHRTNAME "ThinkPad Console Audio Control"
 #define TPACPI_ALSA_MIXERNAME TPACPI_ALSA_SHRTNAME
@@ -7021,6 +7023,28 @@ static struct ibm_struct volume_driver_data = {
 	.shutdown = volume_shutdown,
 };
 
+#else /* !CONFIG_THINKPAD_ACPI_ALSA_SUPPORT */
+
+#define alsa_card NULL
+
+static void inline volume_alsa_notify_change(void)
+{
+}
+
+static int __init volume_init(struct ibm_init_struct *iibm)
+{
+	printk(TPACPI_INFO
+		"volume: disabled as there is no ALSA support in this kernel\n");
+
+	return 1;
+}
+
+static struct ibm_struct volume_driver_data = {
+	.name = "volume",
+};
+
+#endif /* CONFIG_THINKPAD_ACPI_ALSA_SUPPORT */
+
 /*************************************************************************
  * Fan subdriver
  */
@@ -8743,6 +8767,7 @@ MODULE_PARM_DESC(hotkey_report_mode,
 		 "used for backwards compatibility with userspace, "
 		 "see documentation");
 
+#ifdef CONFIG_THINKPAD_ACPI_ALSA_SUPPORT
 module_param_named(volume_mode, volume_mode, uint, 0444);
 MODULE_PARM_DESC(volume_mode,
 		 "Selects volume control strategy: "
@@ -8765,6 +8790,7 @@ module_param_named(id, alsa_id, charp, 0444);
 MODULE_PARM_DESC(id, "ALSA id for the ACPI EC Mixer");
 module_param_named(enable, alsa_enable, bool, 0444);
 MODULE_PARM_DESC(enable, "Enable the ALSA interface for the ACPI EC Mixer");
+#endif /* CONFIG_THINKPAD_ACPI_ALSA_SUPPORT */
 
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
-- 
1.6.0.6

