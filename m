From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: Restart command even if no interrupts from EC
Date: Fri, 02 Oct 2009 02:53:15 +0400
Message-ID: <20091001225315.31207.88668.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37149 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754100AbZJAWxN (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 1 Oct 2009 18:53:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

EC may forget a command without sending any "reset" interrupt,
thus we need to lessen the requirement for transaction restart.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14247
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da7da37..9c34515 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -234,10 +234,8 @@ static int ec_poll(struct acpi_ec *ec)
 			}
 			advance_transaction(ec, acpi_ec_read_status(ec));
 		} while (time_before(jiffies, delay));
-		if (!ec->curr->irq_count ||
-		    (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF))
+		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
 			break;
-		/* try restart command if we get any false interrupts */
 		pr_debug(PREFIX "controller reset, restart transaction\n");
 		spin_lock_irqsave(&ec->curr_lock, flags);
 		start_transaction(ec);

