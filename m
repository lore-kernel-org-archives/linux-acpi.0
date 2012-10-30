From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 4/4] ACPI: EC: Don't count a SCI interrupt as a false one
Date: Tue, 30 Oct 2012 09:52:41 +0800
Message-ID: <1351561961-23821-4-git-send-email-feng.tang@intel.com>
References: <1351561961-23821-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab2J2ByA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Oct 2012 21:54:00 -0400
In-Reply-To: <1351561961-23821-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>

Currently when advance_transaction() is called in EC interrupt handler,
if there is nothing driver can do with the interrupt, it will be taken
as a false one.

But this is not always true, as there may be a SCI EC interrupt fired
during normal read/write operation, which should not be counted as a
false one. This patch fixes the problem.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/ec.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f272880..6bdea02 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -198,9 +198,13 @@ static void advance_transaction(struct acpi_ec *ec, u8 status)
 		t->done = true;
 	goto unlock;
 err:
-	/* false interrupt, state didn't change */
-	if (in_interrupt())
+	/*
+	 * If SCI bit is set, then don't think it's a false IRQ
+	 * otherwise will take a not handled IRQ as a false one.
+	 */
+	if (in_interrupt() && !(status & ACPI_EC_FLAG_SCI))
 		++t->irq_count;
+
 unlock:
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
-- 
1.7.9.5

