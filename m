From: akpm@linux-foundation.org
Subject: [patch 5/8] rtc: don't write RTC century when setting a wake alarm
Date: Thu, 13 Dec 2007 15:53:38 -0800
Message-ID: <200712132353.lBDNrct8024833@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50010 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760478AbXLMXy3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 18:54:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, lkml@rtr.ca, david-b@pacbell.net, mlord@pobox.com

From: Mark Lord <lkml@rtr.ca>

Fix /proc/acpi/alarm to not overwrite the RTC century field when setting a
wake alarm.  The alarm hardware doesn't have a century field, and we really
should not be fiddling with the RTC century field here.

Signed-off-by: Mark Lord <mlord@pobox.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sleep/proc.c |    5 -----
 1 file changed, 5 deletions(-)

diff -puN drivers/acpi/sleep/proc.c~rtc-dont-write-rtc-century-when-setting-a-wake-alarm drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c~rtc-dont-write-rtc-century-when-setting-a-wake-alarm
+++ a/drivers/acpi/sleep/proc.c
@@ -268,7 +268,6 @@ acpi_system_write_alarm(struct file *fil
 		day -= 31;
 	}
 	if (mo > 12) {
-		yr += 1;
 		mo -= 12;
 	}
 
@@ -277,7 +276,6 @@ acpi_system_write_alarm(struct file *fil
 	rtc_control = CMOS_READ(RTC_CONTROL);
 
 	if (adjust) {
-		yr += cmos_bcd_read(RTC_YEAR, rtc_control);
 		mo += cmos_bcd_read(RTC_MONTH, rtc_control);
 		day += cmos_bcd_read(RTC_DAY_OF_MONTH, rtc_control);
 		hr += cmos_bcd_read(RTC_HOURS, rtc_control);
@@ -304,7 +302,6 @@ acpi_system_write_alarm(struct file *fil
 		day -= 31;
 	}
 	if (mo > 12) {
-		yr++;
 		mo -= 12;
 	}
 
@@ -331,8 +328,6 @@ acpi_system_write_alarm(struct file *fil
 		cmos_bcd_write(day, acpi_gbl_FADT.day_alarm, rtc_control);
 	if (acpi_gbl_FADT.month_alarm)
 		cmos_bcd_write(mo, acpi_gbl_FADT.month_alarm, rtc_control);
-	if (acpi_gbl_FADT.century)
-		cmos_bcd_write(yr / 100, acpi_gbl_FADT.century, rtc_control);
 	/* enable the rtc alarm interrupt */
 	rtc_control |= RTC_AIE;
 	CMOS_WRITE(rtc_control, RTC_CONTROL);
_
