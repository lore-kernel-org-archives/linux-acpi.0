From: Len Brown <lenb@kernel.org>
Subject: [PATCH 010/103] thinkpad-acpi: preserve rfkill state across
 suspend/resume
Date: Wed, 16 Dec 2009 03:35:21 -0500
Message-ID: <208b996b6c460285650d39b2330f8ef82c007d10.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:33949 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZLPIhN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:13 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ002DBL9S7B0I@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:09 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

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
1.6.0.6

