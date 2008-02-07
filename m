From: Len Brown <lenb@kernel.org>
Subject: [PATCH 015/112] ACPI: /proc/acpi/alarm parsing: handle large numbers properly
Date: Thu,  7 Feb 2008 04:33:37 -0500
Message-ID: <087980295082ccaa816330bc69c29a2ff53a244c.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757040AbYBGJfi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:38 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yi Yang <yi.y.yang@intel.com>, Len Brown <len.brown@intel.com>

From: Yi Yang <yi.y.yang@intel.com>

In function acpi_system_write_alarm in file drivers/acpi/sleep/proc.c,
big sec, min, hr, mo, day and yr are counted twice to get reasonable
values, that is very superfluous, we can do that only once.

In additon, /proc/acpi/alarm can set a related value which can be
specified as YYYY years MM months DD days HH hours MM minutes SS
senconds, it isn't a date, so you can specify as +0000-00-00 96:00:00
, that means 3 days later, current code can't handle such a case.

This patch removes unnecessary code and does with the aforementioned
situation.

Before applying this patch:

[root@localhost /]# cat /proc/acpi/alarm
2007-12-00 00:00:00
[root@localhost /]# echo "0000-00-00 96:180:180" > /proc/acpi/alarm
[root@localhost /]# cat /proc/acpi/alarm
0007-12-02 **:**:**
[root@localhost /]#

After applying this patch:

[root@localhost ~]# echo "2007-12-00 00:00:00" > /proc/acpi/alarm
[root@localhost ~]# cat /proc/acpi/alarm
2007-12-00 00:00:00
[root@localhost ~]# echo "0000-00-00 96:180:180" > /proc/acpi/alarm
[root@localhost ~]# cat /proc/acpi/alarm
0007-12-04 03:03:00
[root@localhost ~]#

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |   41 ++++++++++-------------------------------
 1 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 1538355..e19eb0c 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -251,27 +251,6 @@ acpi_system_write_alarm(struct file *file,
 	if ((result = get_date_field(&p, &sec)))
 		goto end;
 
-	if (sec > 59) {
-		min += 1;
-		sec -= 60;
-	}
-	if (min > 59) {
-		hr += 1;
-		min -= 60;
-	}
-	if (hr > 23) {
-		day += 1;
-		hr -= 24;
-	}
-	if (day > 31) {
-		mo += 1;
-		day -= 31;
-	}
-	if (mo > 12) {
-		yr += 1;
-		mo -= 12;
-	}
-
 	spin_lock_irq(&rtc_lock);
 
 	rtc_control = CMOS_READ(RTC_CONTROL);
@@ -288,24 +267,24 @@ acpi_system_write_alarm(struct file *file,
 	spin_unlock_irq(&rtc_lock);
 
 	if (sec > 59) {
-		min++;
-		sec -= 60;
+		min += sec/60;
+		sec = sec%60;
 	}
 	if (min > 59) {
-		hr++;
-		min -= 60;
+		hr += min/60;
+		min = min%60;
 	}
 	if (hr > 23) {
-		day++;
-		hr -= 24;
+		day += hr/24;
+		hr = hr%24;
 	}
 	if (day > 31) {
-		mo++;
-		day -= 31;
+		mo += day/32;
+		day = day%32;
 	}
 	if (mo > 12) {
-		yr++;
-		mo -= 12;
+		yr += mo/13;
+		mo = mo%13;
 	}
 
 	spin_lock_irq(&rtc_lock);
-- 
1.5.4.23.gef5b9

