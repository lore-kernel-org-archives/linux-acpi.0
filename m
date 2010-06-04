From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] ACPI / EC / PM: Fix names of functions that block/unblock
 EC transactions
Date: Fri, 04 Jun 2010 15:47:22 -0400
Message-ID: <fe955682d2153b35dffcf1673dff0491096a3f0a.1275680785.git.len.brown@intel.com>
References: <1275680845-8352-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:54318 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0FDTrm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:47:42 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00I159N52JMI@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:47:30 -0500 (CDT)
In-reply-to: <1275680845-8352-1-git-send-email-lenb@kernel.org>
In-reply-to: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
References: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The names of the functions used for blocking/unblocking EC
transactions during suspend/hibernation suggest that the transactions
are suspended and resumed by them, while in fact they are disabled
and enabled.  Rename the functions (and the flag used by them) to
better reflect what they really do.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c       |   16 ++++++++--------
 drivers/acpi/internal.h |    6 +++---
 drivers/acpi/sleep.c    |   12 ++++++------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2c2b73a..3f01f06 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -79,7 +79,7 @@ enum {
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
 	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
-	EC_FLAGS_FROZEN,		/* Transactions are suspended */
+	EC_FLAGS_BLOCKED,		/* Transactions are blocked */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -293,7 +293,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->lock);
-	if (test_bit(EC_FLAGS_FROZEN, &ec->flags)) {
+	if (test_bit(EC_FLAGS_BLOCKED, &ec->flags)) {
 		status = -EINVAL;
 		goto unlock;
 	}
@@ -459,7 +459,7 @@ int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
-void acpi_ec_suspend_transactions(void)
+void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
 
@@ -468,11 +468,11 @@ void acpi_ec_suspend_transactions(void)
 
 	mutex_lock(&ec->lock);
 	/* Prevent transactions from being carried out */
-	set_bit(EC_FLAGS_FROZEN, &ec->flags);
+	set_bit(EC_FLAGS_BLOCKED, &ec->flags);
 	mutex_unlock(&ec->lock);
 }
 
-void acpi_ec_resume_transactions(void)
+void acpi_ec_unblock_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
 
@@ -481,18 +481,18 @@ void acpi_ec_resume_transactions(void)
 
 	mutex_lock(&ec->lock);
 	/* Allow transactions to be carried out again */
-	clear_bit(EC_FLAGS_FROZEN, &ec->flags);
+	clear_bit(EC_FLAGS_BLOCKED, &ec->flags);
 	mutex_unlock(&ec->lock);
 }
 
-void acpi_ec_resume_transactions_early(void)
+void acpi_ec_unblock_transactions_early(void)
 {
 	/*
 	 * Allow transactions to happen again (this function is called from
 	 * atomic context during wakeup, so we don't need to acquire the mutex).
 	 */
 	if (first_ec)
-		clear_bit(EC_FLAGS_FROZEN, &first_ec->flags);
+		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
 }
 
 static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 0ec48c7..f8f190e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -49,9 +49,9 @@ void acpi_early_processor_set_pdc(void);
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
-void acpi_ec_suspend_transactions(void);
-void acpi_ec_resume_transactions(void);
-void acpi_ec_resume_transactions_early(void);
+void acpi_ec_block_transactions(void);
+void acpi_ec_unblock_transactions(void);
+void acpi_ec_unblock_transactions_early(void);
 
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 24741ac..504a55e 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -116,7 +116,7 @@ static int acpi_pm_freeze(void)
 {
 	acpi_disable_all_gpes();
 	acpi_os_wait_events_complete(NULL);
-	acpi_ec_suspend_transactions();
+	acpi_ec_block_transactions();
 	return 0;
 }
 
@@ -279,7 +279,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 */
 	acpi_disable_all_gpes();
 	/* Allow EC transactions to happen. */
-	acpi_ec_resume_transactions_early();
+	acpi_ec_unblock_transactions_early();
 
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -293,7 +293,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 
 static void acpi_suspend_finish(void)
 {
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_pm_finish();
 }
 
@@ -597,7 +597,7 @@ static int acpi_hibernation_enter(void)
 static void acpi_hibernation_finish(void)
 {
 	hibernate_nvs_free();
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_pm_finish();
 }
 
@@ -619,12 +619,12 @@ static void acpi_hibernation_leave(void)
 	/* Restore the NVS memory area */
 	hibernate_nvs_restore();
 	/* Allow EC transactions to happen. */
-	acpi_ec_resume_transactions_early();
+	acpi_ec_unblock_transactions_early();
 }
 
 static void acpi_pm_thaw(void)
 {
-	acpi_ec_resume_transactions();
+	acpi_ec_unblock_transactions();
 	acpi_enable_all_runtime_gpes();
 }
 
-- 
1.6.0.6

