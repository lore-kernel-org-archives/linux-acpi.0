From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: EC: Check for IBF=0 periodically if not in GPE mode
Date: Thu, 16 Oct 2008 02:02:33 +0400
Message-ID: <20081015220232.32042.36999.stgit@thinkpad>
References: <48F379C4.9070105@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58013 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752920AbYJOWCe (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 15 Oct 2008 18:02:34 -0400
In-Reply-To: <48F379C4.9070105@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 69f5f78..f9c0782 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -300,6 +300,18 @@ static int ec_check_ibf0(struct acpi_ec *ec)
 	return (status & ACPI_EC_FLAG_IBF) == 0;
 }
 
+static int ec_wait_ibf0(struct acpi_ec *ec)
+{
+	unsigned long delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
+	/* interrupt wait manually if GPE mode is not active */
+	unsigned long timeout = test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ?
+		msecs_to_jiffies(ACPI_EC_DELAY) : msecs_to_jiffies(1);
+	while (time_before(jiffies, delay))
+		if (wait_event_timeout(ec->wait, ec_check_ibf0(ec), timeout))
+			return 0;
+	return -ETIME;
+}
+
 static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
 			       int force_poll)
 {
@@ -317,8 +329,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t,
 			goto unlock;
 		}
 	}
-	if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
-				msecs_to_jiffies(ACPI_EC_DELAY))) {
+	if (ec_wait_ibf0(ec)) {
 		pr_err(PREFIX "input buffer is not empty, "
 				"aborting transaction\n");
 		status = -ETIME;

