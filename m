From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/6] ACPI / EC: Do not use acpi_set_gpe
Date: Fri, 25 Jun 2010 01:21:42 +0200
Message-ID: <201006250121.42506.rjw@sisk.pl>
References: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47189 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab0FXX0J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jun 2010 19:26:09 -0400
In-Reply-To: <201006250117.45148.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, len.brown@intel.com, Alexey Starikovskiy <astarikovskiy@suse.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

The EC driver is the last user of acpi_set_gpe() and since it is
guaranteed that the EC GPE will not be shared, acpi_disable_gpe()
and acpi_enable_gpe() may be used for disabling the GPE temporarilty
if a GPE storm is detected and re-enabling it during EC transactions.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -313,11 +313,8 @@ static int acpi_ec_transaction(struct ac
 	pr_debug(PREFIX "transaction start\n");
 	/* disable GPE during transaction if storm is detected */
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/*
-		 * It has to be disabled at the hardware level regardless of the
-		 * GPE reference counting, so that it doesn't trigger.
-		 */
-		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
+		/* It has to be disabled, so that it doesn't trigger. */
+		acpi_disable_gpe(NULL, ec->gpe);
 	}
 
 	status = acpi_ec_transaction_unlocked(ec, t);
@@ -326,12 +323,8 @@ static int acpi_ec_transaction(struct ac
 	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		msleep(1);
-		/*
-		 * It is safe to enable the GPE outside of the transaction.  Use
-		 * acpi_set_gpe() for that, since we used it to disable the GPE
-		 * above.
-		 */
-		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
+		/* It is safe to enable the GPE outside of the transaction. */
+		acpi_enable_gpe(NULL, ec->gpe);
 	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
 		pr_info(PREFIX "GPE storm detected, "
 			"transactions will use polling mode\n");

