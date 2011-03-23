From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/42] ACPI: make acpi_pad /sys output more readable
Date: Wed, 23 Mar 2011 02:42:54 -0400
Message-ID: <32297abd90a5d181e8e026c8b8e65ef41e9ffc07.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37011 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab1CWHHh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 03:07:37 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII000XA14FEFN6@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 02:07:37 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Naga Chumbalkar <nagananda.chumbalkar@hp.com>, Len Brown <len.brown@intel.com>

From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.4.1.343.ga91df

