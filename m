From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/4] thinkpad-acpi: fix incorrect use of TPACPI_BRGHT_MODE_ECNVRAM
Date: Sat,  1 Aug 2009 12:04:20 -0300
Message-ID: <1249139060-15392-5-git-send-email-hmh@hmh.eng.br>
References: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42850 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849AbZHAPHJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 11:07:09 -0400
In-Reply-To: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

HBRV-based default selection of backlight control strategy didn't work
well, at least the X41 defines it but doesn't use it and I don't think
it will stop there.

Switch to a white/blacklist.  All models that have HBRV defined have
been included in the list, and initially all ATI GPUs will get
ECNVRAM, and the Intel GPUs will get UCMS_STEP.

Symptoms of incorrect backlight mode selection are:

1. Non-working backlight control through sysfs;

2. Backlight gets reset to the lowest level at every shutdown, reboot
   and when thinkpad-acpi gets unloaded;

This fixes a regression in 2.6.30, bugzilla #13826

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Reported-by: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |   61 ++++++++++++++++++++++++++--------
 1 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 18f9ee6..e856008 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5642,14 +5642,48 @@ static struct backlight_ops ibm_backlight_data = {
 
 /* --------------------------------------------------------------------- */
 
+/*
+ * These are only useful for models that have only one possibility
+ * of GPU.  If the BIOS model handles both ATI and Intel, don't use
+ * these quirks.
+ */
+#define TPACPI_BRGHT_Q_NOEC	0x0001	/* Must NOT use EC HBRV */
+#define TPACPI_BRGHT_Q_EC	0x0002  /* Should or must use EC HBRV */
+#define TPACPI_BRGHT_Q_ASK	0x8000	/* Ask for user report */
+
+static const struct tpacpi_quirk brightness_quirk_table[] __initconst = {
+	/* Models with ATI GPUs known to require ECNVRAM mode */
+	TPACPI_Q_IBM('1', 'Y', TPACPI_BRGHT_Q_EC),	/* T43/p ATI */
+
+	/* Models with ATI GPUs (waiting confirmation) */
+	TPACPI_Q_IBM('1', 'R', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('1', 'Q', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('7', '6', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('7', '8', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+
+	/* Models with Intel Extreme Graphics 2 (waiting confirmation) */
+	TPACPI_Q_IBM('1', 'V', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
+	TPACPI_Q_IBM('1', 'W', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
+	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
+
+	/* Models with Intel GMA900 */
+	TPACPI_Q_IBM('7', '0', TPACPI_BRGHT_Q_NOEC),	/* T43, R52 */
+	TPACPI_Q_IBM('7', '4', TPACPI_BRGHT_Q_NOEC),	/* X41 */
+	TPACPI_Q_IBM('7', '5', TPACPI_BRGHT_Q_NOEC),	/* X41 Tablet */
+};
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
+	unsigned long quirks;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
 	mutex_init(&brightness_mutex);
 
+	quirks = tpacpi_check_quirks(brightness_quirk_table,
+				ARRAY_SIZE(brightness_quirk_table));
+
 	/*
 	 * We always attempt to detect acpi support, so as to switch
 	 * Lenovo Vista BIOS to ACPI brightness mode even if we are not
@@ -5706,23 +5740,13 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	/* TPACPI_BRGHT_MODE_AUTO not implemented yet, just use default */
 	if (brightness_mode == TPACPI_BRGHT_MODE_AUTO ||
 	    brightness_mode == TPACPI_BRGHT_MODE_MAX) {
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_IBM) {
-			/*
-			 * IBM models that define HBRV probably have
-			 * EC-based backlight level control
-			 */
-			if (acpi_evalf(ec_handle, NULL, "HBRV", "qd"))
-				/* T40-T43, R50-R52, R50e, R51e, X31-X41 */
-				brightness_mode = TPACPI_BRGHT_MODE_ECNVRAM;
-			else
-				/* all other IBM ThinkPads */
-				brightness_mode = TPACPI_BRGHT_MODE_UCMS_STEP;
-		} else
-			/* All Lenovo ThinkPads */
+		if (quirks & TPACPI_BRGHT_Q_EC)
+			brightness_mode = TPACPI_BRGHT_MODE_ECNVRAM;
+		else
 			brightness_mode = TPACPI_BRGHT_MODE_UCMS_STEP;
 
 		dbg_printk(TPACPI_DBG_BRGHT,
-			   "selected brightness_mode=%d\n",
+			   "driver auto-selected brightness_mode=%d\n",
 			   brightness_mode);
 	}
 
@@ -5749,6 +5773,15 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_BRGHT,
 			"brightness is supported\n");
 
+	if (quirks & TPACPI_BRGHT_Q_ASK) {
+		printk(TPACPI_NOTICE
+			"brightness: will use unverified default: "
+			"brightness_mode=%d\n", brightness_mode);
+		printk(TPACPI_NOTICE
+			"brightness: please report to %s whether it works well "
+			"or not on your ThinkPad\n", TPACPI_MAIL);
+	}
+
 	ibm_backlight_device->props.max_brightness =
 				(tp_features.bright_16levels)? 15 : 7;
 	ibm_backlight_device->props.brightness = b & TP_EC_BACKLIGHT_LVLMSK;
-- 
1.6.3.3

