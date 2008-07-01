From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 4/7] ACPI: thinkpad-acpi: WLSW overrides
	other rfkill switches
Date: Tue,  1 Jul 2008 15:27:52 -0300
Message-ID: <1214936875-4812-5-git-send-email-hmh@hmh.eng.br>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1214936875-4812-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On ThinkPads where the WLSW switch exists, the firmware or the hardware
ANDs the WLSW state with the device-specific switches (WWAN, Bluetooth).
It is downright impossible to enable WWAN or Bluetooth when WLSW is
blocking the radios.

This reality does not necessarily carry over to the WWAN and Bluetooth
firmware interfaces, though... so the state thinkpad-acpi was reporting
could be incorrect.

Tie the three switches in the driver so that we keep their state sane.
When WLSL is off, force the other switches to off as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.5.4


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
