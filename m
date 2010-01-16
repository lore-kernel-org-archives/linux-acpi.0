From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/16] ACPI: Remove unnecessary cast.
Date: Sat, 16 Jan 2010 02:32:59 -0500
Message-ID: <070a24f4d238612bede515023893b18f494774c4.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50147 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0APHd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:26 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB0026HWZDKQ47@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:19 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Len Brown <len.brown@intel.com>

From: H Hartley Sweeten <hartleys@visionengravers.com>

The struct seq_file 'private' member is a void *, the cast is not needed.
Also, remove an extra whitespace line.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_thermal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 140c5c5..6deafb4 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -443,8 +443,7 @@ struct thermal_cooling_device_ops processor_cooling_ops = {
 #ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_limit_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
-
+	struct acpi_processor *pr = seq->private;
 
 	if (!pr)
 		goto end;
-- 
1.6.0.6

