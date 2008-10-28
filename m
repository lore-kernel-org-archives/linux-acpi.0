From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Tue, 28 Oct 2008 14:05:39 +0000
Message-ID: <49071C33.7030308@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:23408 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYJ1OFo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 10:05:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so963914nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2008 07:05:42 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

<http://bugzilla.kernel.org/show_bug.cgi?id=11841>
"plenty of line "ACPI: EC: non-query interrupt received,
 switching to interrupt mode" in dmesg"

GPE storm avoidance involves disabling the EC GPE during transactions.
Unfortunately we forget to re-enable EC_FLAGS_GPE_MODE afterwards.

This happens to work because we re-enable it anyway when we detect
the first confirmation interrupt of the next transaction.  However,
this causes lots of bogus "switching to interrupt mode" messages.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7f0d81c..ba47c7c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -285,6 +285,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 		/* check if we received SCI during transaction */
 		ec_check_sci(ec, acpi_ec_read_status(ec));
 		/* it is safe to enable GPE outside of transaction */
+		set_bit(EC_FLAGS_GPE_MODE, &ec->flags);
 		acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 	} else if (test_bit(EC_FLAGS_GPE_MODE, &ec->flags) &&
 		   t.irq_count > ACPI_EC_STORM_THRESHOLD) {


