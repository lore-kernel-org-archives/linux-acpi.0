From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 7/7] ACPI: thinkpad-acpi: fix regression on
	HKEY LID event handling
Date: Sat, 22 Sep 2007 22:10:42 -0300
Message-ID: <1190509843444-git-send-email-hmh@hmh.eng.br>
References: <11905098422303-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11905098422303-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We were letting ThinkPad-specific LID events through to userspace again,
instead of dropping them.  Fix it.  We don't want to give userspace the
option of not using generic LID handling.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b1db51e..1a77fe4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1197,6 +1197,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	u32 hkey;
 	unsigned int keycode, scancode;
 	int send_acpi_ev;
+	int ignore_acpi_ev;
 
 	if (event != 0x80) {
 		printk(IBM_ERR "unknown HKEY notification event %d\n", event);
@@ -1218,6 +1219,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		send_acpi_ev = 0;
+		ignore_acpi_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -1243,6 +1245,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				       "unknown LID-related HKEY event: 0x%04x\n",
 				       hkey);
 				send_acpi_ev = 1;
+			} else {
+				ignore_acpi_ev = 1;
 			}
 			break;
 		case 7:
@@ -1262,11 +1266,12 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		}
 
 		/* Legacy events */
-		if (send_acpi_ev || hotkey_report_mode < 2)
+		if (!ignore_acpi_ev && (send_acpi_ev || hotkey_report_mode < 2)) {
 			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
+		}
 
 		/* netlink events */
-		if (send_acpi_ev) {
+		if (!ignore_acpi_ev && send_acpi_ev) {
 			acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
 							ibm->acpi->device->dev.bus_id,
 							event, hkey);
-- 
1.5.3.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
