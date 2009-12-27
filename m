From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/5] thinkpad-acpi: make volume subdriver optional
Date: Sat, 26 Dec 2009 22:52:15 -0200
Message-ID: <1261875137-27565-4-git-send-email-hmh@hmh.eng.br>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50924 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739AbZL0AwZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Dec 2009 19:52:25 -0500
In-Reply-To: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Ingo Molnar <mingo@elte.hu>, Amerigo Wang <amwang@redhat.com>, Helight Xu <helight.xu@gmail.com>, Takashi Iwai <tiwai@suse.de>

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
1.6.5.7

