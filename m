From: "Chen, Huacai" <huacai.chen@intel.com>
Subject: [PATCH] RTC: Fix CMOS time error after writing /proc/acpi/alarm
Date: Mon, 23 Jun 2008 18:52:21 +0800
Message-ID: <42DFA526FC41B1429CE7279EF83C6BDC014E42D5@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29613 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622AbYFWKwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 06:52:15 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rtc-linux@googlegroups.com, lenb@kernel.org, p_gortmaker@yahoo.com, a.zummo@towertech.it
Cc: linux-kernel@vger.kernel.org

From: Huacai Chen <huacai.chen@intel.com>

When writing /proc/acpi/alarm in adjust mode, e.g. 
	echo "+0000-00-00 00:00:15" >/proc/acpi/alarm 
The "century" field should be read and added to "year" field before
writing, otherwise the CMOS time will go back to 2000 years ago, e.g.
	# cat /proc/acpi/alarm
	0008-06-21 11:38:46 
Then the system time may be reset to the date of manufacture after
rebooting. This patch fixed this issue.

Signed-off-by: Huacai Chen <huacai.chen@intel.com>
Acked-by: Pavel Machek <pavel@suse.cz>
---
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 224c57c..c9fdf7b 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -315,8 +315,11 @@ acpi_system_write_alarm(struct file *file,
 		cmos_bcd_write(day, acpi_gbl_FADT.day_alarm,
rtc_control);
 	if (acpi_gbl_FADT.month_alarm)
 		cmos_bcd_write(mo, acpi_gbl_FADT.month_alarm,
rtc_control);
-	if (acpi_gbl_FADT.century)
+	if (acpi_gbl_FADT.century) {
+		if (adjust) 
+			yr += cmos_bcd_read(acpi_gbl_FADT.century,
rtc_control) * 100;
 		cmos_bcd_write(yr / 100, acpi_gbl_FADT.century,
rtc_control);
+	}
 	/* enable the rtc alarm interrupt */
 	rtc_control |= RTC_AIE;
 	CMOS_WRITE(rtc_control, RTC_CONTROL);
---
This is for Linux 2.6.26-rc7.
