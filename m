From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Thinkpad X200s
Date: Sat, 28 Nov 2009 16:15:12 -0200
Message-ID: <20091128181512.GA32630@khazad-dum.debian.net>
References: <4B0FB618.7020204@collabora.co.uk>
 <20091127221134.GC21775@khazad-dum.debian.net>
 <20091128120711.GA17894@khazad-dum.debian.net>
 <4B111C58.5050006@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49973 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbZK1SPJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Nov 2009 13:15:09 -0500
Content-Disposition: inline
In-Reply-To: <4B111C58.5050006@collabora.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-acpi@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, 28 Nov 2009, Ian Molton wrote:
> Henrique de Moraes Holschuh wrote:
> > It is a regression from 2.6.30, so it will have to go to stable anyway.
> > This means it is best to waste a few days checking with the others if it
> > would be better fixed in rfkill or thinkpad-acpi, and then get it in
> > 2.6.32 and 2.6.31 through stable.
> > 
> > I will handle it, either way.
> 
> Cheers - I'll keep an eye on this thread so I can test your patch ASAP! :-)

And I will _need_ your help.  Here is a tentative patch.  I can use a much
heavier hand than this, but if the firmware cooperates, this one should do
it (and it will be faster, to boot).

Please check if WWAN, bluetooth and if at all possible, UWB are doing the
right thing:

remain enabled if you suspend with them enabled.
remain disabled if you suspend with they disabled.

And in the case of WWAN and bluetooth, whether they retain their state
(enabled or disabled) across reboots and shutdown.

If you happen to find out that UWB also retains state across
reboot/shutdown, I'd like to know about it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

--H1spWtNR+x+ondvy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix-tpacpi-rfk-resume.patch"

commit 03dd8d5357d8fe2d91bff4ccdecd7e26f73e92e9
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Nov 28 00:31:47 2009 -0200

    thinkpad-acpi: preserve rfkill state across suspend/resume
    
    Since the rfkill rework in 2.6.31, the driver is always resuming with
    the radios all in blocked state.  We used to resume with radios
    blocked, and then depend on the rfkill core to re-enable them.
    
    This doesn't work with the new rfkill core and thinkpad-acpi rfkill
    code for various reasons.
    
    Change thinkpad-acpi to ask the firmware to resume with the radios
    in the last state when possible, and preserve that state in the
    driver itself when that's not possible.
    
    This fixes a regression from 2.6.30.
    
    Reported-by: Ian Molton <ian.molton@collabora.co.uk>
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: stable@kernel.org

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 915e054..4abde23 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3877,15 +3877,6 @@ enum {
 
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
@@ -3919,10 +3910,9 @@ static int bluetooth_set_status(enum tpacpi_rfkill_state state)
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
@@ -4061,7 +4051,6 @@ static struct ibm_struct bluetooth_driver_data = {
 	.read = bluetooth_read,
 	.write = bluetooth_write,
 	.exit = bluetooth_exit,
-	.suspend = bluetooth_suspend,
 	.shutdown = bluetooth_shutdown,
 };
 
@@ -4079,15 +4068,6 @@ enum {
 
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
@@ -4120,11 +4100,10 @@ static int wan_set_status(enum tpacpi_rfkill_state state)
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
@@ -4262,7 +4241,6 @@ static struct ibm_struct wan_driver_data = {
 	.read = wan_read,
 	.write = wan_write,
 	.exit = wan_exit,
-	.suspend = wan_suspend,
 	.shutdown = wan_shutdown,
 };
 

--H1spWtNR+x+ondvy--
