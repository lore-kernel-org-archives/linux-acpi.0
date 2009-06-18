From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] thinkpad-acpi: forbid the use of HBRV on Lenovo ThinkPads
Date: Thu, 18 Jun 2009 00:40:16 -0300
Message-ID: <1245296417-3734-2-git-send-email-hmh@hmh.eng.br>
References: <1245296417-3734-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37806 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789AbZFRDk3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 23:40:29 -0400
In-Reply-To: <1245296417-3734-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Forcing thinkpad-acpi to do EC-based brightness control (HBRV) on a
X61 has very... interesting effects, instead of doing nothing (since
it doesn't have EC-based backlight control), it causes "weirdness" in
the fan tachometer readings, for example.

This means the EC register that used to be HBRV has been reused by
Lenovo for something else, but they didn't remove it from the DSDT.

Make sure the documentation reflects this data, and forbid the user
from forcing the driver to access HBRV on Lenovo ThinkPads.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |   14 ++++++++------
 drivers/platform/x86/thinkpad_acpi.c    |   10 ++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 88fc066..f2ff638 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1169,17 +1169,19 @@ may not be distinct.  Later Lenovo models that implement the ACPI
 display backlight brightness control methods have 16 levels, ranging
 from 0 to 15.
 
-There are two interfaces to the firmware for direct brightness control,
-EC and UCMS (or CMOS).  To select which one should be used, use the
-brightness_mode module parameter: brightness_mode=1 selects EC mode,
-brightness_mode=2 selects UCMS mode, brightness_mode=3 selects EC
-mode with NVRAM backing (so that brightness changes are remembered
-across shutdown/reboot).
+For IBM ThinkPads, there are two interfaces to the firmware for direct
+brightness control, EC and UCMS (or CMOS).  To select which one should be
+used, use the brightness_mode module parameter: brightness_mode=1 selects
+EC mode, brightness_mode=2 selects UCMS mode, brightness_mode=3 selects EC
+mode with NVRAM backing (so that brightness changes are remembered across
+shutdown/reboot).
 
 The driver tries to select which interface to use from a table of
 defaults for each ThinkPad model.  If it makes a wrong choice, please
 report this as a bug, so that we can fix it.
 
+Lenovo ThinkPads only support brightness_mode=2 (UCMS).
+
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
 ThinkPad-specific interface.  The driver will disable its native
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5a22a06..c8d74db 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5696,6 +5696,10 @@ static struct ibm_struct ecdump_driver_data = {
  *   Bit 3-0: backlight brightness level
  *
  * brightness_get_raw returns status data in the HBRV layout
+ *
+ * WARNING: The X61 has been verified to use HBRV for something else, so
+ * this should be used _only_ on IBM ThinkPads, and maybe with some careful
+ * testing on the very early *60 Lenovo models...
  */
 
 enum {
@@ -5996,6 +6000,12 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 			   brightness_mode);
 	}
 
+	/* Safety */
+	if (thinkpad_id.vendor != PCI_VENDOR_ID_IBM &&
+	    (brightness_mode == TPACPI_BRGHT_MODE_ECNVRAM ||
+	     brightness_mode == TPACPI_BRGHT_MODE_EC))
+		return -EINVAL;
+
 	if (tpacpi_brightness_get_raw(&b) < 0)
 		return 1;
 
-- 
1.6.2.4

