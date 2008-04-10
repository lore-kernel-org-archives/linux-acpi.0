From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 04/13] ACPI: thinkpad-acpi: rate-limit
	CMOS/EC unsynced error messages
Date: Thu, 10 Apr 2008 00:52:56 -0300
Message-ID: <1207799585-10112-5-git-send-email-hmh@hmh.eng.br>
References: <1207799585-10112-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1207799585-10112-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Joerg Platte <lists-v18Uk5sXZWJeoWH0uzbU5w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If userspace applications mess with the CMOS NVRAM, or something causes
both the ACPI firmware and thinkpad-acpi to try to change the brightness at
the same time, it is possible to have the CMOS and EC registers for the
current brightness go out of sync.

Should that happen, thinkpad-acpi could be really obnoxious when using a
brightness_mode of 3 (both EC and CMOS).  Instead of complaining a massive
number of times, make sure to complain only once until EC and CMOS are back
in sync.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Joerg Platte <lists-v18Uk5sXZWJeoWH0uzbU5w@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c8c1d6c..3513d99 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -239,6 +239,7 @@ static struct {
 
 static struct {
 	u16 hotkey_mask_ff:1;
+	u16 bright_cmos_ec_unsync:1;
 } tp_warned;
 
 struct thinkpad_id_data {
@@ -4322,13 +4323,20 @@ static int brightness_get(struct backlight_device *bd)
 		level = lcmos;
 	}
 
-	if (brightness_mode == 3 && lec != lcmos) {
-		printk(TPACPI_ERR
-			"CMOS NVRAM (%u) and EC (%u) do not agree "
-			"on display brightness level\n",
-			(unsigned int) lcmos,
-			(unsigned int) lec);
-		return -EIO;
+	if (brightness_mode == 3) {
+		if (lec == lcmos)
+			tp_warned.bright_cmos_ec_unsync = 0;
+		else {
+			if (!tp_warned.bright_cmos_ec_unsync) {
+				printk(TPACPI_ERR
+					"CMOS NVRAM (%u) and EC (%u) do not "
+					"agree on display brightness level\n",
+					(unsigned int) lcmos,
+					(unsigned int) lec);
+				tp_warned.bright_cmos_ec_unsync = 1;
+			}
+			return -EIO;
+		}
 	}
 
 	return level;
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
