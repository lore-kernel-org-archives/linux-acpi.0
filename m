From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 6/7 v4] trace, eMCA: Add a knob to adjust where to save event log
Date: Tue, 27 May 2014 23:27:02 -0400
Message-ID: <1401247622-21948-1-git-send-email-gong.chen@linux.intel.com>
References: <20140522111140.GH4383@pd.tnic>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58812 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbaE1Dy6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 May 2014 23:54:58 -0400
In-Reply-To: <20140522111140.GH4383@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid saving two copies for one H/W event, add a new
file under debugfs to control how to save event log.
Once this file is opened, the perf/trace will be used,
in the meanwhile, kernel will stop to print event log
to the console. On the other hand, if this file is closed,
kernel will print event log to the console again.

v4 -> v3: format adjustment.
v3 -> v2: minor adjustment to make flow cleanly.
v2 -> v1: move counter operation from *read* to *open*.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 8815b73..07a6fe8 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/ras.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -181,7 +182,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	estatus->block_status = 0;
 
 	tmp = (struct acpi_generic_status *)elog_buf;
-	print_extlog_rcd(NULL, tmp, cpu);
+
+	if (!ras_userspace_consumers()) {
+		print_extlog_rcd(NULL, tmp, cpu);
+		goto out;
+	}
 
 	/* log event via trace */
 	err_number++;
@@ -198,6 +203,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 					  (u8)gdata->error_severity, mem_err);
 	}
 
+out:
 	return NOTIFY_STOP;
 }
 
-- 
2.0.0.rc2

