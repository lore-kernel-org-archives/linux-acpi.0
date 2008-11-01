From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: ACPI: EC: make kernel messages more useful when GPE storm is detected
Date: Sat, 01 Nov 2008 11:05:26 +0000
Message-ID: <490C37F6.5060000@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:50761 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYKALFq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Nov 2008 07:05:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so711233nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 01 Nov 2008 04:05:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Make sure we can tell if the GPE storm workaround gets activated,
and avoid flooding the logs afterwards.

<http://bugzilla.kernel.org/show_bug.cgi?id=11841>
"plenty of line "ACPI: EC: non-query interrupt received,
 switching to interrupt mode" in dmesg"

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ef42316..139046c 100644
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



