From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/2] ACPI: EC: Make the GPE storm threshold a module parameter
Date: Fri, 28 Sep 2012 15:22:00 +0800
Message-ID: <1348816921-2637-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16437 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab2I1H2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2012 03:28:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Francesco <trentini@dei.unipd.it>, Feng Tang <feng.tang@intel.com>

Different EC hardwares have different behaviors for the GPE storm
detection, some requires the storm threshold to be low to work fine,
and some need a higher value to work ok.

The ACPI_EC_STORM_THRESHOLD was initially 20 when it's created, and
was changed to 8 in commit 06cf7d3c7 "ACPI: EC: lower interrupt storm
threshold" to fix kernel bug 11892 by forcing the laptop in that bug to
work in polling mode. However in bug 45151, it works fine in interrupt
mode if we lift the threshold back to 20.

This patch makes the threshold a module parameter so that user has a
flexible option to chose a number according to their specific EC HW.
It doesn't affect current EC behavior.

This is also a preparation patch to solve kernel bug:
	https://bugzilla.kernel.org/show_bug.cgi?id=45151

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/ec.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7edaccc..615264c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -71,9 +71,6 @@ enum ec_command {
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 #define ACPI_EC_MSI_UDELAY	550	/* Wait 550us for MSI EC */
 
-#define ACPI_EC_STORM_THRESHOLD 8	/* number of false interrupts
-					   per one transaction */
-
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
@@ -87,6 +84,15 @@ static unsigned int ec_delay __read_mostly = ACPI_EC_DELAY;
 module_param(ec_delay, uint, 0644);
 MODULE_PARM_DESC(ec_delay, "Timeout(ms) waited until an EC command completes");
 
+/*
+ * If the number of false interrupts per one transaction exceeds
+ * this threshold, will think there is a GPE storm happened and
+ * will disable the GPE for normal transaction.
+ */
+static unsigned int ec_storm_threshold  __read_mostly = 8;
+module_param(ec_storm_threshold, uint, 0644);
+MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
+
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 /* External interfaces use first EC only, so remember */
 typedef int (*acpi_ec_query_func) (void *data);
@@ -319,7 +325,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 		msleep(1);
 		/* It is safe to enable the GPE outside of the transaction. */
 		acpi_enable_gpe(NULL, ec->gpe);
-	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
+	} else if (t->irq_count > ec_storm_threshold) {
 		pr_info(PREFIX "GPE storm detected, "
 			"transactions will use polling mode\n");
 		set_bit(EC_FLAGS_GPE_STORM, &ec->flags);
-- 
1.7.1

