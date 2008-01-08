From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 16/20] ACPI: thinkpad-acpi: add X61t HKEY
	events
Date: Tue,  8 Jan 2008 13:02:53 -0200
Message-ID: <1199804577-32017-17-git-send-email-hmh@hmh.eng.br>
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

Tomas Carnecky reports that events 0x5009 and 0x500a are swivel events, and
that 0x500b/0x500c are tablet pen storage bay events.

Document these events, and avoid nasty messages when they happen.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    4 ++++
 drivers/misc/thinkpad_acpi.c    |    9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 9d08e47..e1c4550 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -499,6 +499,10 @@ The above events are never propagated by the driver.
 
 0x3003		Bay ejection (see 0x2x05) complete, can sleep again
 0x4003		Undocked (see 0x2x04), can sleep again
+0x5009		Tablet swivel: switched to tablet mode
+0x500A		Tablet swivel: switched to normal mode
+0x500B		Tablet pen insterted into its storage bay
+0x500C		Tablet pen removed from its storage bay
 0x5010		Brightness level changed (newer Lenovo BIOSes)
 
 The above events are propagated by the driver.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9b0235d..049ec42 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2127,10 +2127,13 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			}
 			break;
 		case 5:
-			/* 0x5000-0x5FFF: On screen display helpers */
+			/* 0x5000-0x5FFF: human interface helpers */
 			switch (hkey) {
-			case 0x5010:
-				/* Lenovo Vista BIOS: brightness changed */
+			case 0x5010: /* Lenovo new BIOS: brightness changed */
+			case 0x5009: /* X61t: swivel up (tablet mode) */
+			case 0x500a: /* X61t: swivel down (normal mode) */
+			case 0x500b: /* X61t: tablet pen inserted into bay */
+			case 0x500c: /* X61t: tablet pen removed from bay */
 				break;
 			case 0x5001:
 			case 0x5002:
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
