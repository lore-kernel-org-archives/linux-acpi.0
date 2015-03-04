From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] acpi: The count field of counter_show() function should be an unsigned value
Date: Wed,  4 Mar 2015 18:48:35 +0800
Message-ID: <1425466115-26306-1-git-send-email-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36575 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbCDKtR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2015 05:49:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Nan Li <nli@suse.com>

From: Nan Li <nli@suse.com>

The count field is an unsigned 32bit value, and the
counter_show() function should also treat it as a unsigned
value.

Otherwise the counter may show negative number as we found on a
machine:
...
gpe23:        0   invalid
gpe24: -2071733   enabled
gpe25:        0   invalid
...
gpe_all: -2070980
sci: -2070949

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>
Signed-off-by: Nan Li <nli@suse.com>
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 13e577c..0876d77 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -527,7 +527,7 @@ static ssize_t counter_show(struct kobject *kobj,
 	    acpi_irq_not_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 	    acpi_gpe_count;
-	size = sprintf(buf, "%8d", all_counters[index].count);
+	size = sprintf(buf, "%8u", all_counters[index].count);
 
 	/* "gpe_all" or "sci" */
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
-- 
1.8.4.5

