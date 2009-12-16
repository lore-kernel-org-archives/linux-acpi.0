From: Len Brown <lenb@kernel.org>
Subject: [PATCH 015/103] thinkpad-acpi: expose module parameters
Date: Wed, 16 Dec 2009 03:35:26 -0500
Message-ID: <b09c72259e88cec3d602aef987a3209297f3a9c2.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41634 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760927AbZLPKGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:09 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Export the normal (non-command) module paramenters as mode 0444, so
that they will show up in sysfs.

These parameters must not be changed at runtime as a rule, with very
few exceptions.

Reported-by: Ferenc Wagner <wferi@niif.hu>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

