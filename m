From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 1/6] thinkpad-acpi: document HKEY event 3006
Date: Fri, 26 Feb 2010 01:11:19 -0300
Message-ID: <1267157484-23925-2-git-send-email-hmh@hmh.eng.br>
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

Event 0x3006 is used to help power management of the ODD in the
UltraBay.  The EC generates this event when the ODD eject button is
pressed (even if the bay is powered down).

Normally, Linux doesn't need this as we keep the SATA link powered
up (which wastes power).  The EC powers up the bay by itself when the
ODD eject button is pressed, and the SATA PHY reports the hotplug.

However, we could also power that SATA link down (and for that matter,
also power down the Ultrabay) if the ODD is left idle for a while with
no disk inside, and use event 0x3006 to know when we need that SATA link
powered back up.

For now, just stop asking for more information when event 0x3006 is
seen, there is no point in pestering users about it anymore.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/platform/x86/thinkpad_acpi.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index eb603f1..049041a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3655,13 +3655,19 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			break;
 		case 3:
 			/* 0x3000-0x3FFF: bay-related wakeups */
-			if (hkey == TP_HKEY_EV_BAYEJ_ACK) {
+			switch (hkey) {
+			case TP_HKEY_EV_BAYEJ_ACK:
 				hotkey_autosleep_ack = 1;
 				printk(TPACPI_INFO
 				       "bay ejected\n");
 				hotkey_wakeup_hotunplug_complete_notify_change();
 				known_ev = true;
-			} else {
+				break;
+			case TP_HKEY_EV_OPTDRV_EJ:
+				/* FIXME: kick libata if SATA link offline */
+				known_ev = true;
+				break;
+			default:
 				known_ev = false;
 			}
 			break;
-- 
1.6.5.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
