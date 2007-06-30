From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 9/9] PM: Rename hibernation_ops to platform_hibernation_ops
Date: Sat, 30 Jun 2007 23:11:58 +0200
Message-ID: <200706302311.59630.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35226 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbXF3VGI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Jun 2007 17:06:08 -0400
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

Rename 'struct hibernation_ops' to 'struct platform_hibernation_ops' in analogy
with 'struct platform_suspend_ops'.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    2 +-
 include/linux/suspend.h   |    8 ++++----
 kernel/power/disk.c       |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc6-mm1/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/drivers/acpi/sleep/main.c	2007-06-30 21:14:44.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/acpi/sleep/main.c	2007-06-30 21:14:54.000000000 +0200
@@ -251,7 +251,7 @@ static void acpi_hibernation_restore_cle
 	acpi_hw_enable_all_runtime_gpes();
 }
 
-static struct hibernation_ops acpi_hibernation_ops = {
+static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.start = acpi_hibernation_start,
 	.pre_snapshot = acpi_hibernation_prepare,
 	.finish = acpi_hibernation_finish,
Index: linux-2.6.22-rc6-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/include/linux/suspend.h	2007-06-30 21:14:44.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/linux/suspend.h	2007-06-30 21:14:54.000000000 +0200
@@ -126,7 +126,7 @@ extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 /**
- * struct hibernation_ops - hibernation platform support
+ * struct platform_hibernation_ops - hibernation platform support
  *
  * The methods in this structure allow a platform to override the default
  * mechanism of shutting down the machine during a hibernation transition.
@@ -163,7 +163,7 @@ extern void mark_free_pages(struct zone 
  *	Called right after the nonboot CPUs have been enabled and before
  *	thawing devices (runs with IRQs on).
  */
-struct hibernation_ops {
+struct platform_hibernation_ops {
 	int (*start)(void);
 	int (*pre_snapshot)(void);
 	void (*finish)(void);
@@ -190,14 +190,14 @@ extern void swsusp_set_page_free(struct 
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
 
-extern void hibernation_set_ops(struct hibernation_ops *ops);
+extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 #else /* CONFIG_SOFTWARE_SUSPEND */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
 
-static inline void hibernation_set_ops(struct hibernation_ops *ops) {}
+static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
 #endif /* CONFIG_SOFTWARE_SUSPEND */
 
Index: linux-2.6.22-rc6-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/disk.c	2007-06-30 21:14:44.000000000 +0200
+++ linux-2.6.22-rc6-mm1/kernel/power/disk.c	2007-06-30 21:14:54.000000000 +0200
@@ -45,14 +45,14 @@ enum {
 
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
-static struct hibernation_ops *hibernation_ops;
+static struct platform_hibernation_ops *hibernation_ops;
 
 /**
  * hibernation_set_ops - set the global hibernate operations
  * @ops: the hibernation operations to use in subsequent hibernation transitions
  */
 
-void hibernation_set_ops(struct hibernation_ops *ops)
+void hibernation_set_ops(struct platform_hibernation_ops *ops)
 {
 	if (ops && !(ops->start && ops->pre_snapshot && ops->finish
 	    && ops->prepare && ops->enter && ops->pre_restore
