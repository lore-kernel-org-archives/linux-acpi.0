From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/7] Hibernation: Introduce begin() and end() callbacks
Date: Tue, 8 Jan 2008 00:08:44 +0100
Message-ID: <200801080008.45569.rjw@sisk.pl>
References: <200801080002.25044.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38865 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063AbYAGXKV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2008 18:10:21 -0500
In-Reply-To: <200801080002.25044.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce global hibernation callback .end() and rename global
hibernation callback .start() to .begin(), in analogy with the
recent modifications of the global suspend callbacks.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   14 ++++++++++++--
 include/linux/suspend.h   |   14 +++++++++-----
 kernel/power/disk.c       |   33 ++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 16 deletions(-)

Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -136,14 +136,17 @@ extern void mark_free_pages(struct zone 
 /**
  * struct platform_hibernation_ops - hibernation platform support
  *
- * The methods in this structure allow a platform to override the default
- * mechanism of shutting down the machine during a hibernation transition.
+ * The methods in this structure allow a platform to carry out special
+ * operations required by it during a hibernation transition.
  *
- * All three methods must be assigned.
+ * All the methods below must be implemented.
  *
- * @start: Tell the platform driver that we're starting hibernation.
+ * @begin: Tell the platform driver that we're starting hibernation.
  *	Called right after shrinking memory and before freezing devices.
  *
+ * @end: Called by the PM core right after resuming devices, to indicate to
+ *	the platform that the system has returned to the working state.
+ *
  * @pre_snapshot: Prepare the platform for creating the hibernation image.
  *	Called right after devices have been frozen and before the nonboot
  *	CPUs are disabled (runs with IRQs on).
@@ -178,7 +181,8 @@ extern void mark_free_pages(struct zone 
  *	thawing devices (runs with IRQs on).
  */
 struct platform_hibernation_ops {
-	int (*start)(void);
+	int (*begin)(void);
+	void (*end)(void);
 	int (*pre_snapshot)(void);
 	void (*finish)(void);
 	int (*prepare)(void);
Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -54,8 +54,8 @@ static struct platform_hibernation_ops *
 
 void hibernation_set_ops(struct platform_hibernation_ops *ops)
 {
-	if (ops && !(ops->start && ops->pre_snapshot && ops->finish
-	    && ops->prepare && ops->enter && ops->pre_restore
+	if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
+	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
 	    && ops->restore_cleanup)) {
 		WARN_ON(1);
 		return;
@@ -100,14 +100,25 @@ static int hibernation_test(int level) {
 #endif /* !CONFIG_PM_DEBUG */
 
 /**
- *	platform_start - tell the platform driver that we're starting
+ *	platform_begin - tell the platform driver that we're starting
  *	hibernation
  */
 
-static int platform_start(int platform_mode)
+static int platform_begin(int platform_mode)
 {
 	return (platform_mode && hibernation_ops) ?
-		hibernation_ops->start() : 0;
+		hibernation_ops->begin() : 0;
+}
+
+/**
+ *	platform_end - tell the platform driver that we've entered the
+ *	working state
+ */
+
+static void platform_end(int platform_mode)
+{
+	if (platform_mode && hibernation_ops)
+		hibernation_ops->end();
 }
 
 /**
@@ -237,9 +248,9 @@ int hibernation_snapshot(int platform_mo
 	if (error)
 		return error;
 
-	error = platform_start(platform_mode);
+	error = platform_begin(platform_mode);
 	if (error)
-		return error;
+		goto Close;
 
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
@@ -272,6 +283,8 @@ int hibernation_snapshot(int platform_mo
 	device_resume();
  Resume_console:
 	resume_console();
+ Close:
+	platform_end(platform_mode);
 	return error;
 }
 
@@ -373,9 +386,9 @@ int hibernation_platform_enter(void)
 	 * hibernation_ops->finish() before saving the image, so we should let
 	 * the firmware know that we're going to enter the sleep state after all
 	 */
-	error = hibernation_ops->start();
+	error = hibernation_ops->begin();
 	if (error)
-		return error;
+		goto Close;
 
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
@@ -409,6 +422,8 @@ int hibernation_platform_enter(void)
 	device_resume();
  Resume_console:
 	resume_console();
+ Close:
+	hibernation_ops->end();
 	return error;
 }
 
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -281,7 +281,7 @@ static struct dmi_system_id __initdata a
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
-static int acpi_hibernation_start(void)
+static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
 	return 0;
@@ -341,6 +341,15 @@ static void acpi_hibernation_finish(void
 	acpi_target_sleep_state = ACPI_STATE_S0;
 }
 
+static void acpi_hibernation_end(void)
+{
+	/*
+	 * This is necessary in case acpi_hibernation_finish() is not called
+	 * during a failing transition to the sleep state.
+	 */
+	acpi_target_sleep_state = ACPI_STATE_S0;
+}
+
 static int acpi_hibernation_pre_restore(void)
 {
 	acpi_status status;
@@ -356,7 +365,8 @@ static void acpi_hibernation_restore_cle
 }
 
 static struct platform_hibernation_ops acpi_hibernation_ops = {
-	.start = acpi_hibernation_start,
+	.begin = acpi_hibernation_begin,
+	.end = acpi_hibernation_end,
 	.pre_snapshot = acpi_hibernation_prepare,
 	.finish = acpi_hibernation_finish,
 	.prepare = acpi_hibernation_prepare,
