From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 6/9] ACPI: thinkpad-acpi: issue input
	events for tablet swivel events
Date: Sat, 16 Feb 2008 02:17:55 -0200
Message-ID: <1203135478-4813-7-git-send-email-hmh@hmh.eng.br>
References: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1203135478-4813-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Issue EV_SW SW_TABLET_MODE events for HKEY events 0x5009 and 0x500A on the
X41t/X60t/X61t.  As usual, we suppress the HKEY events on the netlink
interface to avoid sending duplicate events to userspace.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c            |   22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 33d6e5a..0ae5708 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -491,6 +491,8 @@ generate input device EV_KEY events.
 Non hot-key ACPI HKEY event map:
 0x5001		Lid closed
 0x5002		Lid opened
+0x5009		Tablet swivel: switched to tablet mode
+0x500A		Tablet swivel: switched to normal mode
 0x7000		Radio Switch may have changed state
 
 The above events are not propagated by the driver, except for legacy
@@ -505,8 +507,6 @@ The above events are never propagated by the driver.
 
 0x3003		Bay ejection (see 0x2x05) complete, can sleep again
 0x4003		Undocked (see 0x2x04), can sleep again
-0x5009		Tablet swivel: switched to tablet mode
-0x500A		Tablet swivel: switched to normal mode
 0x500B		Tablet pen insterted into its storage bay
 0x500C		Tablet pen removed from its storage bay
 0x5010		Brightness level changed (newer Lenovo BIOSes)
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4ea3866..3548350 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1172,6 +1172,17 @@ static void tpacpi_input_send_radiosw(void)
 	mutex_unlock(&tpacpi_inputdev_send_mutex);
 }
 
+static void tpacpi_input_send_tabletsw(unsigned int state)
+{
+	mutex_lock(&tpacpi_inputdev_send_mutex);
+
+	input_report_switch(tpacpi_inputdev,
+			    SW_TABLET_MODE, !!state);
+	input_sync(tpacpi_inputdev);
+
+	mutex_unlock(&tpacpi_inputdev_send_mutex);
+}
+
 static void tpacpi_input_send_key(unsigned int scancode)
 {
 	unsigned int keycode;
@@ -2020,6 +2031,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 			set_bit(EV_SW, tpacpi_inputdev->evbit);
 			set_bit(SW_RADIO, tpacpi_inputdev->swbit);
 		}
+		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
+			set_bit(EV_SW, tpacpi_inputdev->evbit);
+			set_bit(SW_TABLET_MODE, tpacpi_inputdev->swbit);
+		}
 
 		dbg_printk(TPACPI_DBG_INIT,
 				"enabling hot key handling\n");
@@ -2169,11 +2184,14 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* 0x5000-0x5FFF: human interface helpers */
 			switch (hkey) {
 			case 0x5010: /* Lenovo new BIOS: brightness changed */
-			case 0x5009: /* X61t: swivel up (tablet mode) */
-			case 0x500a: /* X61t: swivel down (normal mode) */
 			case 0x500b: /* X61t: tablet pen inserted into bay */
 			case 0x500c: /* X61t: tablet pen removed from bay */
 				break;
+			case 0x5009: /* X61t: swivel up (tablet mode) */
+			case 0x500a: /* X61t: swivel down (normal mode) */
+				tpacpi_input_send_tabletsw((hkey == 0x5009));
+				send_acpi_ev = 0;
+				break;
 			case 0x5001:
 			case 0x5002:
 				/* LID switch events.  Do not propagate */
-- 
1.5.3.8


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
