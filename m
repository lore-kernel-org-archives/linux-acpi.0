From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 6/9] PM: Fix compilation of suspend code if CONFIG_PM is unset
Date: Sat, 30 Jun 2007 23:08:53 +0200
Message-ID: <200706302308.55223.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35227 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbXF3VGH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Jun 2007 17:06:07 -0400
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some platforms, particualrly in the ARM tree, require that suspend_set_ops() and
pm_suspend() be defined even if CONFIG_PM is not set.  Make this requirement be
satisfied.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.22-rc6/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/suspend.h	2007-06-29 22:42:55.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/suspend.h	2007-06-29 22:43:37.000000000 +0200
@@ -79,6 +79,7 @@ struct platform_suspend_ops {
 
 extern struct platform_suspend_ops *suspend_ops;
 
+#ifdef CONFIG_PM
 /**
  * suspend_set_ops - set platform dependent suspend operations
  * @ops: The new suspend operations to set.
@@ -105,6 +106,12 @@ extern void arch_suspend_disable_irqs(vo
 extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
+#else /* CONFIG_PM */
+#define suspend_valid_only_mem	NULL
+
+static inline void suspend_set_ops(struct platform_suspend_ops *ops) {}
+static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+#endif /* CONFIG_PM */
 
 /* struct pbe is used for creating lists of pages that should be restored
  * atomically during the resume from disk, because the page frames they have

