From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/21] ACPI: EC: make kernel messages more useful when GPE
 storm is detected
Date: Thu, 06 Nov 2008 23:39:25 -0500
Message-ID: <be11b915c297a6ccea17356d689d60734967f5f6.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38214 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYKGEjh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:37 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9Y002L64XYRIV1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:35 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Make sure we can tell if the GPE storm workaround gets activated,
and avoid flooding the logs afterwards.

http://bugzilla.kernel.org/show_bug.cgi?id=11841
"plenty of line "ACPI: EC: non-query interrupt received,
 switching to interrupt mode" in dmesg"

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3ef5b79..b340e08 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -286,7 +286,8 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   t->irq_count > ACPI_EC_STORM_THRESHOLD) {
-		pr_debug(PREFIX "GPE storm detected\n");
+		pr_info(PREFIX "GPE storm detected, "
+			"transactions will use polling mode\n");
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
 	}
 	return ret;
@@ -566,9 +567,15 @@ static u32 acpi_ec_gpe_handler(void *data)
 	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
 		/* this is non-query, must be confirmation */
-		if (printk_ratelimit())
-			pr_info(PREFIX "non-query interrupt received,"
+		if (!test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+			if (printk_ratelimit())
+				pr_info(PREFIX "non-query interrupt received,"
+					" switching to interrupt mode\n");
+		} else {
+			/* hush, STORM switches the mode every transaction */
+			pr_debug(PREFIX "non-query interrupt received,"
 				" switching to interrupt mode\n");
+		}
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	}
 	return ACPI_INTERRUPT_HANDLED;
-- 
1.5.6.5

