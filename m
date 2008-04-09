From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [PATCH 1/3] Allow to override the RTC alarm time
Date: Wed, 09 Apr 2008 14:34:11 +0800
Message-ID: <1207722851.5997.16.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15712 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbYDIGlK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 02:41:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, david-b@pacbell.net

Subject: ACPI: Allow to override the RTC alarm time 
>From : Zhao Yakui <yakui.zhao@intel.com>

In current kernel when RTC alarm time is set and not fired,
it is impossible to set RTC alarm again. But it is more
reasonable that the RTC alarm time can be overrided.

At the same time there is a bug in the function of 
cmos_set_alarm. RTC alarm time for October can't be set 
correctly. 
For October: 0x0A will be written into the RTC region
(MONTH_ALARM). But in fact 0x10 should be written.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/rtc/rtc-cmos.c  |    5 ++---
 drivers/rtc/rtc-sysfs.c |    2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-2.6.orig/drivers/rtc/rtc-cmos.c
+++ linux-2.6/drivers/rtc/rtc-cmos.c
@@ -198,9 +198,8 @@ static int cmos_set_alarm(struct device 
 
 	/* Writing 0xff means "don't care" or "match all".  */
 
-	mon = t->time.tm_mon;
-	mon = (mon < 12) ? BIN2BCD(mon) : 0xff;
-	mon++;
+	mon = t->time.tm_mon + 1;
+	mon = (mon <= 12) ? BIN2BCD(mon) : 0xff;
 
 	mday = t->time.tm_mday;
 	mday = (mday >= 1 && mday <= 31) ? BIN2BCD(mday) : 0xff;
Index: linux-2.6/drivers/rtc/rtc-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/rtc/rtc-sysfs.c
+++ linux-2.6/drivers/rtc/rtc-sysfs.c
@@ -163,8 +163,6 @@ rtc_sysfs_set_wakealarm(struct device *d
 		retval = rtc_read_alarm(rtc, &alm);
 		if (retval < 0)
 			return retval;
-		if (alm.enabled)
-			return -EBUSY;
 
 		alm.enabled = 1;
 	} else {


