From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 1/2] [RTC] : Fix the error in the function of cmos_set_alarm
Date: Fri, 11 Apr 2008 20:36:49 +0800
Message-ID: <1207917409.9448.38.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26683 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757649AbYDKEtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Apr 2008 00:49:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david-b@pacbell.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

Subject: RTC :Fix the error in the function of cmos_set_alarm  
>From : Zhao Yakui <yakui.zhao@intel.com>

There is a bug in the function of cmos_set_alarm. 
RTC alarm time for October can't be set correctly. 
For October: 0x0A will be written into the RTC region (MONTH_ALARM) 
in current kernel. But in fact 0x10 should be written.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/rtc/rtc-cmos.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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


