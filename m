From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save event log
Date: Thu, 15 May 2014 04:30:45 -0400
Message-ID: <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1435 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaEOJET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 05:04:19 -0400
In-Reply-To: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid saving two copies for one H/W event, add a new
file under debugfs to control how to save event log.
Once this file is opened, the perf/trace will be used,
in the meanwhile, kernel will stop to print event log
to the console. On the other hand, if this file is closed,
kernel will print event log to the console again.

v3 -> v2: minor adjustment to make flow cleanly.
v2 -> v1: move counter operation from *read* to *open*.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index b1dcb5b..c1dab37 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/ras.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -185,7 +186,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	estatus->block_status = 0;
 
 	tmp = (struct acpi_generic_status *)elog_buf;
-	print_extlog_rcd(NULL, tmp, cpu);
+
+	if (ras_userspace_consumers() == 0) {
+		print_extlog_rcd(NULL, tmp, cpu);
+		goto out;
+	}
 
 	/* log event via trace */
 	err_count++;
@@ -202,6 +207,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 					  gdata->error_severity, mem_err);
 	}
 
+out:
 	return NOTIFY_STOP;
 }
 
-- 
2.0.0.rc0

