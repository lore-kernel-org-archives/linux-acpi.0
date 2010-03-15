From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/34] ACPI / EC / PM: Close race between EC and resume from
 hibernation
Date: Sun, 14 Mar 2010 21:40:53 -0400
Message-ID: <f6bb13aa1ea3bb26a4c783822347873f085b9000.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:64690 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab0COBz4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:55:56 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00K9MW0MZXP4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:55:35 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There is a race between resume from hibernation and the EC driver
that may result in restoring the hibernation image in the middle of
an EC transaction in progress, which in turn may lead to
unpredictable behavior of the platform.

To remove that race condition, add a helpers for suspending and
resuming EC transactions in a safe way to be executed by the ACPI
platform hibernate pre-restore and restore cleanup callbacks.

http://bugzilla.kernel.org/show_bug.cgi?id=14668

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c       |   33 ++++++++++++++++++++++++++++++++-
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/sleep.c    |   19 ++++++++++++++-----
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d6471bb..19f93e1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -76,8 +76,9 @@ enum ec_command {
 enum {
 	EC_FLAGS_QUERY_PENDING,		/* Query is pending */
 	EC_FLAGS_GPE_STORM,		/* GPE storm detected */
-	EC_FLAGS_HANDLERS_INSTALLED	/* Handlers for GPE and
+	EC_FLAGS_HANDLERS_INSTALLED,	/* Handlers for GPE and
 					 * OpReg are installed */
+	EC_FLAGS_FROZEN,		/* Transactions are suspended */
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -291,6 +292,10 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	if (t->rdata)
 		memset(t->rdata, 0, t->rlen);
 	mutex_lock(&ec->lock);
+	if (test_bit(EC_FLAGS_FROZEN, &ec->flags)) {
+		status = -EINVAL;
+		goto unlock;
+	}
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status)) {
@@ -445,6 +450,32 @@ int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
+void acpi_ec_suspend_transactions(void)
+{
+	struct acpi_ec *ec = first_ec;
+
+	if (!ec)
+		return;
+
+	mutex_lock(&ec->lock);
+	/* Prevent transactions from being carried out */
+	set_bit(EC_FLAGS_FROZEN, &ec->flags);
+	mutex_unlock(&ec->lock);
+}
+
+void acpi_ec_resume_transactions(void)
+{
+	struct acpi_ec *ec = first_ec;
+
+	if (!ec)
+		return;
+
+	mutex_lock(&ec->lock);
+	/* Allow transactions to be carried out again */
+	clear_bit(EC_FLAGS_FROZEN, &ec->flags);
+	mutex_unlock(&ec->lock);
+}
+
 static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
 {
 	int result;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index cb28e05..7874246 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -51,6 +51,8 @@ void acpi_early_processor_set_pdc(void);
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_boot_ec_enable(void);
+void acpi_ec_suspend_transactions(void);
+void acpi_ec_resume_transactions(void);
 
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 79d33d9..f01f8e8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -552,8 +552,17 @@ static void acpi_hibernation_leave(void)
 	hibernate_nvs_restore();
 }
 
-static void acpi_pm_enable_gpes(void)
+static int acpi_pm_pre_restore(void)
 {
+	acpi_disable_all_gpes();
+	acpi_os_wait_events_complete(NULL);
+	acpi_ec_suspend_transactions();
+	return 0;
+}
+
+static void acpi_pm_restore_cleanup(void)
+{
+	acpi_ec_resume_transactions();
 	acpi_enable_all_runtime_gpes();
 }
 
@@ -565,8 +574,8 @@ static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_pm_disable_gpes,
-	.restore_cleanup = acpi_pm_enable_gpes,
+	.pre_restore = acpi_pm_pre_restore,
+	.restore_cleanup = acpi_pm_restore_cleanup,
 };
 
 /**
@@ -618,8 +627,8 @@ static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
-	.pre_restore = acpi_pm_disable_gpes,
-	.restore_cleanup = acpi_pm_enable_gpes,
+	.pre_restore = acpi_pm_pre_restore,
+	.restore_cleanup = acpi_pm_restore_cleanup,
 	.recover = acpi_pm_finish,
 };
 #endif /* CONFIG_HIBERNATION */
-- 
1.7.0.2.201.g80978

