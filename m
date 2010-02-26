From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/6] thinkpad-acpi: fix bluetooth/wwan
	resume
Date: Fri, 26 Feb 2010 01:11:23 -0300
Message-ID: <1267157484-23925-6-git-send-email-hmh@hmh.eng.br>
References: <1267157484-23925-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1267157484-23925-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Studying the DSDTs of various thinkpads, it looks like bit 3 of the
argument to SBDC and SWAN is not "set radio to last state on resume".
Rather, it seems to be "if this bit is set, enable radio on resume,
otherwise disable it on resume".

So, the proper way to prepare the radios for S3 suspend is: disable
radio and clear bit 3 on the SBDC/SWAN call to to resume with radio
disabled, and enable radio and set bit 3 on the SBDC/SWAN call to
resume with the radio enabled.

Also, for persistent devices, the rfkill core does not restore state,
so we really need to get the firmware to do the right thing.

We don't sync the radio state on suspend, instead we trust the BIOS to
not do anything weird if we never touched the radio state since boot.
Time will tell if that's a wise way of doing things...

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/platform/x86/thinkpad_acpi.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5f45083..3af4628 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3878,7 +3878,7 @@ enum {
 	TP_ACPI_BLUETOOTH_HWPRESENT	= 0x01,	/* Bluetooth hw available */
 	TP_ACPI_BLUETOOTH_RADIOSSW	= 0x02,	/* Bluetooth radio enabled */
 	TP_ACPI_BLUETOOTH_RESUMECTRL	= 0x04,	/* Bluetooth state at resume:
-						   off / last state */
+						   0 = disable, 1 = enable */
 };
 
 enum {
@@ -3924,10 +3924,11 @@ static int bluetooth_set_status(enum tpacpi_rfkill_state state)
 	}
 #endif
 
-	/* We make sure to keep TP_ACPI_BLUETOOTH_RESUMECTRL off */
-	status = TP_ACPI_BLUETOOTH_RESUMECTRL;
 	if (state == TPACPI_RFK_RADIO_ON)
-		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
+		status = TP_ACPI_BLUETOOTH_RADIOSSW
+			  | TP_ACPI_BLUETOOTH_RESUMECTRL;
+	else
+		status = 0;
 
 	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
 		return -EIO;
@@ -4078,7 +4079,7 @@ enum {
 	TP_ACPI_WANCARD_HWPRESENT	= 0x01,	/* Wan hw available */
 	TP_ACPI_WANCARD_RADIOSSW	= 0x02,	/* Wan radio enabled */
 	TP_ACPI_WANCARD_RESUMECTRL	= 0x04,	/* Wan state at resume:
-						   off / last state */
+						   0 = disable, 1 = enable */
 };
 
 #define TPACPI_RFK_WWAN_SW_NAME		"tpacpi_wwan_sw"
@@ -4115,10 +4116,11 @@ static int wan_set_status(enum tpacpi_rfkill_state state)
 	}
 #endif
 
-	/* We make sure to set TP_ACPI_WANCARD_RESUMECTRL */
-	status = TP_ACPI_WANCARD_RESUMECTRL;
 	if (state == TPACPI_RFK_RADIO_ON)
-		status |= TP_ACPI_WANCARD_RADIOSSW;
+		status = TP_ACPI_WANCARD_RADIOSSW
+			 | TP_ACPI_WANCARD_RESUMECTRL;
+	else
+		status = 0;
 
 	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
 		return -EIO;
-- 
1.6.5.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
