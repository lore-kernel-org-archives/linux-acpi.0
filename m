From: Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] ACPI: Make sure that the alarm math is correct
Date: Thu, 10 Jul 2008 09:26:03 -0600
Message-ID: <20080710152603.GA14027@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:33117 "EHLO
	VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbYGJPXl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 11:23:41 -0400
Received: from mail210-va3 (localhost.localdomain [127.0.0.1])	by
 mail210-va3-R.bigfish.com (Postfix) with ESMTP id 6D2D412204DA	for
 <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 15:23:40 +0000 (UTC)
Received: from svlb1extmailp02.amd.com (unknown [139.95.251.11])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail210-va3.bigfish.com (Postfix) with ESMTP id 71D203B8053	for
 <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 15:23:38 +0000 (UTC)
Received: from svlb1twp02.amd.com ([139.95.250.35])	by svlb1extmailp02.amd.com
 (Switch-3.2.7/Switch-3.2.7) with ESMTP id m6AFNWrp012536	for
 <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 08:23:35 -0700
Received: from SSVLEXBH2.amd.com (ssvlexbh2.amd.com [139.95.53.183])	by
 svlb1twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2423B1103C5	for
 <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 08:23:26 -0700 (PDT)
Received: from cosmic.amd.com (cosmic.amd.com [165.204.144.72])	by
 ldcmail.amd.com (Postfix) with ESMTP id E1DC322F4	for
 <linux-acpi@vger.kernel.org>; Thu, 10 Jul 2008 09:23:01 -0600 (MDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On June 30, we were running some suspend/resume cycles with an 
alarm time set through /proc/acpi/alarm.  We discovered the next morning
that all of the boxes were suspended.  Investigation showed that they
all had an alarm set for June 31.. :)

It turns out the /proc/acpi/alarm code assumes 31 days for all months.
The attached patch does the correct math.  I know this is a deprecated
interface, but I figure that as long as the code is living in Linus's
tree, it should be correct.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

--6TrnltStXW4iwmi0
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: inline; filename="fix-acpi-alarm.patch"

[PATCH] ACPI: Make sure that the alarm math is correct

From: Jordan Crouse <jordan.crouse@amd.com>

The current /proc/acpi/alarm math assumes that every month has 31 days.
This patch figures out the correct number of days in the month.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/acpi/sleep/proc.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4ebbba2..19c150b 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -283,10 +283,32 @@ acpi_system_write_alarm(struct file *file,
 		day += hr/24;
 		hr = hr%24;
 	}
-	if (day > 31) {
-		mo += day/32;
-		day = day%32;
+
+	while(1) {
+		int tmo  = mo % 13;
+		int dinmo;
+
+		if (tmo == 2) {
+			if (((yr % 4 == 0) && (yr % 100 != 0)) ||
+			    (yr % 400 == 0))
+				dinmo=29;
+			else
+				dinmo=28;
+		}
+		else if (tmo == 1 || tmo == 3 || tmo == 5 ||
+			 tmo == 7 || tmo == 8 || tmo == 10 ||
+			 tmo == 12)
+			 dinmo=31;
+		else
+			dinmo=30;
+
+		if (day <= dinmo)
+			break;
+
+		mo  += 1;
+		day -= dinmo;
 	}
+
 	if (mo > 12) {
 		yr += mo/13;
 		mo = mo%13;

--6TrnltStXW4iwmi0--
