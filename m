From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/2] acpi_pm.c: check for monotonicity
Date: Mon, 18 Aug 2008 21:05:11 +0200
Message-ID: <1219086311-13365-2-git-send-email-linux@dominikbrodowski.net>
References: <20080818190325.GA12581@comet.dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:40471 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756595AbYHRTFU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Aug 2008 15:05:20 -0400
In-Reply-To: <20080818190325.GA12581@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

Expand the check for monotonicity by doing ten tests instead of one.

Applies on top of "acpi_pm.c: use proper read function also in errata mode."

CC: John Stultz <johnstul@us.ibm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/clocksource/acpi_pm.c |   42 ++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 2c00edd..f05c4fb 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -178,7 +178,7 @@ static int verify_pmtmr_rate(void)
 static int __init init_acpi_pm_clocksource(void)
 {
 	cycle_t value1, value2;
-	unsigned int i;
+	unsigned int i, j, good = 0;
 
 	if (!pmtmr_ioport)
 		return -ENODEV;
@@ -187,24 +187,32 @@ static int __init init_acpi_pm_clocksource(void)
 						clocksource_acpi_pm.shift);
 
 	/* "verify" this timing source: */
-	value1 = clocksource_acpi_pm.read();
-	for (i = 0; i < 10000; i++) {
-		value2 = clocksource_acpi_pm.read();
-		if (value2 == value1)
-			continue;
-		if (value2 > value1)
-			goto pm_good;
-		if ((value2 < value1) && ((value2) < 0xFFF))
-			goto pm_good;
-		printk(KERN_INFO "PM-Timer had inconsistent results:"
-			" 0x%#llx, 0x%#llx - aborting.\n", value1, value2);
-		return -EINVAL;
+	for (j = 0; j < 10; j++) {
+		value1 = clocksource_acpi_pm.read();
+		for (i = 0; i < 10000; i++) {
+			value2 = clocksource_acpi_pm.read();
+			if (value2 == value1)
+				continue;
+			if (value2 > value1)
+				good++;
+				break;
+			if ((value2 < value1) && ((value2) < 0xFFF))
+				good++;
+				break;
+			printk(KERN_INFO "PM-Timer had inconsistent results:"
+			       " 0x%#llx, 0x%#llx - aborting.\n",
+			       value1, value2);
+			return -EINVAL;
+		}
+		udelay(300 * i);
+	}
+
+	if (good != 10) {
+		printk(KERN_INFO "PM-Timer had no reasonable result:"
+		       " 0x%#llx - aborting.\n", value1);
+		return -ENODEV;
 	}
-	printk(KERN_INFO "PM-Timer had no reasonable result:"
-			" 0x%#llx - aborting.\n", value1);
-	return -ENODEV;
 
-pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
-- 
1.5.4.3

