From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: Don't do transaction from GPE handler in poll mode.
Date: Tue, 11 Nov 2008 11:09:22 +0300
Message-ID: <20081111080922.11705.34637.stgit@thinkpad>
References: <20081111080614.11705.79007.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:45439 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884AbYKKIJ1 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 03:09:27 -0500
In-Reply-To: <20081111080614.11705.79007.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Referencies: http://bugzilla.kernel.org/show_bug.cgi?id=12004

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 628b076..b1dcc08 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -576,11 +576,15 @@ static u32 acpi_ec_gpe_handler(void *data)
 	pr_debug(PREFIX "~~~> interrupt\n");
 	status = acpi_ec_read_status(ec);
 
-	gpe_transaction(ec, status);
-	if (ec_transaction_done(ec) && (status & ACPI_EC_FLAG_IBF) == 0)
-		wake_up(&ec->wait);
+	if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags)) {
+		gpe_transaction(ec, status);
+		if (ec_transaction_done(ec) &&
+		    (status & ACPI_EC_FLAG_IBF) == 0)
+			wake_up(&ec->wait);
+	}
 
 	ec_check_sci(ec, status);
+#if 0
 	if (!test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 	    !test_bit(EC_FLAGS_NO_GPE, &ec->flags)) {
 		/* this is non-query, must be confirmation */
@@ -589,6 +593,7 @@ static u32 acpi_ec_gpe_handler(void *data)
 				" switching to interrupt mode\n");
 		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 	}
+#endif
 	return ACPI_INTERRUPT_HANDLED;
 }
 

