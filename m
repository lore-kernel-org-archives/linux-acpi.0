From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/7] ACPI: thinkpad-acpi: WLSW overrides other rfkill switches
Date: Mon, 21 Jul 2008 09:42:17 -0300
Message-ID: <1216644140-13284-4-git-send-email-hmh@hmh.eng.br>
References: <20080721122935.GA12972@khazad-dum.debian.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44364 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419AbYGUMm2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2008 08:42:28 -0400
In-Reply-To: <20080721122935.GA12972@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On ThinkPads where the WLSW switch exists, the firmware or the hardware
ANDs the WLSW state with the device-specific switches (WWAN, Bluetooth).
It is downright impossible to enable WWAN or Bluetooth when WLSW is
blocking the radios.

This reality does not necessarily carry over to the WWAN and Bluetooth
firmware interfaces, though... so the state thinkpad-acpi was reporting
could be incorrect.

Tie the three switches in the driver so that we keep their state sane.
When WLSL is off, force the other switches to off as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 743a4d6..202d63e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2588,6 +2588,10 @@ static int bluetooth_get_radiosw(void)
 	if (!tp_features.bluetooth)
 		return -ENODEV;
 
+	/* WLSW overrides bluetooth in firmware/hardware, reflect that */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
+		return 0;
+
 	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		return -EIO;
 
@@ -2601,6 +2605,12 @@ static int bluetooth_set_radiosw(int radio_on)
 	if (!tp_features.bluetooth)
 		return -ENODEV;
 
+	/* WLSW overrides bluetooth in firmware/hardware, but there is no
+	 * reason to risk weird behaviour. */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status
+	    && radio_on)
+		return -EPERM;
+
 	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
 		return -EIO;
 	if (radio_on)
@@ -2760,6 +2770,10 @@ static int wan_get_radiosw(void)
 	if (!tp_features.wan)
 		return -ENODEV;
 
+	/* WLSW overrides WWAN in firmware/hardware, reflect that */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status)
+		return 0;
+
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 
@@ -2773,6 +2787,12 @@ static int wan_set_radiosw(int radio_on)
 	if (!tp_features.wan)
 		return -ENODEV;
 
+	/* WLSW overrides bluetooth in firmware/hardware, but there is no
+	 * reason to risk weird behaviour. */
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&status) && !status
+	    && radio_on)
+		return -EPERM;
+
 	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		return -EIO;
 	if (radio_on)
-- 
1.5.6.2

