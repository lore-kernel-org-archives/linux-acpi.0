From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 7/9] PM: Make suspend_ops static
Date: Sat, 30 Jun 2007 23:09:57 +0200
Message-ID: <200706302309.58612.rjw@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35227 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbXF3VGG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Jun 2007 17:06:06 -0400
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

From: Rafael J. Wysocki <rjw@sisk.pl>

The variable suspend_ops representing the set of global platform-specific
suspend-related operations, used by the PM core, need not be exported outside of
kernel/power/main.c .  Make it static.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |    2 --
 kernel/power/main.c     |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.22-rc6-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6-mm1.orig/include/linux/suspend.h	2007-06-30 21:21:15.000000000 +0200
+++ linux-2.6.22-rc6-mm1/include/linux/suspend.h	2007-06-30 21:21:33.000000000 +0200
@@ -77,8 +77,6 @@ struct platform_suspend_ops {
 	void (*finish)(void);
 };
 
-extern struct platform_suspend_ops *suspend_ops;
-
 #ifdef CONFIG_PM
 /**
  * suspend_set_ops - set platform dependent suspend operations
Index: linux-2.6.22-rc6-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/power/main.c	2007-06-30 21:21:01.000000000 +0200
+++ linux-2.6.22-rc6-mm1/kernel/power/main.c	2007-06-30 21:21:33.000000000 +0200
@@ -30,7 +30,7 @@ BLOCKING_NOTIFIER_HEAD(pm_chain_head);
 
 DEFINE_MUTEX(pm_mutex);
 
-struct platform_suspend_ops *suspend_ops;
+static struct platform_suspend_ops *suspend_ops;
 
 /**
  *	suspend_set_ops - Set the global suspend method table.

