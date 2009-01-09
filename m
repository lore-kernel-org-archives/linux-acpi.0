From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/94] /proc/acpi/alarm: handle day-of-month wraparound on
 readback
Date: Fri, 09 Jan 2009 04:26:05 -0500
Message-ID: <48452e5f99ab35d643df0463b6ad11aea8ea7bdc.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56325 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZAIJ1n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:43 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700HIH67UWCC2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:26:19 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mark Lord <lkml@rtr.ca>, Mark Lord <mlord@pobox.com>, Len Brown <len.brown@intel.com>

From: Mark Lord <lkml@rtr.ca>

Fix month wrap issue with readback from /proc/acpi/alarm
This bug has been around *forever*.

  $ echo '2008-12-01 10:36:20' > /proc/acpi/alarm
  $ cat /proc/acpi/alarm
  2008-11-01 10:36:20

Note how the readback above shows the month incorrectly
when the alarm is set in the *next* calendar month.
But with this patch applied, it shows the correct month (12).

Signed-off-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |   53 +++++++++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4dbc227..232d4b6 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -84,12 +84,15 @@ acpi_system_write_sleep(struct file *file,
 #define	HAVE_ACPI_LEGACY_ALARM
 #endif
 
+static u32 cmos_bcd_read(int offset, int rtc_control);
+
 #ifdef	HAVE_ACPI_LEGACY_ALARM
 
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 {
 	u32 sec, min, hr;
 	u32 day, mo, yr, cent = 0;
+	u32 today = 0;
 	unsigned char rtc_control = 0;
 	unsigned long flags;
 
@@ -97,38 +100,32 @@ static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 
 	spin_lock_irqsave(&rtc_lock, flags);
 
-	sec = CMOS_READ(RTC_SECONDS_ALARM);
-	min = CMOS_READ(RTC_MINUTES_ALARM);
-	hr = CMOS_READ(RTC_HOURS_ALARM);
 	rtc_control = CMOS_READ(RTC_CONTROL);
+	sec = cmos_bcd_read(RTC_SECONDS_ALARM, rtc_control);
+	min = cmos_bcd_read(RTC_MINUTES_ALARM, rtc_control);
+	hr = cmos_bcd_read(RTC_HOURS_ALARM, rtc_control);
 
 	/* If we ever get an FACP with proper values... */
-	if (acpi_gbl_FADT.day_alarm)
+	if (acpi_gbl_FADT.day_alarm) {
 		/* ACPI spec: only low 6 its should be cared */
 		day = CMOS_READ(acpi_gbl_FADT.day_alarm) & 0x3F;
-	else
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+			day = bcd2bin(day);
+	} else
+		day = cmos_bcd_read(RTC_DAY_OF_MONTH, rtc_control);
 	if (acpi_gbl_FADT.month_alarm)
-		mo = CMOS_READ(acpi_gbl_FADT.month_alarm);
-	else
-		mo = CMOS_READ(RTC_MONTH);
+		mo = cmos_bcd_read(acpi_gbl_FADT.month_alarm, rtc_control);
+	else {
+		mo = cmos_bcd_read(RTC_MONTH, rtc_control);
+		today = cmos_bcd_read(RTC_DAY_OF_MONTH, rtc_control);
+	}
 	if (acpi_gbl_FADT.century)
-		cent = CMOS_READ(acpi_gbl_FADT.century);
+		cent = cmos_bcd_read(acpi_gbl_FADT.century, rtc_control);
 
-	yr = CMOS_READ(RTC_YEAR);
+	yr = cmos_bcd_read(RTC_YEAR, rtc_control);
 
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
-	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-		sec = bcd2bin(sec);
-		min = bcd2bin(min);
-		hr = bcd2bin(hr);
-		day = bcd2bin(day);
-		mo = bcd2bin(mo);
-		yr = bcd2bin(yr);
-		cent = bcd2bin(cent);
-	}
-
 	/* we're trusting the FADT (see above) */
 	if (!acpi_gbl_FADT.century)
 		/* If we're not trusting the FADT, we should at least make it
@@ -153,6 +150,20 @@ static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 	else
 		yr += cent * 100;
 
+	/*
+	 * Show correct dates for alarms up to a month into the future.
+	 * This solves issues for nearly all situations with the common
+	 * 30-day alarm clocks in PC hardware.
+	 */
+	if (day < today) {
+		if (mo < 12) {
+			mo += 1;
+		} else {
+			mo = 1;
+			yr += 1;
+		}
+	}
+
 	seq_printf(seq, "%4.4u-", yr);
 	(mo > 12) ? seq_puts(seq, "**-") : seq_printf(seq, "%2.2u-", mo);
 	(day > 31) ? seq_puts(seq, "** ") : seq_printf(seq, "%2.2u ", day);
-- 
1.5.6.6

