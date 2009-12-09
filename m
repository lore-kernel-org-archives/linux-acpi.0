From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 07/10] thinkpad-acpi: expose module parameters
Date: Tue,  8 Dec 2009 23:36:27 -0200
Message-ID: <1260322590-5571-8-git-send-email-hmh@hmh.eng.br>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58347 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967106AbZLIBgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:36:35 -0500
In-Reply-To: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Export the normal (non-command) module paramenters as mode 0444, so
that they will show up in sysfs.

These parameters must not be changed at runtime as a rule, with very
few exceptions.

Reported-by: Ferenc Wagner <wferi@niif.hu>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index dd8bd07..4b96a96 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8116,32 +8116,32 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 	return -EINVAL;
 }
 
-module_param(experimental, int, 0);
+module_param(experimental, int, 0444);
 MODULE_PARM_DESC(experimental,
 		 "Enables experimental features when non-zero");
 
 module_param_named(debug, dbg_level, uint, 0);
 MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
 
-module_param(force_load, bool, 0);
+module_param(force_load, bool, 0444);
 MODULE_PARM_DESC(force_load,
 		 "Attempts to load the driver even on a "
 		 "mis-identified ThinkPad when true");
 
-module_param_named(fan_control, fan_control_allowed, bool, 0);
+module_param_named(fan_control, fan_control_allowed, bool, 0444);
 MODULE_PARM_DESC(fan_control,
 		 "Enables setting fan parameters features when true");
 
-module_param_named(brightness_mode, brightness_mode, uint, 0);
+module_param_named(brightness_mode, brightness_mode, uint, 0444);
 MODULE_PARM_DESC(brightness_mode,
 		 "Selects brightness control strategy: "
 		 "0=auto, 1=EC, 2=UCMS, 3=EC+NVRAM");
 
-module_param(brightness_enable, uint, 0);
+module_param(brightness_enable, uint, 0444);
 MODULE_PARM_DESC(brightness_enable,
 		 "Enables backlight control when 1, disables when 0");
 
-module_param(hotkey_report_mode, uint, 0);
+module_param(hotkey_report_mode, uint, 0444);
 MODULE_PARM_DESC(hotkey_report_mode,
 		 "used for backwards compatibility with userspace, "
 		 "see documentation");
@@ -8164,25 +8164,25 @@ TPACPI_PARAM(volume);
 TPACPI_PARAM(fan);
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
-module_param(dbg_wlswemul, uint, 0);
+module_param(dbg_wlswemul, uint, 0444);
 MODULE_PARM_DESC(dbg_wlswemul, "Enables WLSW emulation");
 module_param_named(wlsw_state, tpacpi_wlsw_emulstate, bool, 0);
 MODULE_PARM_DESC(wlsw_state,
 		 "Initial state of the emulated WLSW switch");
 
-module_param(dbg_bluetoothemul, uint, 0);
+module_param(dbg_bluetoothemul, uint, 0444);
 MODULE_PARM_DESC(dbg_bluetoothemul, "Enables bluetooth switch emulation");
 module_param_named(bluetooth_state, tpacpi_bluetooth_emulstate, bool, 0);
 MODULE_PARM_DESC(bluetooth_state,
 		 "Initial state of the emulated bluetooth switch");
 
-module_param(dbg_wwanemul, uint, 0);
+module_param(dbg_wwanemul, uint, 0444);
 MODULE_PARM_DESC(dbg_wwanemul, "Enables WWAN switch emulation");
 module_param_named(wwan_state, tpacpi_wwan_emulstate, bool, 0);
 MODULE_PARM_DESC(wwan_state,
 		 "Initial state of the emulated WWAN switch");
 
-module_param(dbg_uwbemul, uint, 0);
+module_param(dbg_uwbemul, uint, 0444);
 MODULE_PARM_DESC(dbg_uwbemul, "Enables UWB switch emulation");
 module_param_named(uwb_state, tpacpi_uwb_emulstate, bool, 0);
 MODULE_PARM_DESC(uwb_state,
-- 
1.6.5.4

