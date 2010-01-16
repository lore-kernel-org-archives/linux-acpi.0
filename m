From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/16] ACPI: EC: Add wait for irq storm
Date: Sat, 16 Jan 2010 02:32:57 -0500
Message-ID: <54070101f86ca9a6e9ba243c999d144721ec3db7.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50147 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab0APHdZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB002CCWZCKU57@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:18 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Merge of poll and irq modes accelerated EC transaction, so
that keyboard starts to suffer again. Add msleep(1) into
transaction path for the storm to allow keyboard controller
to do its job.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14747

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0473309..d6471bb 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -259,7 +259,6 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
 	spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	ret = ec_poll(ec);
-	pr_debug(PREFIX "transaction end\n");
 	spin_lock_irqsave(&ec->curr_lock, tmp);
 	ec->curr = NULL;
 	spin_unlock_irqrestore(&ec->curr_lock, tmp);
@@ -316,6 +315,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	/* check if we received SCI during transaction */
 	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
+		msleep(1);
 		/* it is safe to enable GPE outside of transaction */
 		acpi_enable_gpe(NULL, ec->gpe);
 	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
@@ -323,6 +323,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 			"transactions will use polling mode\n");
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
 	}
+	pr_debug(PREFIX "transaction end\n");
 end:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
-- 
1.6.0.6

