From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/9] Suspend: Fix compilation warning for CONFIG_SUSPEND unset
Date: Sat, 8 Dec 2007 02:03:26 +0100
Message-ID: <200712080203.26752.rjw@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38230 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbXLHAzm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 19:55:42 -0500
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Suspend: Make debug facility depend on CONFIG_SUSPEND

Make the new suspend debug facility code depend on CONFIG_SUSPEND,
as appropriate, to remove the compiler warning printed when CONFIG_PM is set
and CONFIG_SUSPEND is not set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -52,6 +52,8 @@ int pm_notifier_call_chain(unsigned long
 
 #endif /* CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_SUSPEND
+
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -125,9 +127,6 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
-
-#ifdef CONFIG_SUSPEND
-
 /* This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)
 
