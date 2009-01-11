From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 04/13] ACPI: thinkpad-acpi: resume with radios disabled
Date: Sun, 11 Jan 2009 03:01:01 -0200
Message-ID: <1231650070-21722-5-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43346 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750997AbZAKFBR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Instruct the firmware to not enable the radios when resuming.  This
is safer, and the rfkill core will take care to manually enable any
radios that need to be enabled.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   66 ++++++++++++++++++++++++++++-----
 1 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a086ce8..b2c5913 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -122,6 +122,27 @@ enum {
 #define TPACPI_HKEY_INPUT_PRODUCT	0x5054 /* "TP" */
 #define TPACPI_HKEY_INPUT_VERSION	0x4101
 
+/* ACPI \WGSV commands */
+enum {
+	TP_ACPI_WGSV_GET_STATE		= 0x01, /* Get state information */
+	TP_ACPI_WGSV_PWR_ON_ON_RESUME	= 0x02, /* Resume WWAN powered on */
+	TP_ACPI_WGSV_PWR_OFF_ON_RESUME	= 0x03,	/* Resume WWAN powered off */
+	TP_ACPI_WGSV_SAVE_STATE		= 0x04, /* Save state for S4/S5 */
+};
+
+/* TP_ACPI_WGSV_GET_STATE bits */
+enum {
+	TP_ACPI_WGSV_STATE_WWANEXIST	= 0x0001, /* WWAN hw available */
+	TP_ACPI_WGSV_STATE_WWANPWR	= 0x0002, /* WWAN radio enabled */
+	TP_ACPI_WGSV_STATE_WWANPWRRES	= 0x0004, /* WWAN state at resume */
+	TP_ACPI_WGSV_STATE_WWANBIOSOFF	= 0x0008, /* WWAN disabled in BIOS */
+	TP_ACPI_WGSV_STATE_BLTHEXIST	= 0x0001, /* BLTH hw available */
+	TP_ACPI_WGSV_STATE_BLTHPWR	= 0x0002, /* BLTH radio enabled */
+	TP_ACPI_WGSV_STATE_BLTHPWRRES	= 0x0004, /* BLTH state at resume */
+	TP_ACPI_WGSV_STATE_BLTHBIOSOFF	= 0x0008, /* BLTH disabled in BIOS */
+	TP_ACPI_WGSV_STATE_UWBEXIST	= 0x0010, /* UWB hw available */
+	TP_ACPI_WGSV_STATE_UWBPWR	= 0x0020, /* UWB radio enabled */
+};
 
 /****************************************************************************
  * Main driver
@@ -2766,11 +2787,28 @@ enum {
 	/* ACPI GBDC/SBDC bits */
 	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
 	TP_ACPI_BLUETOOTH_RADIOSSW	= 0x02,	/* Bluetooth radio enabled */
-	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
+	TP_ACPI_BLUETOOTH_RESUMECTRL	= 0x04,	/* Bluetooth state at resume:
+						   off / last state */
+};
+
+enum {
+	/* ACPI \BLTH commands */
+	TP_ACPI_BLTH_GET_ULTRAPORT_ID	= 0x00, /* Get Ultraport BT ID */
+	TP_ACPI_BLTH_GET_PWR_ON_RESUME	= 0x01, /* Get power-on-resume state */
+	TP_ACPI_BLTH_PWR_ON_ON_RESUME	= 0x02, /* Resume powered on */
+	TP_ACPI_BLTH_PWR_OFF_ON_RESUME	= 0x03,	/* Resume powered off */
+	TP_ACPI_BLTH_SAVE_STATE		= 0x05, /* Save state for S4/S5 */
 };
 
 static struct rfkill *tpacpi_bluetooth_rfkill;
 
+static void bluetooth_suspend(pm_message_t state)
+{
+	/* Try to make sure radio will resume powered off */
+	acpi_evalf(NULL, NULL, "\\BLTH", "vd",
+		   TP_ACPI_BLTH_PWR_OFF_ON_RESUME);
+}
+
 static int bluetooth_get_radiosw(void)
 {
 	int status;
@@ -2830,12 +2868,11 @@ static int bluetooth_set_radiosw(int radio_on, int update_rfk)
 	}
 #endif
 
-	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
-		return -EIO;
+	/* We make sure to keep TP_ACPI_BLUETOOTH_RESUMECTRL off */
 	if (radio_on)
-		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
+		status = TP_ACPI_BLUETOOTH_RADIOSSW;
 	else
-		status &= ~TP_ACPI_BLUETOOTH_RADIOSSW;
+		status = 0;
 	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
 		return -EIO;
 
@@ -3012,6 +3049,7 @@ static struct ibm_struct bluetooth_driver_data = {
 	.read = bluetooth_read,
 	.write = bluetooth_write,
 	.exit = bluetooth_exit,
+	.suspend = bluetooth_suspend,
 };
 
 /*************************************************************************
@@ -3022,11 +3060,19 @@ enum {
 	/* ACPI GWAN/SWAN bits */
 	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
 	TP_ACPI_WANCARD_RADIOSSW	= 0x02,	/* Wan radio enabled */
-	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
+	TP_ACPI_WANCARD_RESUMECTRL	= 0x04,	/* Wan state at resume:
+						   off / last state */
 };
 
 static struct rfkill *tpacpi_wan_rfkill;
 
+static void wan_suspend(pm_message_t state)
+{
+	/* Try to make sure radio will resume powered off */
+	acpi_evalf(NULL, NULL, "\\WGSV", "qvd",
+		   TP_ACPI_WGSV_PWR_OFF_ON_RESUME);
+}
+
 static int wan_get_radiosw(void)
 {
 	int status;
@@ -3086,12 +3132,11 @@ static int wan_set_radiosw(int radio_on, int update_rfk)
 	}
 #endif
 
-	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
-		return -EIO;
+	/* We make sure to keep TP_ACPI_WANCARD_RESUMECTRL off */
 	if (radio_on)
-		status |= TP_ACPI_WANCARD_RADIOSSW;
+		status = TP_ACPI_WANCARD_RADIOSSW;
 	else
-		status &= ~TP_ACPI_WANCARD_RADIOSSW;
+		status = 0;
 	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
 		return -EIO;
 
@@ -3266,6 +3311,7 @@ static struct ibm_struct wan_driver_data = {
 	.read = wan_read,
 	.write = wan_write,
 	.exit = wan_exit,
+	.suspend = wan_suspend,
 };
 
 /*************************************************************************
-- 
1.5.6.5

