From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.31,32.stable] thinkpad-acpi: preserve rfkill state across
 suspend/resume
Date: Wed, 16 Dec 2009 23:01:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912162258500.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64421 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbZLQEBf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 23:01:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUS00C4436C78G4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 22:01:25 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

upstgream 208b996b6c460285650d39b2330f8ef82c007d10 

Since the rfkill rework in 2.6.31, the driver is always resuming with
the radios disabled.

Change thinkpad-acpi to ask the firmware to resume with the radios in
the last state.  This fixes the Bluetooth and WWAN rfkill switches.

Note that it means we respect the firmware's oddities.  Should the
user toggle the hardware rfkill switch on and off, it might cause the
radios to resume enabled.

UWB is an unknown quantity since it has nowhere the same level of
firmware support (no control over state storage in NVRAM, for
example), and might need further fixing.  Testers welcome.

This change fixes a regression from 2.6.30.

Reported-by: Jerone Young <jerone.young@canonical.com>
Reported-by: Ian Molton <ian.molton@collabora.co.uk>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Tested-by: Ian Molton <ian.molton@collabora.co.uk>
Cc: stable@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c6d5a9..1ee734c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3866,15 +3866,6 @@ enum {
 
 #define TPACPI_RFK_BLUETOOTH_SW_NAME	"tpacpi_bluetooth_sw"
 
-static void bluetooth_suspend(pm_message_t state)
-{
-	/* Try to make sure radio will resume powered off */
-	if (!acpi_evalf(NULL, NULL, "\\BLTH", "vd",
-		   TP_ACPI_BLTH_PWR_OFF_ON_RESUME))
-		vdbg_printk(TPACPI_DBG_RFKILL,
-			"bluetooth power down on resume request failed\n");
-}
-
 static int bluetooth_get_status(void)
 {
 	int status;
@@ -3908,10 +3899,9 @@ static int bluetooth_set_status(enum tpacpi_rfkill_state state)
 #endif
 
 	/* We make sure to keep TP_ACPI_BLUETOOTH_RESUMECTRL off */
+	status = TP_ACPI_BLUETOOTH_RESUMECTRL;
 	if (state == TPACPI_RFK_RADIO_ON)
-		status = TP_ACPI_BLUETOOTH_RADIOSSW;
-	else
-		status = 0;
+		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
 
 	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
 		return -EIO;
@@ -4050,7 +4040,6 @@ static struct ibm_struct bluetooth_driver_data = {
 	.read = bluetooth_read,
 	.write = bluetooth_write,
 	.exit = bluetooth_exit,
-	.suspend = bluetooth_suspend,
 	.shutdown = bluetooth_shutdown,
 };
 
@@ -4068,15 +4057,6 @@ enum {
 
 #define TPACPI_RFK_WWAN_SW_NAME		"tpacpi_wwan_sw"
 
-static void wan_suspend(pm_message_t state)
-{
-	/* Try to make sure radio will resume powered off */
-	if (!acpi_evalf(NULL, NULL, "\\WGSV", "qvd",
-		   TP_ACPI_WGSV_PWR_OFF_ON_RESUME))
-		vdbg_printk(TPACPI_DBG_RFKILL,
-			"WWAN power down on resume request failed\n");
-}
-
 static int wan_get_status(void)
 {
 	int status;
@@ -4109,11 +4089,10 @@ static int wan_set_status(enum tpacpi_rfkill_state state)
 	}
 #endif
 
-	/* We make sure to keep TP_ACPI_WANCARD_RESUMECTRL off */
+	/* We make sure to set TP_ACPI_WANCARD_RESUMECTRL */
+	status = TP_ACPI_WANCARD_RESUMECTRL;
 	if (state == TPACPI_RFK_RADIO_ON)
-		status = TP_ACPI_WANCARD_RADIOSSW;
-	else
-		status = 0;
+		status |= TP_ACPI_WANCARD_RADIOSSW;
 
 	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
 		return -EIO;
@@ -4251,7 +4230,6 @@ static struct ibm_struct wan_driver_data = {
 	.read = wan_read,
 	.write = wan_write,
 	.exit = wan_exit,
-	.suspend = wan_suspend,
 	.shutdown = wan_shutdown,
 };
 
-- 
1.6.6.rc2.5.g49666

