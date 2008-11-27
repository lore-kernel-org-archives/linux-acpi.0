From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/11] ACPI: EC: count interrupts only if called from interrupt
 handler.
Date: Thu, 27 Nov 2008 02:25:06 -0500
Message-ID: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:42184 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbYK0HZT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:19 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ002B8DY6UBBC@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:19 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

fix 2.6.28 EC interrupt storm regression

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index cf41f9f..30f3ef2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -219,7 +219,8 @@ static void gpe_transaction(struct acpi_ec *ec, u8 status)
 	goto unlock;
 err:
 	/* false interrupt, state didn't change */
-	++ec->curr->irq_count;
+	if (in_interrupt())
+		++ec->curr->irq_count;
 unlock:
 	spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
-- 
1.5.6.5

