From: Adrian Bunk <bunk@kernel.org>
Subject: [1/17] acpi: use bcd2bin/bin2bcd
Date: Fri, 8 Aug 2008 19:34:30 +0300
Message-ID: <20080808163430.GH14495@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:47998 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbYHHQgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Aug 2008 12:36:05 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

This patch changes ACPI to use the new bcd2bin/bin2bcd functions instead 
of the obsolete BCD_TO_BIN/BIN_TO_BCD macros.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/acpi/sleep/proc.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

1818b917286e40500ca7c08f5f46e5c421c4f0e7 
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4ebbba2..0fb4cbd 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -120,13 +120,13 @@ static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-		BCD_TO_BIN(sec);
-		BCD_TO_BIN(min);
-		BCD_TO_BIN(hr);
-		BCD_TO_BIN(day);
-		BCD_TO_BIN(mo);
-		BCD_TO_BIN(yr);
-		BCD_TO_BIN(cent);
+		sec = bcd2bin(sec);
+		min = bcd2bin(min);
+		hr = bcd2bin(hr);
+		day = bcd2bin(day);
+		mo = bcd2bin(mo);
+		yr = bcd2bin(yr);
+		cent = bcd2bin(cent);
 	}
 
 	/* we're trusting the FADT (see above) */
@@ -204,7 +204,7 @@ static u32 cmos_bcd_read(int offset, int rtc_control)
 {
 	u32 val = CMOS_READ(offset);
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		BCD_TO_BIN(val);
+		val = bcd2bin(val);
 	return val;
 }
 
@@ -212,7 +212,7 @@ static u32 cmos_bcd_read(int offset, int rtc_control)
 static void cmos_bcd_write(u32 val, int offset, int rtc_control)
 {
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		BIN_TO_BCD(val);
+		val = bin2bcd(val);
 	CMOS_WRITE(val, offset);
 }
 


