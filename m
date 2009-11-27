From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Thinkpad X200s
Date: Fri, 27 Nov 2009 11:20:56 +0000
Message-ID: <4B0FB618.7020204@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050108020701060805070804"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:47496 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZK0L2H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 06:28:07 -0500
Received: from [192.168.1.164] (94-192-117-31.zone6.bethere.co.uk [94.192.117.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E4EBA600357
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2009 11:21:34 +0000 (GMT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108020701060805070804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

I've been investigating a problem with rfkill on the X200s from Lenovo.
The problem exists in debians 2.6.30-2 kernel and persists right up to -git

I've found that the WWAN card does not behave as expected on suspend /
resume.

The problem seems to be the rfkill layer getting out of sync with ACPIs
idea of the hardware state.

If the laptop is suspended with WWAN enabled, it will wake up with it
disabled, requiring a toggle of the physical WWAN switch or a prod in
/sys to get it going again.

I wrote a little patch that "cures" this issue (attached), however it is
far from perfect.

For example, even with this patch, when the side switch is used, it
overrides the soft setting for the devices completely, so if for example
the WWAN was off, then toggling the switch changes its rfkill state from
0 -> 2, and then from 2 -> 1

It *appears* from the code that it should be possible to get the device
to power up in the state it was last in, but I cant make mine do it.

I've also noticed that on recent kernels, I get an extra rfkillswitch
for hci0 (bluetooth) in addition to the ACPI one. This vanishes if power
is toggled using the ACPI rfkill softswitch, however bluetooth continues
to work (when enabled).

Has anyone else experienced these issues?

-Ian

--------------050108020701060805070804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d93108d..4896af5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4055,14 +4055,37 @@ enum {
 };
 
 #define TPACPI_RFK_WWAN_SW_NAME		"tpacpi_wwan_sw"
+static int laststat;
 
 static void wan_suspend(pm_message_t state)
 {
+	int status;
+	acpi_evalf(hkey_handle, &status, "GWAN", "d");
+	laststat = status;
+        printk("s%d stat.\n", status);
 	/* Try to make sure radio will resume powered off */
 	if (!acpi_evalf(NULL, NULL, "\\WGSV", "qvd",
 		   TP_ACPI_WGSV_PWR_OFF_ON_RESUME))
 		vdbg_printk(TPACPI_DBG_RFKILL,
 			"WWAN power down on resume request failed\n");
+	printk("sus\n");
+	acpi_evalf(hkey_handle, &status, "GWAN", "d");
+        printk("s%d stat.\n", status);
+}
+
+static int wan_resume(pm_message_t state)
+{
+	int status;
+	printk("res\n");
+	acpi_evalf(hkey_handle, &status, "GWAN", "d");
+	printk("r%d stat.\n", status);
+        printk("l%d stat.\n", laststat);
+	if(laststat & TP_ACPI_WANCARD_RADIOSSW) {
+	acpi_evalf(hkey_handle, NULL, "SWAN", "vd", TP_ACPI_WANCARD_RADIOSSW);
+	acpi_evalf(hkey_handle, &status, "GWAN", "d");
+	printk("r%d stat.\n", status);
+	tpacpi_rfk_update_swstate_all();
+	}
 }
 
 static int wan_get_status(void)
@@ -4078,6 +4101,7 @@ static int wan_get_status(void)
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 
+	printk("gs: %d\n", status);
 	return ((status & TP_ACPI_WANCARD_RADIOSSW) != 0) ?
 			TPACPI_RFK_RADIO_ON : TPACPI_RFK_RADIO_OFF;
 }
@@ -4103,6 +4127,7 @@ static int wan_set_status(enum tpacpi_rfkill_state state)
 	else
 		status = 0;
 
+	printk("ss: %d\n", status);
 	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
 		return -EIO;
 
@@ -4239,6 +4264,7 @@ static struct ibm_struct wan_driver_data = {
 	.read = wan_read,
 	.write = wan_write,
 	.exit = wan_exit,
+	.resume = wan_resume,
 	.suspend = wan_suspend,
 	.shutdown = wan_shutdown,
 };

--------------050108020701060805070804--
