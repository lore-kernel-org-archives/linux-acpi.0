From: Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] fix math in acpi_system_write_alarm() (resend)
Date: Fri, 26 Sep 2008 17:32:00 -0600
Message-ID: <20080926233200.GB6061@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:55084 "EHLO
	SG2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbYIZX3v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 19:29:51 -0400
Received: from mail79-sin (localhost.localdomain [127.0.0.1])	by
 mail79-sin-R.bigfish.com (Postfix) with ESMTP id 87BBE1BA8182	for
 <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 23:29:49 +0000 (UTC)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail79-sin.bigfish.com (Postfix) with
 ESMTP id 05753EB007C	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008
 23:29:44 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m8QNTdS9002942	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 18:29:42
 -0500
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])	by
 ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 280DE16A064F	for
 <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2008 18:29:24 -0500 (CDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

This patch fixes the day of month math in acpi_system_write_alarm().
The previous code assumed that there were 31 days in every month.
We caught this on June 30 when the month changed, but the system
stayed suspended waiting for June 31st.

I know /proc/acpi/alarm is being deprecated, but its still there,
and I think as long as somebody can use it in anger, it should
correct.

Thanks,
Jordan
-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

--WYTEVAkct0FjGQmd
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: inline; filename="fix-acpi-alarm.patch"

[PATCH] ACPI: Make sure that the alarm math is correct

From: Jordan Crouse <jordan.crouse@amd.com>

The current /proc/acpi/alarm math assumes that every month has 31 days.
This patch figures out the correct number of days in the month.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/acpi/sleep/proc.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4ebbba2..0e75d79 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -283,10 +283,31 @@ acpi_system_write_alarm(struct file *file,
 		day += hr/24;
 		hr = hr%24;
 	}
-	if (day > 31) {
-		mo += day/32;
-		day = day%32;
+
+	while (1) {
+		int tmo  = mo % 13;
+		int dinmo;
+
+		if (tmo == 2) {
+			if (((yr % 4 == 0) && (yr % 100 != 0)) ||
+			    (yr % 400 == 0))
+				dinmo = 29;
+			else
+				dinmo = 28;
+		} else if (tmo == 1 || tmo == 3 || tmo == 5 ||
+			   tmo == 7 || tmo == 8 || tmo == 10 ||
+			   tmo == 12)
+			 dinmo = 31;
+		else
+			dinmo = 30;
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

--WYTEVAkct0FjGQmd--
