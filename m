From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/13] ACPI: thinkpad-acpi: warn once about
	weird hotkey masks
Date: Thu, 10 Apr 2008 00:52:54 -0300
Message-ID: <1207799585-10112-3-git-send-email-hmh@hmh.eng.br>
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
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

thinkpad-acpi knows for a while now how to best program the hotkeys by
default, and always enable them by default.  Unfortunately, this
information has not filtered down everywhere it needs to, yet.  Notably,
old ibm-acpi documentation and most "thinkpad setup guides" will have wrong
information on this area.

Warn the local admin once whenever any of the following patterns are met:

1. Attempts to set hotkey mask to 0xffff (artifact from docs and config
   for the old ibm-acpi driver and behaviour).  This mask makes no
   real-world sense;

2. Attempts to set hotkey mask to 0xffffffff, which means the user is
   trying to just have "everything work" without even reading the
   documentation, or that we need to get a bug report, because there
   is a new thinkpad out there with new exciting hot keys :-)

3. Attempts to set hotkey mask to 0xffffff, which is almost never the
   correct way to set up volume and brightness event reporting (and with
   the current state-of-the-art, it is known to never be right way to do
   it).

The driver will perform any and all requested operations, though,
regardless of any warnings.  I hope these warnings can be removed one or
two years from now.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2c85a2e..cd263c5 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -237,6 +237,10 @@ static struct {
 	u32 hotkey_poll_active:1;
 } tp_features;
 
+static struct {
+	u16 hotkey_mask_ff:1;
+} tp_warned;
+
 struct thinkpad_id_data {
 	unsigned int vendor;	/* ThinkPad vendor:
 				 * PCI_VENDOR_ID_IBM/PCI_VENDOR_ID_LENOVO */
@@ -1182,6 +1186,19 @@ static int hotkey_mask_set(u32 mask)
 	int rc = 0;
 
 	if (tp_features.hotkey_mask) {
+		if (!tp_warned.hotkey_mask_ff &&
+		    (mask == 0xffff || mask == 0xffffff ||
+		     mask == 0xffffffff)) {
+			tp_warned.hotkey_mask_ff = 1;
+			printk(TPACPI_NOTICE
+			       "setting the hotkey mask to 0x%08x is likely "
+			       "not the best way to go about it\n", mask);
+			printk(TPACPI_NOTICE
+			       "please consider using the driver defaults, "
+			       "and refer to up-to-date thinkpad-acpi "
+			       "documentation\n");
+		}
+
 		HOTKEY_CONFIG_CRITICAL_START
 		for (i = 0; i < 32; i++) {
 			u32 m = 1 << i;
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
