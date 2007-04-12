From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc6-git] workaround rtc-related acpi table bugs
Date: Thu, 12 Apr 2007 14:14:01 -0700
Message-ID: <200704121414.01828.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:28092 "HELO
	smtp106.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753826AbXDLVOG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Apr 2007 17:14:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

This works around a bug seen in some RTC-related ACPI table entries, and
tweaks related diagnostics to follow the ACPI convention.

The bug prevents misleading boot-time messages:  platforms affected by this
bug wrongly report they can support alarms up to one year in the future,
when in fact the longest alarm is just 24 hours.  That will surprise anyone
trying to use those extended alarms.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 glue.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

--- g26.orig/drivers/acpi/glue.c	2007-04-12 10:56:35.000000000 -0700
+++ g26/drivers/acpi/glue.c	2007-04-12 10:56:35.000000000 -0700
@@ -316,13 +316,19 @@ static int __init acpi_rtc_init(void)
 		rtc_info.wake_on = rtc_wake_on;
 		rtc_info.wake_off = rtc_wake_off;
 
+		if (acpi_gbl_FADT.month_alarm && !acpi_gbl_FADT.day_alarm) {
+			DBG("bogus FADT month_alarm\n");
+			acpi_gbl_FADT.month_alarm = 0;
+		}
+
 		rtc_info.rtc_day_alarm = acpi_gbl_FADT.day_alarm;
 		rtc_info.rtc_mon_alarm = acpi_gbl_FADT.month_alarm;
 		rtc_info.rtc_century = acpi_gbl_FADT.century;
 
 		/* NOTE:  S4_RTC_WAKE is NOT currently useful to Linux */
 		if (acpi_gbl_FADT.flags & ACPI_FADT_S4_RTC_WAKE)
-			printk("ACPI: RTC can wake from S4\n");
+			printk(PREFIX "RTC can wake from S4\n");
+
 
 		dev->platform_data = &rtc_info;
 
@@ -331,7 +337,7 @@ static int __init acpi_rtc_init(void)
 
 		put_device(dev);
 	} else
-		pr_debug("ACPI: RTC unavailable?\n");
+		DBG("RTC unavailable?\n");
 	return 0;
 }
 /* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
