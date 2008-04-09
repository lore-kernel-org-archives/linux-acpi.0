From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [PATCH 2/3] Call RTC wake_on hook function when alarm is
	enabled
Date: Wed, 09 Apr 2008 14:34:54 +0800
Message-ID: <1207722894.5997.18.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbYDIGlc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Apr 2008 02:41:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, david-b@pacbell.net

Subject: ACPI: Call RTC wake_on hook function when alarm is enabled
>From : Zhao Yakui <yakui.zhao@intel.com>

According to ACPI spec the FIXED_RTC bit of acpi fadt feature flag
indicates whether RTC wake status is supported in fixed register space.
Zero indicates the RTC wake status is supported in fixed register space.
In such case the rtc_info should be initialized:
        rtc_info.wake_on = rtc_wake_on
        rtc_info.wake_off = rtc_wake_off;


In my test if RTC_wake_on hook function isn't called, the RTC alarm can 
be fired only once.( The Fixed_RTC event is enabled in the rtc_wake_on
hook function for rtc-cmos driver) This is caused by the following :
      The Fixed_RTC event is enabled when the Fixed_RTC event handler is 
      installed. When the RTC alarm is set, it can be fired for the first time.
      But after RTC alarm is fired, the Fixed_RTC event is disabled in the rtc
      event handler. When the RTC alarm is set again, the Fixed_RTC event is 
      still disabled and no RTC alarm can be fired again.

So it is necessary to call the rtc_wake_on hook function when RTC alarm is
enabled.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/glue.c    |   14 ++++++++++++--
 drivers/rtc/rtc-cmos.c |    8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -309,8 +309,18 @@ static int __init acpi_rtc_init(void)
 
 	if (dev) {
 		rtc_wake_setup();
-		rtc_info.wake_on = rtc_wake_on;
-		rtc_info.wake_off = rtc_wake_off;
+		/*
+		 * According to the ACPI spec the FIXED_RTC bit indicates
+		 * whether RTC wake status is supported in Fixed Register
+		 * space. 0  supported; 1 not supported.
+		 * If it is zero, it means that RTC wake status is supported
+		 * in fixed register space and rtc_info.wake_on/off should be
+		 * set. Otherwise they should be cleared.
+		 */
+		if (!(acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)) {
+			rtc_info.wake_on = rtc_wake_on;
+			rtc_info.wake_off = rtc_wake_off;
+		}
 
 		/* workaround bug in some ACPI tables */
 		if (acpi_gbl_FADT.month_alarm && !acpi_gbl_FADT.day_alarm) {
Index: linux-2.6/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-2.6.orig/drivers/rtc/rtc-cmos.c
+++ linux-2.6/drivers/rtc/rtc-cmos.c
@@ -248,6 +248,14 @@ static int cmos_set_alarm(struct device 
 
 	spin_unlock_irq(&rtc_lock);
 
+	/*
+	 * When the wake_on hook function exists, it is necessary to
+	 * call the wake_on hook function in order to enable RTC alarm.
+	 */
+	if (t->enabled)
+		if (cmos->wake_on)
+			cmos->wake_on(dev);
+
 	return 0;
 }
 


