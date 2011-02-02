From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH 1/2] ACPI: make acpi_pad /sys output more readable
Date: Wed,  2 Feb 2011 23:26:58 +0000 (UTC)
Message-ID: <20110202232425.22145.40776.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:39838 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab1BBX07 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Feb 2011 18:26:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Make /sys output from acpi_pad more readable.

Before the fix:
# cat idlecpus idlepct rrtime
00000000510

After the fix:
# cat idlecpus idlepct rrtime
00000000
5
10

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
---
 drivers/acpi/acpi_pad.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 6afceb3..474be3a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -298,7 +298,7 @@ static ssize_t acpi_pad_rrtime_store(struct device *dev,
 static ssize_t acpi_pad_rrtime_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d", round_robin_time);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", round_robin_time);
 }
 static DEVICE_ATTR(rrtime, S_IRUGO|S_IWUSR,
 	acpi_pad_rrtime_show,
@@ -321,7 +321,7 @@ static ssize_t acpi_pad_idlepct_store(struct device *dev,
 static ssize_t acpi_pad_idlepct_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d", idle_pct);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", idle_pct);
 }
 static DEVICE_ATTR(idlepct, S_IRUGO|S_IWUSR,
 	acpi_pad_idlepct_show,
@@ -342,8 +342,11 @@ static ssize_t acpi_pad_idlecpus_store(struct device *dev,
 static ssize_t acpi_pad_idlecpus_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return cpumask_scnprintf(buf, PAGE_SIZE,
-		to_cpumask(pad_busy_cpus_bits));
+	int n = 0;
+	n = cpumask_scnprintf(buf, PAGE_SIZE-2, to_cpumask(pad_busy_cpus_bits));
+	buf[n++] = '\n';
+	buf[n] = '\0';
+	return n;
 }
 static DEVICE_ATTR(idlecpus, S_IRUGO|S_IWUSR,
 	acpi_pad_idlecpus_show,
-- 
1.7.1.2

