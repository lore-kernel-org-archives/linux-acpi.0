From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 14/20] ACPI: thinkpad-acpi: cleanup
	hotkey_notify and HKEY log messages
Date: Tue,  8 Jan 2008 13:02:51 -0200
Message-ID: <1199804577-32017-15-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Use a generic message on hotkey_notify to log unknown and unhandled events,
and cleanup hotkey_notify a little.

Also, document event 0x5010 (brightness changed notification) and do not
log it as an unknown event (even if we do not use it for anything right
now).

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |   35 ++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 7c7bd47..3fb8647 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -475,6 +475,10 @@ Non hot-key ACPI HKEY event map:
 The above events are not propagated by the driver, except for legacy
 compatibility purposes when hotkey_report_mode is set to 1.
 
+0x5010		Brightness level changed (newer Lenovo BIOSes)
+
+The above events are propagated by the driver.
+
 Compatibility notes:
 
 ibm-acpi and thinkpad-acpi 0.15 (mainline kernels before 2.6.23) never
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c6c25a4..f5f306a 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2007,6 +2007,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 	unsigned int scancode;
 	int send_acpi_ev;
 	int ignore_acpi_ev;
+	int unk_ev;
 
 	if (event != 0x80) {
 		printk(TPACPI_ERR
@@ -2030,8 +2031,9 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			return;
 		}
 
-		send_acpi_ev = 0;
+		send_acpi_ev = 1;
 		ignore_acpi_ev = 0;
+		unk_ev = 0;
 
 		switch (hkey >> 12) {
 		case 1:
@@ -2041,33 +2043,34 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				scancode--;
 				if (!(hotkey_source_mask & (1 << scancode))) {
 					tpacpi_input_send_key(scancode);
+					send_acpi_ev = 0;
 				} else {
 					ignore_acpi_ev = 1;
 				}
 			} else {
-				printk(TPACPI_ERR
-				       "hotkey 0x%04x out of range "
-				       "for keyboard map\n", hkey);
-				send_acpi_ev = 1;
+				unk_ev = 1;
 			}
 			break;
 		case 5:
-			/* 0x5000-0x5FFF: LID */
-			/* we don't handle it through this path, just
-			 * eat up known LID events */
-			if (hkey != 0x5001 && hkey != 0x5002) {
-				printk(TPACPI_ERR
-				       "unknown LID-related HKEY event: "
-				       "0x%04x\n", hkey);
-				send_acpi_ev = 1;
-			} else {
+			/* 0x5000-0x5FFF: On screen display helpers */
+			switch (hkey) {
+			case 0x5010:
+				/* Lenovo Vista BIOS: brightness changed */
+				break;
+			case 0x5001:
+			case 0x5002:
+				/* LID switch events.  Do not propagate */
 				ignore_acpi_ev = 1;
+				break;
+			default:
+				unk_ev = 1;
 			}
 			break;
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
 				tpacpi_input_send_radiosw();
+				send_acpi_ev = 0;
 				break;
 			}
 			/* fallthrough to default */
@@ -2078,9 +2081,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			/* case 3: ultra-bay related. maybe bay in dock? */
 			/*	0x3003 - T43 after wake up by bay lever
 			 *	         eject (0x2305) */
+			unk_ev = 1;
+		}
+		if (unk_ev) {
 			printk(TPACPI_NOTICE
 			       "unhandled HKEY event 0x%04x\n", hkey);
-			send_acpi_ev = 1;
 		}
 
 		/* Legacy events */
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
