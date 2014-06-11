From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 6/7 v4] trace, eMCA: Add a knob to adjust where to save event log
Date: Wed, 11 Jun 2014 04:34:50 -0400
Message-ID: <1402475691-30045-7-git-send-email-gong.chen@linux.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31757 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843AbaFKJDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2014 05:03:43 -0400
In-Reply-To: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, rostedt@goodmis.org
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

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
index e61da95..a99d4a6 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
+#include <linux/ras.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 
@@ -154,7 +155,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	estatus->block_status = 0;
 
 	tmp = (struct acpi_generic_status *)elog_buf;
-	print_extlog_rcd(NULL, tmp, cpu);
+
+	if (!ras_userspace_consumers()) {
+		print_extlog_rcd(NULL, tmp, cpu);
+		goto out;
+	}
 
 	/* log event via trace */
 	err_seq++;
@@ -171,6 +176,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 					       (u8)gdata->error_severity);
 	}
 
+out:
 	return NOTIFY_STOP;
 }
 
-- 
2.0.0.rc2

