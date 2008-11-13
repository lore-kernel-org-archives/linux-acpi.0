From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: count interrupts only if called from interrupt
	handler.
Date: Thu, 13 Nov 2008 12:00:03 +0300
Message-ID: <20081113090003.26620.82051.stgit@thinkpad>
References: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:43635 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751653AbYKMJAG (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 04:00:06 -0500
In-Reply-To: <1226539214.4006.70.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

